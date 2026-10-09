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

    private void listUsers(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String country = clean(request.getParameter("country"));
        String sort = clean(request.getParameter("sort")).toLowerCase(java.util.Locale.ROOT);

        // Only allow known values to select the ordering mode.
        if (!"asc".equals(sort) && !"desc".equals(sort)) {
            sort = "id";
        }

        List<User> users = userDAO.findUsers(country, sort);
        request.setAttribute("listUser", users);
        request.setAttribute("country", country);
        request.setAttribute("sort", sort);
        show(request, response, "/user/list.jsp");
    }

    private void showUserForm(HttpServletRequest request, HttpServletResponse response, String jsp)
            throws SQLException, ServletException, IOException {
        int id = parseId(request.getParameter("id"));
        User user = id > 0 ? userDAO.selectUser(id) : null;
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
        if (!valid(user)) {
            request.setAttribute("user", user);
            request.setAttribute("error", "Vui lòng nhập tên và email hợp lệ, đúng giới hạn độ dài.");
            show(request, response, "/user/create.jsp");
            return;
        }
        userDAO.insertUser(user);
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
        if (!userDAO.updateUser(user)) {
            notFound(request, response);
            return;
        }
        redirectToList(request, response, "updated");
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = parseId(request.getParameter("id"));
        if (id < 1 || !userDAO.deleteUser(id)) {
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
