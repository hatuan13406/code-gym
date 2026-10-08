package com.codegym;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "DictionaryServlet", urlPatterns = {"/translate"})
public class DictionaryServlet extends HttpServlet {

    private final Map<String, String> dictionary = new HashMap<>();

    @Override
    public void init() throws ServletException {
        dictionary.put("hello", "Xin chào");
        dictionary.put("how", "Thế nào");
        dictionary.put("book", "Quyển sách");
        dictionary.put("computer", "Máy tính");
        dictionary.put("student", "Sinh viên");
        dictionary.put("teacher", "Giáo viên");
        dictionary.put("school", "Trường học");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String searchWord = request.getParameter("word");

        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html lang='vi'>");
            out.println("<head>");
            out.println("<meta charset='UTF-8'>");
            out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
            out.println("<title>Kết quả tra cứu</title>");
            out.println("</head>");
            out.println("<body style='font-family: Arial, sans-serif; text-align: center; margin-top: 100px; background:#f8fafc;'>");

            if (searchWord != null && !searchWord.trim().isEmpty()) {
                String normalizedWord = searchWord.trim().toLowerCase();
                String result = dictionary.get(normalizedWord);

                if (result != null) {
                    out.println("<h2 style='color:#1b2a7a;'>Từ khóa: " + escapeHtml(searchWord.trim()) + "</h2>");
                    out.println("<h3 style='color:#27ae60;'>Nghĩa tiếng Việt: " + result + "</h3>");
                } else {
                    out.println("<h2 style='color:red;'>Không tìm thấy từ: " + escapeHtml(searchWord.trim()) + "</h2>");
                }
            } else {
                out.println("<h2 style='color:orange;'>Vui lòng nhập từ khóa hợp lệ!</h2>");
            }

            out.println("<br>");
            out.println("<a href='" + request.getContextPath()
                    + "/' style='text-decoration:none; padding:10px 20px; background:#1b2a7a; color:white; border-radius:4px;'>Quay lại</a>");
            out.println("</body>");
            out.println("</html>");
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
