package com.codegym.dao;

import com.codegym.model.User;
import java.sql.SQLException;
import java.util.List;

/** JDBC contract for creating, reading, updating and deleting users. */
public interface IUserDAO {
    void insertUser(User user) throws SQLException;
    User selectUser(int id) throws SQLException;
    List<User> selectAllUsers() throws SQLException;
    boolean deleteUser(int id) throws SQLException;
    boolean updateUser(User user) throws SQLException;
    /** Fetch a user by ID using MySQL stored procedure get_user_by_id. */
    User getUserById(int id) throws SQLException;

    /** Add a user using MySQL stored procedure insert_user. */
    void insertUserStore(User user) throws SQLException;

    /** Insert a user and assign their permissions atomically in one JDBC transaction. */
    void addUserTransaction(User user, int[] permissionIds) throws SQLException;

    /** Demonstrate JDBC auto-commit: two inserts persist even if the later UPDATE fails. */
    void insertUpdateWithoutTransaction() throws SQLException;

    /** Search users by a partial country name (case-insensitive). */
    List<User> searchByCountry(String country) throws SQLException;

    /** Sort all users by name, ascending or descending. */
    List<User> sortByName(boolean ascending) throws SQLException;

    /** Combine the country filter and name sorting in one database query. */
    List<User> findUsers(String country, String sort) throws SQLException;
}
