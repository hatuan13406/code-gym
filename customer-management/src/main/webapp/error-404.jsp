<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>404 - Không tìm thấy khách hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
</head>
<body>
<main class="panel" style="text-align:center">
    <h1 style="font-size:60px;color:#b83232">404</h1>
    <h2>Không tìm thấy khách hàng</h2>
    <p class="muted">Khách hàng không tồn tại hoặc đã được xóa.</p>
    <a class="btn btn-primary" href="${pageContext.request.contextPath}/customers">Quay lại danh sách</a>
</main>
</body>
</html>
