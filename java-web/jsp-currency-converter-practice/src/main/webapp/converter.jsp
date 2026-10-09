<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.text.NumberFormat, java.util.Locale" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Kết quả chuyển đổi</title>
    <style>
        body { font-family: Arial, sans-serif; display: flex; justify-content: center; padding: 90px 16px; margin: 0; background-color: #f8fafc; }
        .result-container { box-sizing: border-box; background: white; padding: 35px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0, 0, 0, .1); text-align: center; width: 100%; max-width: 450px; }
        h2 { color: #1b2a7a; }
        .success { background: #e8f5e9; color: #237a3d; padding: 15px; border-radius: 8px; }
        .error { background: #ffebee; color: #c0392b; padding: 15px; border-radius: 8px; }
        .back-btn { text-decoration: none; padding: 10px 20px; background: #1b2a7a; color: white; border-radius: 4px; display: inline-block; margin-top: 20px; }
    </style>
</head>
<body>
    <main class="result-container">
        <h2>KẾT QUẢ CHUYỂN ĐỔI</h2>
        <%
            try {
                if (!"POST".equalsIgnoreCase(request.getMethod())) {
                    throw new IllegalArgumentException("Yêu cầu phải dùng POST");
                }

                // JSP Scriptlet: lấy dữ liệu từ form và chuyển sang số thực.
                double rate = Double.parseDouble(request.getParameter("rate"));
                double usd = Double.parseDouble(request.getParameter("usd"));

                if (!Double.isFinite(rate) || !Double.isFinite(usd)
                        || rate <= 0 || usd < 0) {
                    throw new IllegalArgumentException("Số không hợp lệ");
                }

                double vnd = usd * rate;
                if (!Double.isFinite(vnd)) {
                    throw new IllegalArgumentException("Kết quả vượt giới hạn");
                }

                NumberFormat number = NumberFormat.getNumberInstance(new Locale("vi", "VN"));
                number.setMaximumFractionDigits(2);
        %>
        <p>Tỉ giá: <strong><%= number.format(rate) %></strong> VND/USD</p>
        <p>Số USD: <strong><%= number.format(usd) %></strong> USD</p>
        <div class="success">
            <h3>Thành tiền: <%= number.format(vnd) %> VNĐ</h3>
        </div>
        <%
            } catch (Exception e) {
        %>
        <div class="error">
            <h3>Lỗi xử lý!</h3>
            <p>Dữ liệu đầu vào không hợp lệ. Vui lòng kiểm tra lại.</p>
        </div>
        <%
            }
        %>
        <a href="index.jsp" class="back-btn">Quay lại trang chủ</a>
    </main>
</body>
</html>
