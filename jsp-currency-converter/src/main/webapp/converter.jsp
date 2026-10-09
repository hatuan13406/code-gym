<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.text.NumberFormat, java.util.Locale" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Kết quả chuyển đổi</title>
    <style>
        body { font-family: Arial, sans-serif; display: flex; justify-content: center; padding: 80px 16px; margin: 0; background: #f8fafc; }
        .box { box-sizing: border-box; background: white; padding: 32px; border-radius: 10px; box-shadow: 0 4px 12px #0001; width: 100%; max-width: 440px; text-align: center; }
        h2 { color: #1b2a7a; }
        .success { background: #e8f5e9; color: #187537; padding: 16px; border-radius: 8px; overflow-wrap: anywhere; }
        .error { background: #ffebee; color: #b71c1c; padding: 16px; border-radius: 8px; }
        a { display: inline-block; margin-top: 22px; background: #1b2a7a; color: white; text-decoration: none; padding: 11px 20px; border-radius: 5px; }
    </style>
</head>
<body>
    <main class="box">
        <h2>KẾT QUẢ CHUYỂN ĐỔI</h2>
        <%
            try {
                if (!"POST".equalsIgnoreCase(request.getMethod())) {
                    throw new IllegalArgumentException("Phải gửi dữ liệu bằng POST");
                }
                // Đọc dữ liệu biểu mẫu qua JSP Scriptlet.
                double rate = Double.parseDouble(request.getParameter("rate"));
                double usd = Double.parseDouble(request.getParameter("usd"));
                double vnd = rate * usd;
                if (!Double.isFinite(rate) || !Double.isFinite(usd) || !Double.isFinite(vnd)
                        || rate <= 0 || usd < 0) {
                    throw new IllegalArgumentException("Giá trị không hợp lệ");
                }
                NumberFormat fmt = NumberFormat.getNumberInstance(Locale.forLanguageTag("vi-VN"));
                fmt.setMaximumFractionDigits(2);
                String rateText = fmt.format(rate);
                String usdText = fmt.format(usd);
                String vndText = fmt.format(vnd);
        %>
        <p>Tỉ giá hiện tại: <strong><%= rateText %></strong> VND/USD</p>
        <p>Lượng USD yêu cầu: <strong>$<%= usdText %></strong></p>
        <div class="success"><h3>Thành tiền: <%= vndText %> VNĐ</h3></div>
        <%
            } catch (Exception ex) {
        %>
        <div class="error">
            <h3>Lỗi xử lý!</h3>
            <p>Dữ liệu đầu vào không hợp lệ. Vui lòng kiểm tra lại.</p>
        </div>
        <%
            }
        %>
        <a href="index.jsp">Quay lại trang chủ</a>
    </main>
</body>
</html>
