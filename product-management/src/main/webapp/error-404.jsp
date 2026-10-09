<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>404 - Không tìm thấy sản phẩm</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style.css">
</head>
<body>
<main class="panel" style="text-align:center">
    <h1 style="font-size:64px;color:#bc3342">404</h1>
    <h2>Không tìm thấy sản phẩm</h2>
    <p class="subtitle">Sản phẩm không tồn tại hoặc đã bị xóa khỏi hệ thống.</p>
    <a class="btn primary" href="${pageContext.request.contextPath}/products">Quay lại danh sách</a>
</main>
</body>
</html>
