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

@WebServlet(name = "ConverterServlet", urlPatterns = {"/convert"})
public class ConverterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            try {
                double rate = Double.parseDouble(request.getParameter("rate"));
                double usd = Double.parseDouble(request.getParameter("usd"));

                if (rate <= 0 || usd < 0) {
                    throw new NumberFormatException();
                }

                double vnd = rate * usd;

                NumberFormat vndFormat = NumberFormat.getNumberInstance(new Locale("vi", "VN"));
                NumberFormat usdFormat = NumberFormat.getNumberInstance(Locale.US);

                out.println("<!DOCTYPE html>");
                out.println("<html lang='vi'>");
                out.println("<head>");
                out.println("<meta charset='UTF-8'>");
                out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
                out.println("<title>Currency Converter Result</title>");
                out.println("</head>");
                out.println("<body style='font-family: Arial, sans-serif; text-align: center; margin-top: 100px; background:#f8fafc;'>");
                out.println("<h2 style='color:#1b2a7a;'>KẾT QUẢ CHUYỂN ĐỔI</h2>");
                out.println("<p style='font-size:18px;'>Tỉ giá: " + vndFormat.format(rate) + " VND/USD</p>");
                out.println("<p style='font-size:18px;'>Số tiền USD: $" + usdFormat.format(usd) + "</p>");
                out.println("<h3 style='color:#27ae60; font-size:24px;'>Thành tiền VNĐ: "
                        + vndFormat.format(vnd) + " VNĐ</h3>");
                out.println("<br>");
                out.println("<a href='" + request.getContextPath()
                        + "/' style='text-decoration:none; padding:10px 20px; background:#1b2a7a; color:white; border-radius:4px;'>Quay lại</a>");
                out.println("</body>");
                out.println("</html>");

            } catch (NumberFormatException | NullPointerException e) {
                out.println("<!DOCTYPE html>");
                out.println("<html lang='vi'>");
                out.println("<head><meta charset='UTF-8'><title>Lỗi</title></head>");
                out.println("<body style='font-family:Arial,sans-serif;text-align:center;margin-top:100px;'>");
                out.println("<h2 style='color:red;'>Lỗi: Vui lòng nhập số hợp lệ!</h2>");
                out.println("<a href='" + request.getContextPath() + "/'>Quay lại</a>");
                out.println("</body>");
                out.println("</html>");
            }
        }
    }
}
