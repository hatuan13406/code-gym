package com.codegym.dao;

import com.codegym.model.User;
import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * JDBC data access layer for the MySQL users table.
 *
 * Set DB_URL, DB_USER and DB_PASSWORD environment variables before starting Tomcat.
 * Defaults target a local development server with database 'demo'.
 * Never store real database passwords in source control.
 */
public class UserDAO implements IUserDAO {
    private static final String DEFAULT_URL =
            "jdbc:mysql://localhost:3306/demo?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC";

    // Intentionally broken SQL exercise: auto-commit does NOT roll back earlier inserts.
    private static final String SQL_INSERT =
            "INSERT INTO Employee (name, salary, created_Date) VALUES (?, ?, ?)";
    private static final String SQL_UPDATE =
            "UPDATE Employee SET salary = ? WHERE name = ?";
    private static final String SQL_TABLE_CREATE =
            "CREATE TABLE IF NOT EXISTS Employee ("
            + "id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, "
            + "name VARCHAR(120) NOT NULL, "
            + "salary DECIMAL(15,2) NOT NULL, "
            + "created_Date DATETIME"
            + ")";
    private static final String SQL_TABLE_DROP = "DROP TABLE IF EXISTS Employee";
    // The successful run updates ONLY the row generated during this run.
    // This avoids modifying Quynh rows that belong to the previous exercise.
    private static final String SQL_UPDATE_BY_ID =
            "UPDATE Employee SET salary = ? WHERE id = ?";

    private static final String SELECT_ALL_SQL =
            "SELECT id, name, email, country FROM users ORDER BY name ASC, id ASC";
    private static final String INSERT_USER_SQL =
            "INSERT INTO users (name, email, country) VALUES (?, ?, ?)";
    private static final String INSERT_PERMISSION_SQL =
            "INSERT INTO user_permission (user_id, permission_id) VALUES (?, ?)";
    private static final String DELETE_USER_PERMISSIONS_SQL =
            "DELETE FROM user_permission WHERE user_id = ?";
    private static final String DELETE_SQL =
            "DELETE FROM users WHERE id = ?";
    private static final String UPDATE_SQL =
            "UPDATE users SET name = ?, email = ?, country = ? WHERE id = ?";

    protected Connection getConnection() throws SQLException {
        String url = System.getenv().getOrDefault("DB_URL", DEFAULT_URL);
        String username = System.getenv().getOrDefault("DB_USER", "root");
        String password = System.getenv().getOrDefault("DB_PASSWORD", "");
        return DriverManager.getConnection(url, username, password);
    }

    /**
     * Keep the existing CRUD API compatible, but insert via the stored procedure.
     */
    @Override
    public void insertUser(User user) throws SQLException {
        insertUserStore(user);
    }

    /**
     * Keep the existing CRUD API compatible, but look up via the stored procedure.
     */
    @Override
    public User selectUser(int id) throws SQLException {
        return getUserById(id);
    }

    /**
     * Finds one user using MySQL's get_user_by_id(IN user_id INT).
     * Returns null if no matching user exists.
     */
    @Override
    public User getUserById(int id) throws SQLException {
        String sql = "{CALL get_user_by_id(?)}";

        try (Connection connection = getConnection();
             CallableStatement statement = connection.prepareCall(sql)) {
            statement.setInt(1, id);

            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return new User(id, rs.getString("name"),
                            rs.getString("email"), rs.getString("country"));
                }
            }
        }
        return null;
    }

    /**
     * Inserts a user using MySQL's insert_user(IN name, IN email, IN country).
     */
    @Override
    public void insertUserStore(User user) throws SQLException {
        String sql = "{CALL insert_user(?, ?, ?)}";

        try (Connection connection = getConnection();
             CallableStatement statement = connection.prepareCall(sql)) {
            statement.setString(1, user.getName());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getCountry());
            statement.executeUpdate();
        }
    }

    /**
     * Regular Create flow: user and permissions are saved together or not at all.
     */
    @Override
    public void addUserTransaction(User user, int[] permissionIds) throws SQLException {
        addUserTransaction(user, permissionIds, false);
    }

    /**
     * Transaction exercise:
     * 1. Turn OFF auto-commit.
     * 2. INSERT a User and get its generated ID.
     * 3. INSERT valid permissions.
     * 4. In demo mode only, deliberately execute invalid SQL AFTER the INSERTs.
     * 5. COMMIT on success, ROLLBACK on any SQLException.
     *
     * simulateSqlError MUST be false in normal CRUD operations.
     * The demo never destroys or edits an existing user.
     */
    @Override
    public void addUserTransaction(User user, int[] permissionIds, boolean simulateSqlError)
            throws SQLException {
        try (Connection connection = getConnection()) {
            connection.setAutoCommit(false);

            try {
                int userId;
                try (PreparedStatement pstmtUser = connection.prepareStatement(
                        INSERT_USER_SQL, Statement.RETURN_GENERATED_KEYS)) {
                    pstmtUser.setString(1, user.getName());
                    pstmtUser.setString(2, user.getEmail());
                    pstmtUser.setString(3, user.getCountry());

                    if (pstmtUser.executeUpdate() != 1) {
                        throw new SQLException("INSERT users did not create exactly one row.");
                    }
                    try (ResultSet generatedKeys = pstmtUser.getGeneratedKeys()) {
                        if (!generatedKeys.next()) {
                            throw new SQLException("No generated user ID was returned.");
                        }
                        userId = generatedKeys.getInt(1);
                    }
                }

                if (permissionIds != null && permissionIds.length > 0) {
                    try (PreparedStatement pstmtPermissions =
                                 connection.prepareStatement(INSERT_PERMISSION_SQL)) {
                        for (int permissionId : permissionIds) {
                            pstmtPermissions.setInt(1, userId);
                            pstmtPermissions.setInt(2, permissionId);
                            pstmtPermissions.executeUpdate();
                        }
                    }
                }

                if (simulateSqlError) {
                    // INTENTIONAL SQL ERROR for the lesson:
                    // user_permission has NO COLUMN called invalid_permission_column.
                    // MySQL throws error 1054 / SQLState 42S22.
                    // The two previous INSERTs are still uncommitted.
                    String invalidSql = "INSERT INTO user_permission "
                            + "(user_id, invalid_permission_column) VALUES (?, ?)";
                    try (PreparedStatement broken = connection.prepareStatement(invalidSql)) {
                        broken.setInt(1, userId);
                        broken.setInt(2, 1);
                        broken.executeUpdate(); // Expected SQLException -> rollback below.
                    }
                }

                connection.commit();
                System.out.println("TRANSACTION COMMIT: User and permissions were saved.");
            } catch (SQLException | RuntimeException error) {
                try {
                    connection.rollback();
                    System.out.println("TRANSACTION ROLLBACK: User and permissions were NOT saved.");
                } catch (SQLException rollbackError) {
                    error.addSuppressed(rollbackError);
                }
                throw error;
            }
            // Connection closes automatically; no uncommitted changes are kept.
        }
    }

    /** Read-only check used to verify the intentionally failed transaction. */
    @Override
    public boolean userExistsByEmail(String email) throws SQLException {
        String sql = "SELECT COUNT(*) FROM users WHERE email = ?";
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, email);
            try (ResultSet results = statement.executeQuery()) {
                if (!results.next()) {
                    throw new SQLException("COUNT query returned no rows.");
                }
                return results.getInt(1) > 0;
            }
        }
    }

    /**
     * Educational demo ONLY, never for production business operations.
     * Using auto-commit (not a transaction), two INSERTs remain committed even
     * though the intentionally mis-bound UPDATE fails afterward.
     *
     * To avoid destroying existing Employee records, the table is NOT dropped
     * by default. Explicitly opt into resetting this demo table with the
     * ALLOW_EMPLOYEE_DEMO_RESET=true environment variable before starting Tomcat.
     */
    @Override
    public void insertUpdateWithoutTransaction() throws SQLException {
        try (Connection conn = getConnection();
             Statement statement = conn.createStatement()) {
            conn.setAutoCommit(true);

            // Explicit opt-in only: DROP permanently deletes any existing rows.
            if ("true".equalsIgnoreCase(
                    System.getenv().getOrDefault("ALLOW_EMPLOYEE_DEMO_RESET", "false"))) {
                statement.execute(SQL_TABLE_DROP);
            }
            statement.execute(SQL_TABLE_CREATE);

            try (PreparedStatement psInsert = conn.prepareStatement(SQL_INSERT);
                 PreparedStatement psUpdate = conn.prepareStatement(SQL_UPDATE)) {
                Timestamp created = Timestamp.valueOf(LocalDateTime.now());

                psInsert.setString(1, "Quynh");
                psInsert.setBigDecimal(2, BigDecimal.valueOf(10));
                psInsert.setTimestamp(3, created);
                psInsert.executeUpdate();

                psInsert.setString(1, "Ngan");
                psInsert.setBigDecimal(2, BigDecimal.valueOf(20));
                psInsert.setTimestamp(3, created);
                psInsert.executeUpdate();

                // Deliberate error: parameter 1 (salary) is never assigned!
                // Index 2 is the name parameter; assigning it twice is wrong.
                psUpdate.setBigDecimal(2, BigDecimal.valueOf(999.99));
                psUpdate.setString(2, "Quynh");
                try {
                    psUpdate.executeUpdate();
                    throw new SQLException("Expected the malformed UPDATE to fail.");
                } catch (SQLException expected) {
                    System.out.println("Expected UPDATE error in no-transaction demo:");
                    expected.printStackTrace();
                    // Crucially, no rollback: both earlier INSERTs are committed.
                }
            }
        }
    }

    /**
     * Transaction exercise: intentionally fails in the UPDATE.
     * Both newly inserted Employee records are rolled back.
     */
    @Override
    public void insertUpdateUseTransaction() throws SQLException {
        insertUpdateUseTransaction(false);
    }

    /**
     * Runs two INSERTs and one UPDATE as a single transaction.
     *
     * When corrected=false, a deliberately missing parameter makes the
     * UPDATE fail and explicitly rolls back both INSERTs.
     * When corrected=true, the UPDATE targets the new Quynh id, then commits.
     *
     * No table DROP is performed: changing database schema with DDL inside a
     * transaction causes an implicit MySQL COMMIT, and would break this demo.
     */
    @Override
    public void insertUpdateUseTransaction(boolean corrected) throws SQLException {
        try (Connection conn = getConnection();
             Statement statement = conn.createStatement()) {

            // Set up the table BEFORE turning off auto-commit. Never erase old rows.
            statement.execute(SQL_TABLE_CREATE);
            conn.setAutoCommit(false);

            try (PreparedStatement psInsert =
                         conn.prepareStatement(SQL_INSERT, Statement.RETURN_GENERATED_KEYS);
                 PreparedStatement psUpdate = conn.prepareStatement(
                         corrected ? SQL_UPDATE_BY_ID : SQL_UPDATE)) {

                Timestamp created = Timestamp.valueOf(LocalDateTime.now());

                psInsert.setString(1, "Quynh");
                psInsert.setBigDecimal(2, BigDecimal.valueOf(10));
                psInsert.setTimestamp(3, created);
                if (psInsert.executeUpdate() != 1) {
                    throw new SQLException("Unable to insert Quynh.");
                }

                int quynhId;
                try (ResultSet generatedKeys = psInsert.getGeneratedKeys()) {
                    if (!generatedKeys.next()) {
                        throw new SQLException("Employee ID was not generated.");
                    }
                    quynhId = generatedKeys.getInt(1);
                }

                psInsert.setString(1, "Ngan");
                psInsert.setBigDecimal(2, BigDecimal.valueOf(20));
                psInsert.setTimestamp(3, created);
                if (psInsert.executeUpdate() != 1) {
                    throw new SQLException("Unable to insert Ngan.");
                }

                if (corrected) {
                    // Correct parameter positions; edit only the newly inserted row.
                    psUpdate.setBigDecimal(1, BigDecimal.valueOf(999.99));
                    psUpdate.setInt(2, quynhId);
                } else {
                    // INTENTIONALLY WRONG for lesson 1: salary parameter #1
                    // is never set. This throws an SQLException at execution.
                    psUpdate.setBigDecimal(2, BigDecimal.valueOf(999.99));
                    psUpdate.setString(2, "Quynh");
                }

                if (psUpdate.executeUpdate() != 1) {
                    throw new SQLException("UPDATE did not affect exactly one employee.");
                }

                conn.commit();
                System.out.println("JDBC transaction COMMIT: two inserts and one update completed.");
            } catch (SQLException | RuntimeException e) {
                try {
                    conn.rollback();
                    System.out.println("JDBC transaction ROLLBACK: no new Employee rows committed.");
                } catch (SQLException rollbackFailure) {
                    e.addSuppressed(rollbackFailure);
                }
                System.err.println("JDBC transaction failed: " + e.getMessage());
                throw e;
            }
            // Closing the connection also releases its transaction resources.
            // Avoid setting autoCommit(true) before handling pending rollback.
        }
    }

    /** Backward-compatible list API, now backed by a stored procedure. */
    @Override
    public List<User> selectAllUsers() throws SQLException {
        return selectAllUsersStore();
    }

    /**
     * Calls get_all_users() and maps its ResultSet to User model objects.
     */
    @Override
    public List<User> selectAllUsersStore() throws SQLException {
        List<User> users = new ArrayList<>();
        String sql = "{CALL get_all_users()}";
        try (Connection connection = getConnection();
             CallableStatement statement = connection.prepareCall(sql);
             ResultSet rs = statement.executeQuery()) {
            while (rs.next()) {
                users.add(mapUser(rs));
            }
        }
        return users;
    }

    /**
     * Finds users by a country substring, for example "Viet" matches "Viet Nam".
     */
    @Override
    public List<User> searchByCountry(String country) throws SQLException {
        return findUsers(country, "asc");
    }

    /** Sorts users by name without filtering by country. */
    @Override
    public List<User> sortByName(boolean ascending) throws SQLException {
        return findUsers("", ascending ? "asc" : "desc");
    }

    /**
     * Uses a PreparedStatement for the user-supplied country search.
     * Sorting is selected only from fixed SQL fragments (never raw user input).
     */
    @Override
    public List<User> findUsers(String country, String sort) throws SQLException {
        String filter = country == null ? "" : country.strip();
        boolean hasFilter = !filter.isEmpty();

        StringBuilder sql = new StringBuilder(
                "SELECT id, name, email, country FROM users");
        if (hasFilter) {
            sql.append(" WHERE LOWER(COALESCE(country, '')) LIKE ? ESCAPE '!'");
        }

        if ("asc".equalsIgnoreCase(sort)) {
            sql.append(" ORDER BY name ASC, id ASC");
        } else if ("desc".equalsIgnoreCase(sort)) {
            sql.append(" ORDER BY name DESC, id DESC");
        } else {
            sql.append(" ORDER BY id ASC");
        }

        List<User> users = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql.toString())) {
            if (hasFilter) {
                // Treat the search value literally, including %, _ and the escape character.
                String escaped = filter.toLowerCase(java.util.Locale.ROOT)
                        .replace("!", "!!")
                        .replace("%", "!%")
                        .replace("_", "!_");
                statement.setString(1, "%" + escaped + "%");
            }

            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    users.add(mapUser(rs));
                }
            }
        }
        return users;
    }

    /**
     * Existing CRUD entry point delegates to the new stored procedure.
     */
    @Override
    public boolean deleteUser(int id) throws SQLException {
        return deleteUserStore(id);
    }

    /**
     * Uses delete_user(IN id, OUT affected_rows), which removes linked
     * permission rows and the user together in a MySQL transaction.
     */
    @Override
    public boolean deleteUserStore(int id) throws SQLException {
        String sql = "{CALL delete_user(?, ?)}";
        try (Connection connection = getConnection();
             CallableStatement statement = connection.prepareCall(sql)) {
            statement.setInt(1, id);
            statement.registerOutParameter(2, java.sql.Types.INTEGER);
            statement.execute();
            return statement.getInt(2) > 0;
        }
    }

    /**
     * Existing CRUD entry point delegates to the new stored procedure.
     */
    @Override
    public boolean updateUser(User user) throws SQLException {
        return updateUserStore(user);
    }

    /**
     * Uses update_user(IN id, IN name, IN email, IN country, OUT affected_rows).
     */
    @Override
    public boolean updateUserStore(User user) throws SQLException {
        String sql = "{CALL update_user(?, ?, ?, ?, ?)}";
        try (Connection connection = getConnection();
             CallableStatement statement = connection.prepareCall(sql)) {
            statement.setInt(1, user.getId());
            statement.setString(2, user.getName());
            statement.setString(3, user.getEmail());
            statement.setString(4, user.getCountry());
            statement.registerOutParameter(5, java.sql.Types.INTEGER);
            statement.execute();
            return statement.getInt(5) > 0;
        }
    }

    private User mapUser(ResultSet rs) throws SQLException {
        return new User(rs.getInt("id"), rs.getString("name"),
                rs.getString("email"), rs.getString("country"));
    }
}
