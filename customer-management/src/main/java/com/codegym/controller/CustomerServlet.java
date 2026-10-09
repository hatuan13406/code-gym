package com.codegym.controller;

import com.codegym.model.Customer;
import com.codegym.service.CustomerService;
import com.codegym.service.CustomerServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Controller MVC: nhận yêu cầu /customers, gọi Service và chuyển sang JSP.
 */
@WebServlet(name = "CustomerServlet", urlPatterns = "/customers")
public class CustomerServlet extends HttpServlet {
    private final CustomerService customerService = new CustomerServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }

        switch (action) {
            case "create":
                showPage(request, response, "/customer/create.jsp");
                break;
            case "edit":
                showCustomerPage(request, response, "/customer/edit.jsp");
                break;
            case "delete":
                showCustomerPage(request, response, "/customer/delete.jsp");
                break;
            case "view":
                showCustomerPage(request, response, "/customer/view.jsp");
                break;
            default:
                listCustomers(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu thao tác.");
            return;
        }

        switch (action) {
            case "create":
                createCustomer(request, response);
                break;
            case "edit":
                updateCustomer(request, response);
                break;
            case "delete":
                deleteCustomer(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thao tác không hợp lệ.");
        }
    }

    private void listCustomers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Customer> customers = customerService.findAll();
        request.setAttribute("customers", customers);
        showPage(request, response, "/customer/list.jsp");
    }

    private void showCustomerPage(HttpServletRequest request, HttpServletResponse response, String jsp)
            throws ServletException, IOException {
        int id = parseId(request.getParameter("id"));
        Customer customer = customerService.findById(id);
        if (customer == null) {
            notFound(request, response);
            return;
        }
        request.setAttribute("customer", customer);
        showPage(request, response, jsp);
    }

    private void createCustomer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Customer customer = customerFromRequest(request, 0);
        if (!isValid(customer)) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ họ tên, email và địa chỉ hợp lệ.");
            request.setAttribute("customer", customer);
            showPage(request, response, "/customer/create.jsp");
            return;
        }
        customerService.save(customer);
        redirectToList(request, response, "created");
    }

    private void updateCustomer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = parseId(request.getParameter("id"));
        if (customerService.findById(id) == null) {
            notFound(request, response);
            return;
        }

        Customer customer = customerFromRequest(request, id);
        if (!isValid(customer)) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ họ tên, email và địa chỉ hợp lệ.");
            request.setAttribute("customer", customer);
            showPage(request, response, "/customer/edit.jsp");
            return;
        }

        customerService.update(id, customer);
        redirectToList(request, response, "updated");
    }

    private void deleteCustomer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = parseId(request.getParameter("id"));
        if (customerService.findById(id) == null) {
            notFound(request, response);
            return;
        }
        customerService.remove(id);
        redirectToList(request, response, "deleted");
    }

    private Customer customerFromRequest(HttpServletRequest request, int id) {
        return new Customer(id,
                normalized(request.getParameter("name")),
                normalized(request.getParameter("email")),
                normalized(request.getParameter("address")));
    }

    private String normalized(String value) {
        return value == null ? "" : value.trim();
    }

    private boolean isValid(Customer customer) {
        String name = customer.getName();
        String email = customer.getEmail();
        String address = customer.getAddress();
        return !name.isBlank() && name.length() <= 100
                && !address.isBlank() && address.length() <= 255
                && !email.isBlank() && email.length() <= 254
                && email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$");
    }

    private int parseId(String value) {
        try {
            int id = Integer.parseInt(value);
            return id > 0 ? id : -1;
        } catch (NumberFormatException e) {
            return -1;
        }
    }

    private void showPage(HttpServletRequest request, HttpServletResponse response, String jsp)
            throws ServletException, IOException {
        request.getRequestDispatcher(jsp).forward(request, response);
    }

    private void notFound(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setStatus(HttpServletResponse.SC_NOT_FOUND);
        showPage(request, response, "/error-404.jsp");
    }

    private void redirectToList(HttpServletRequest request, HttpServletResponse response, String success)
            throws IOException {
        response.sendRedirect(request.getContextPath() + "/customers?success=" + success);
    }
}
