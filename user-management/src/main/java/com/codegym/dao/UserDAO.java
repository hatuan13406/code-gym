package com.codegym.dao;

import com.codegym.model.User;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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

    private static final String INSERT_SQL =
            "INSERT INTO users (name, email, country) VALUES (?, ?, ?)";
    private static final String SELECT_BY_ID_SQL =
            "SELECT id, name, email, country FROM users WHERE id = ?";
    private static final String SELECT_ALL_SQL =
            "SELECT id, name, email, country FROM users ORDER BY id";
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

    @Override
    public void insertUser(User user) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(INSERT_SQL)) {
            statement.setString(1, user.getName());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getCountry());
            statement.executeUpdate();
        }
    }

    @Override
    public User selectUser(int id) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(SELECT_BY_ID_SQL)) {
            statement.setInt(1, id);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return mapUser(rs);
                }
                return null;
            }
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
        return findUsers(country, "id");
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

    @Override
    public boolean deleteUser(int id) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(DELETE_SQL)) {
            statement.setInt(1, id);
            return statement.executeUpdate() > 0;
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
