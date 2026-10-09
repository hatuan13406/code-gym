package com.codegym.controller;

import com.codegym.model.Product;
import com.codegym.service.ProductService;
import com.codegym.service.ProductServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;

/**
 * Controller MVC: điều hướng xem danh sách, tìm kiếm, tạo, sửa, xóa và xem sản phẩm.
 */
@WebServlet(name = "ProductServlet", urlPatterns = "/products")
public class ProductServlet extends HttpServlet {
    private final ProductService service = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "create":
                request.setAttribute("product", new Product());
                request.setAttribute("priceInput", "");
                show(request, response, "/product/create.jsp");
                return;
            case "view":
                showProduct(request, response, "/product/view.jsp");
                return;
            case "edit":
                showProduct(request, response, "/product/edit.jsp");
                return;
            case "delete":
                showProduct(request, response, "/product/delete.jsp");
                return;
            case "search":
            case "list":
            default:
                listProducts(request, response);
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
                createProduct(request, response);
                break;
            case "edit":
                updateProduct(request, response);
                break;
            case "delete":
                deleteProduct(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thao tác không hợp lệ.");
        }
    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        if (keyword == null) {
            keyword = "";
        }
        request.setAttribute("keyword", keyword);
        request.setAttribute("products", service.searchByName(keyword));
        show(request, response, "/product/list.jsp");
    }

    private void showProduct(HttpServletRequest request, HttpServletResponse response, String jsp)
            throws ServletException, IOException {
        int id = parseId(request.getParameter("id"));
        Product product = service.findById(id);
        if (product == null) {
            notFound(request, response);
            return;
        }
        request.setAttribute("product", product);
        if (product.getPrice() != null) {
            request.setAttribute("priceInput", product.getPrice().toPlainString());
        }
        show(request, response, jsp);
    }

    private void createProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Product product = readProduct(request, 0);
            service.save(product);
            redirectToList(request, response, "created");
        } catch (IllegalArgumentException ex) {
            request.setAttribute("error", ex.getMessage());
            show(request, response, "/product/create.jsp");
        }
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = parseId(request.getParameter("id"));
        if (service.findById(id) == null) {
            notFound(request, response);
            return;
        }

        try {
            Product product = readProduct(request, id);
            if (!service.update(id, product)) {
                notFound(request, response);
                return;
            }
            redirectToList(request, response, "updated");
        } catch (IllegalArgumentException ex) {
            request.setAttribute("error", ex.getMessage());
            show(request, response, "/product/edit.jsp");
        }
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = parseId(request.getParameter("id"));
        if (!service.remove(id)) {
            notFound(request, response);
            return;
        }
        redirectToList(request, response, "deleted");
    }

    private Product readProduct(HttpServletRequest request, int id) {
        String name = clean(request.getParameter("name"));
        String priceInput = clean(request.getParameter("price"));
        String description = clean(request.getParameter("description"));
        String manufacturer = clean(request.getParameter("manufacturer"));

        Product product = new Product(id, name, null, description, manufacturer);
        request.setAttribute("product", product);
        request.setAttribute("priceInput", priceInput);

        if (name.isEmpty() || name.length() > 120) {
            throw new IllegalArgumentException("Tên sản phẩm bắt buộc và tối đa 120 ký tự.");
        }
        if (manufacturer.isEmpty() || manufacturer.length() > 120) {
            throw new IllegalArgumentException("Nhà sản xuất bắt buộc và tối đa 120 ký tự.");
        }
        if (description.length() > 1000) {
            throw new IllegalArgumentException("Mô tả không được vượt quá 1000 ký tự.");
        }

        BigDecimal price;
        try {
            price = new BigDecimal(priceInput);
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("Giá sản phẩm phải là một số hợp lệ.");
        }

        if (price.signum() < 0 || price.scale() > 2
                || price.compareTo(new BigDecimal("999999999999.99")) > 0) {
            throw new IllegalArgumentException("Giá phải không âm, tối đa 2 chữ số thập phân.");
        }

        product.setPrice(price);
        return product;
    }

    private String clean(String value) {
        return value == null ? "" : value.strip();
    }

    private int parseId(String input) {
        if (input == null) {
            return -1;
        }
        try {
            int id = Integer.parseInt(input);
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
        response.sendRedirect(request.getContextPath() + "/products?notice=" + notice);
    }
}
