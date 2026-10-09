package com.codegym.dao;

import com.codegym.model.User;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
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
