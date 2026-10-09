<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Kết quả tính toán</title>
    <style>
        * { box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background: #f4f7fb; margin: 0; padding: 80px 16px; }
        .card { max-width: 450px; margin: auto; background: white; padding: 35px; border-radius: 12px; text-align: center; box-shadow: 0 6px 24px #17255416; }
        h1 { color: #1b2a7a; font-size: 26px; }
        .ok { padding: 18px; border-radius: 8px; background: #e8f5e9; color: #176c36; font-size: 21px; overflow-wrap: anywhere; }
        .error { padding: 18px; border-radius: 8px; background: #ffebee; color: #b52b2b; }
        a { display: inline-block; margin-top: 22px; padding: 11px 20px; border-radius: 6px; background: #1b2a7a; color: white; text-decoration: none; }
    </style>
</head>
<body>
    <main class="card">
        <h1>KẾT QUẢ TÍNH TOÁN</h1>
        <% if (request.getAttribute("error") != null) { %>
            <div class="error"><strong>${error}</strong></div>
        <% } else { %>
            <div class="ok">
                <div>${firstOperand} ${symbol} ${secondOperand}</div>
                <hr>
                <strong>= ${result}</strong>
            </div>
        <% } %>
        <a href="${pageContext.request.contextPath}/">Quay lại</a>
    </main>
</body>
</html>
