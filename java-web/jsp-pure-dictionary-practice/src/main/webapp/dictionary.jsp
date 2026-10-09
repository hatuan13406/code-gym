<%@ page import="java.util.HashMap, java.util.Map, java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Đặt UTF-8 trước khi nhận dữ liệu POST để giữ đúng tiếng Việt.
    request.setCharacterEncoding("UTF-8");

    // JSP Scriptlet: khởi tạo từ điển đơn giản dưới dạng Map.
    Map<String, String> dic = new HashMap<>();
    dic.put("hello", "Xin chào");
    dic.put("how", "Thế nào");
    dic.put("book", "Quyển sách");
    dic.put("computer", "Máy tính");
    dic.put("student", "Sinh viên");

    String searchWord = request.getParameter("search");
    if (searchWord == null) {
        searchWord = "";
    }
    searchWord = searchWord.trim();
    String result = null;
    if ("POST".equalsIgnoreCase(request.getMethod()) && !searchWord.isEmpty()) {
        result = dic.get(searchWord.toLowerCase(Locale.ROOT));
    }

    // Thoát ký tự đặc biệt trước khi đưa từ người dùng lên trang HTML.
    String safeSearchWord = searchWord.replace("&", "&amp;")
        .replace("<", "&lt;")
        .replace(">", "&gt;")
        .replace("\"", "&quot;")
        .replace("'", "&#39;");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Kết quả tra cứu</title>
    <style>
        body { font-family: Arial, sans-serif; display: flex; justify-content: center; background: #f8fafc; margin: 0; padding: 100px 16px; }
        .result-container { box-sizing: border-box; background: white; padding: 40px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0, 0, 0, .1); text-align: center; width: 100%; max-width: 470px; overflow-wrap: anywhere; }
        h2 { color: #1b2a7a; }
        .success { background: #e8f5e9; padding: 15px; border-radius: 8px; margin-top: 20px; color: #27ae60; }
        .error { background: #ffebee; padding: 15px; border-radius: 8px; margin-top: 20px; color: #c0392b; }
        .back-btn { text-decoration: none; padding: 10px 20px; background: #1b2a7a; color: white; border-radius: 4px; display: inline-block; margin-top: 20px; }
    </style>
</head>
<body>
    <main class="result-container">
        <h2>KẾT QUẢ TRA CỨU</h2>
        <% if (result != null) { %>
            <p>Từ cần tra: <b><%= safeSearchWord %></b></p>
            <div class="success">
                <h3>Nghĩa là: <%= result %></h3>
            </div>
        <% } else { %>
            <div class="error">
                <h3>Không tìm thấy!</h3>
                <p>Từ khóa <b><%= safeSearchWord %></b> không có trong từ điển.</p>
            </div>
        <% } %>
        <a href="index.jsp" class="back-btn">Quay lại trang chủ</a>
    </main>
</body>
</html>
