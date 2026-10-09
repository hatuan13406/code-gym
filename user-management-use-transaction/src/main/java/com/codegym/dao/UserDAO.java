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
     * Inserts a User and all selected permissions in ONE connection/transaction.
     * If any insert fails (including a foreign key violation), the User insert
     * is rolled back as well. Existing stored-procedure methods are preserved.
     */
    @Override
    public void addUserTransaction(User user, int[] permissionIds) throws SQLException {
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
                        throw new SQLException("Inserting user did not affect exactly one row.");
                    }
                    try (ResultSet keys = pstmtUser.getGeneratedKeys()) {
                        if (!keys.next()) {
                            throw new SQLException("No generated id was returned for new user.");
                        }
                        userId = keys.getInt(1);
                    }
                }

                if (permissionIds != null && permissionIds.length > 0) {
                    try (PreparedStatement pstmtAssignment =
                                 connection.prepareStatement(INSERT_PERMISSION_SQL)) {
                        for (int permissionId : permissionIds) {
                            pstmtAssignment.setInt(1, userId);
                            pstmtAssignment.setInt(2, permissionId);
                            pstmtAssignment.executeUpdate();
                        }
                    }
                }

                connection.commit();
            } catch (SQLException | RuntimeException e) {
                try {
                    connection.rollback();
                } catch (SQLException rollbackError) {
                    e.addSuppressed(rollbackError);
                }
                throw e; // Do not silently report success to the Servlet.
            }
            // The connection is closed by try-with-resources; it is not reused.
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

    @Override
    public List<User> selectAllUsers() throws SQLException {
        List<User> users = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(SELECT_ALL_SQL);
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
     * Delete assigned permissions before their User, within one transaction,
     * so the user_permission foreign key does not break the existing Delete action.
     */
    @Override
    public boolean deleteUser(int id) throws SQLException {
        try (Connection connection = getConnection()) {
            connection.setAutoCommit(false);
            try {
                try (PreparedStatement pstmtAssignment =
                             connection.prepareStatement(DELETE_USER_PERMISSIONS_SQL)) {
                    pstmtAssignment.setInt(1, id);
                    pstmtAssignment.executeUpdate();
                }

                boolean deleted;
                try (PreparedStatement pstmtUser = connection.prepareStatement(DELETE_SQL)) {
                    pstmtUser.setInt(1, id);
                    deleted = pstmtUser.executeUpdate() > 0;
                }

                connection.commit();
                return deleted;
            } catch (SQLException | RuntimeException e) {
                try {
                    connection.rollback();
                } catch (SQLException rollbackError) {
                    e.addSuppressed(rollbackError);
                }
                throw e;
            }
        }
    }

    @Override
    public boolean updateUser(User user) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(UPDATE_SQL)) {
            statement.setString(1, user.getName());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getCountry());
            statement.setInt(4, user.getId());
            return statement.executeUpdate() > 0;
        }
    }

    private User mapUser(ResultSet rs) throws SQLException {
        return new User(rs.getInt("id"), rs.getString("name"),
                rs.getString("email"), rs.getString("country"));
    }
}
