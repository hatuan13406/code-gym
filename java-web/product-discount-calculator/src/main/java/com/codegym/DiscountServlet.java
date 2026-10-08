package com.codegym;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.NumberFormat;
import java.util.Locale;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "DiscountServlet", urlPatterns = {"/display-discount"})
public class DiscountServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String description = request.getParameter("productDescription");

        try (PrintWriter out = response.getWriter()) {
            try {
                double listPrice = Double.parseDouble(request.getParameter("listPrice"));
                double discountPercent = Double.parseDouble(request.getParameter("discountPercent"));

                if (listPrice < 0 || discountPercent < 0 || discountPercent > 100) {
                    throw new NumberFormatException();
                }

                double discountAmount = listPrice * discountPercent * 0.01;
                double discountPrice = listPrice - discountAmount;

                NumberFormat currency = NumberFormat.getCurrencyInstance(Locale.US);

                out.println("<!DOCTYPE html>");
                out.println("<html lang='en'>");
                out.println("<head>");
                out.println("<meta charset='UTF-8'>");
                out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
                out.println("<title>Discount Result</title>");
                out.println("</head>");
                out.println("<body style='font-family:Arial,sans-serif;background:#f8fafc;margin:0;padding:60px 20px;'>");
                out.println("<div style='max-width:560px;margin:auto;background:white;padding:32px;border-radius:10px;box-shadow:0 8px 24px rgba(0,0,0,.08);'>");
                out.println("<h1 style='color:#1b2a7a;'>Product Discount Result</h1>");
                out.println("<p><strong>Product Description:</strong> " + escapeHtml(description == null ? "" : description) + "</p>");
                out.println("<p><strong>List Price:</strong> " + currency.format(listPrice) + "</p>");
                out.println("<p><strong>Discount Percent:</strong> " + discountPercent + "%</p>");
                out.println("<p><strong>Discount Amount:</strong> " + currency.format(discountAmount) + "</p>");
                out.println("<p><strong>Discount Price:</strong> " + currency.format(discountPrice) + "</p>");
                out.println("<br><a href='" + request.getContextPath() + "/' style='display:inline-block;padding:10px 18px;background:#1b2a7a;color:white;text-decoration:none;border-radius:4px;'>Back</a>");
                out.println("</div>");
                out.println("</body>");
                out.println("</html>");
            } catch (NumberFormatException e) {
                out.println("<!DOCTYPE html>");
                out.println("<html lang='en'><head><meta charset='UTF-8'><title>Input Error</title></head>");
                out.println("<body style='font-family:Arial,sans-serif;text-align:center;margin-top:100px;'>");
                out.println("<h2 style='color:red;'>Invalid input. Please enter valid values.</h2>");
                out.println("<a href='" + request.getContextPath() + "/'>Back</a>");
                out.println("</body></html>");
            }
        }
    }

    private String escapeHtml(String value) {
        return value
                .replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace(""", "&quot;")
                .replace("'", "&#39;");
    }
}
