package com.codegym.controller;

import com.codegym.dao.IUserDAO;
import com.codegym.dao.UserDAO;
import com.codegym.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * MVC controller for MySQL-backed user list, create, edit and delete operations.
 */
@WebServlet(name = "UserServlet", urlPatterns = "/users")
public class UserServlet extends HttpServlet {
    private IUserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }

        try {
            switch (action) {
                case "test-use-tran":
                    testUseTran(request, response);
                    break;
                case "test-without-tran":
                    testWithoutTran(request, response);
                    break;
                case "search":
                    searchUsers(request, response);
                    break;
                case "sort":
                    sortUsers(request, response);
                    break;
                case "create":
                    show(request, response, "/user/create.jsp");
                    break;
                case "edit":
                    showUserForm(request, response, "/user/edit.jsp");
                    break;
                case "delete":
                    showUserForm(request, response, "/user/delete.jsp");
                    break;
                default:
                    listUsers(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException("Cannot load users from MySQL.", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing action.");
            return;
        }
        try {
            switch (action) {
                case "create":
                    insertUser(request, response);
                    break;
                case "edit":
                    updateUser(request, response);
                    break;
                case "delete":
                    deleteUser(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action.");
            }
        } catch (SQLException e) {
            throw new ServletException("Cannot save changes to MySQL.", e);
        }
    }

    /**
     * Demonstrates why auto-commit is not safe for related writes.
     * It deliberately inserts two demo employees and fails a later UPDATE.
     * Restrict this teaching-only, data-changing GET endpoint to localhost.
     */
    private void testWithoutTran(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String ip = request.getRemoteAddr();
        if (!"127.0.0.1".equals(ip) && !"::1".equals(ip)
                && !"0:0:0:0:0:0:0:1".equals(ip)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN,
                    "This destructive JDBC demonstration is only available from localhost.");
            return;
        }
        userDAO.insertUpdateWithoutTransaction();
        response.setContentType("text/plain; charset=UTF-8");
        response.getWriter().println("Da chay demo khong dung Transaction.");
        response.getWriter().println(
                "Hai nhan vien Quynh va Ngan da duoc INSERT. Lenh UPDATE co tinh bi loi.");
        response.getWriter().println(
                "Kiem tra log Tomcat va chay SQL: SELECT * FROM Employee ORDER BY id DESC LIMIT 2;");
        response.getWriter().println(
                "Luu y: lap lai demo se them hai ban ghi moi; du lieu cu khong bi xoa mac dinh.");
    }

    /**
     * Two-phase transaction exercise. The default URL intentionally fails
     * and rolls back; ?mode=success uses the corrected parameter binding.
     * Restrict all changes to local development requests.
     */
    private void testUseTran(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String ip = request.getRemoteAddr();
        if (!"127.0.0.1".equals(ip) && !"::1".equals(ip)
                && !"0:0:0:0:0:0:0:1".equals(ip)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN,
                    "The JDBC transaction demonstration is only available from localhost.");
            return;
        }

        boolean corrected = "success".equalsIgnoreCase(request.getParameter("mode"));
        response.setContentType("text/plain; charset=UTF-8");

        if (corrected) {
            userDAO.insertUpdateUseTransaction(true);
            response.getWriter().println("COMMIT SUCCESS");
            response.getWriter().println(
                    "Inserted Quynh and Ngan, then updated the new Quynh to salary 999.99.");
        } else {
            try {
                // Intentionally fail UPDATE after two inserts; DAO handles rollback.
                userDAO.insertUpdateUseTransaction();
                response.getWriter().println("The demonstration unexpectedly succeeded.");
            } catch (SQLException expected) {
                response.getWriter().println("ROLLBACK DEMO: SQLException occurred.");
                response.getWriter().println("Check the server log for the SQL error.");
                response.getWriter().println(
                        "If the transaction was started successfully, the DAO rolled back both inserts.");
                response.getWriter().println(
                        "Use ?action=test-use-tran&mode=success to test the corrected COMMIT path.");
            }
        }
    }

    /** Displays the list, sorted by name to keep the default order easy to read. */
    private void listUsers(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        showList(request, response, userDAO.selectAllUsersStore(), "", "asc");
    }

    /** Receives the country keyword from the browser and searches with JDBC. */
    private void searchUsers(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String country = clean(request.getParameter("country"));
        String sort = normalizeSort(request.getParameter("sort"));
        List<User> users = "desc".equals(sort)
                ? userDAO.findUsers(country, "desc")
                : userDAO.searchByCountry(country);
        showList(request, response, users, country, sort);
    }

    /** Receives the selected sort direction and sorts user names. */
    private void sortUsers(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String country = clean(request.getParameter("country"));
        String sort = normalizeSort(request.getParameter("sort"));
        List<User> users = country.isEmpty()
                ? userDAO.sortByName(!"desc".equals(sort))
                : userDAO.findUsers(country, sort);
        showList(request, response, users, country, sort);
    }

    private String normalizeSort(String input) {
        return "desc".equalsIgnoreCase(clean(input)) ? "desc" : "asc";
    }

    private void showList(HttpServletRequest request, HttpServletResponse response,
                          List<User> users, String country, String sort)
            throws ServletException, IOException {
        request.setAttribute("listUser", users);
        request.setAttribute("country", country);
        request.setAttribute("sort", sort);
        show(request, response, "/user/list.jsp");
    }

    private void showUserForm(HttpServletRequest request, HttpServletResponse response, String jsp)
            throws SQLException, ServletException, IOException {
        int id = parseId(request.getParameter("id"));
        // The edit form reads its data through the get_user_by_id stored procedure.
        User user = id > 0
                ? ("/user/edit.jsp".equals(jsp) ? userDAO.getUserById(id) : userDAO.selectUser(id))
                : null;
        if (user == null) {
            notFound(request, response);
            return;
        }
        request.setAttribute("user", user);
        show(request, response, jsp);
    }

    private void insertUser(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        User user = readUser(request, 0);
        String[] permissionValues = request.getParameterValues("permissions");
        // Preserve selected checkboxes when the form must be shown again.
        request.setAttribute("selectedPermissions",
                permissionValues == null ? "" : "|" + String.join("|", permissionValues) + "|");

        if (!valid(user)) {
            request.setAttribute("user", user);
            request.setAttribute("error", "Vui lòng nhập tên và email hợp lệ, đúng giới hạn độ dài.");
            show(request, response, "/user/create.jsp");
            return;
        }

        int[] permissionIds;
        try {
            if (permissionValues == null) {
                permissionIds = new int[0]; // No permission is selected.
            } else {
                if (permissionValues.length > 4) {
                    throw new IllegalArgumentException("Too many permissions.");
                }
                permissionIds = new int[permissionValues.length];
                boolean[] seen = new boolean[5];
                for (int i = 0; i < permissionValues.length; i++) {
                    int permissionId = Integer.parseInt(permissionValues[i]);
                    if (permissionId < 1 || permissionId > 4 || seen[permissionId]) {
                        throw new IllegalArgumentException("Invalid permission selection.");
                    }
                    seen[permissionId] = true;
                    permissionIds[i] = permissionId;
                }
            }
        } catch (IllegalArgumentException e) {
            request.setAttribute("user", user);
            request.setAttribute("error", "Quyền hạn không hợp lệ. Vui lòng chọn lại.");
            show(request, response, "/user/create.jsp");
            return;
        }

        // Add both the User and permissions atomically using a JDBC transaction.
        userDAO.addUserTransaction(user, permissionIds);
        redirectToList(request, response, "created");
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = parseId(request.getParameter("id"));
        if (id < 1 || userDAO.selectUser(id) == null) {
            notFound(request, response);
            return;
        }
        User user = readUser(request, id);
        if (!valid(user)) {
            request.setAttribute("user", user);
            request.setAttribute("error", "Vui lòng nhập tên và email hợp lệ, đúng giới hạn độ dài.");
            show(request, response, "/user/edit.jsp");
            return;
        }
        if (!userDAO.updateUserStore(user)) {
            notFound(request, response);
            return;
        }
        redirectToList(request, response, "updated");
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = parseId(request.getParameter("id"));
        if (id < 1 || !userDAO.deleteUserStore(id)) {
            notFound(request, response);
            return;
        }
        redirectToList(request, response, "deleted");
    }

    private User readUser(HttpServletRequest request, int id) {
        return new User(id,
                clean(request.getParameter("name")),
                clean(request.getParameter("email")),
                clean(request.getParameter("country")));
    }

    private String clean(String input) {
        return input == null ? "" : input.strip();
    }

    private boolean valid(User user) {
        return !user.getName().isEmpty()
                && user.getName().length() <= 120
                && user.getEmail().length() <= 220
                && user.getEmail().matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")
                && user.getCountry().length() <= 120;
    }

    private int parseId(String raw) {
        if (raw == null) {
            return -1;
        }
        try {
            int id = Integer.parseInt(raw);
            return id > 0 ? id : -1;
        } catch (NumberFormatException e) {
            return -1;
        }
    }

    private void show(HttpServletRequest request, HttpServletResponse response, String jsp)
            throws ServletException, IOException {
        request.getRequestDispatcher(jsp).forward(request, response);
    }

    private void notFound(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setStatus(HttpServletResponse.SC_NOT_FOUND);
        show(request, response, "/error-404.jsp");
    }

    private void redirectToList(HttpServletRequest request, HttpServletResponse response, String notice)
            throws IOException {
        response.sendRedirect(request.getContextPath() + "/users?notice=" + notice);
    }
}
