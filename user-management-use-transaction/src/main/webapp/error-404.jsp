<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>404 - Không tìm thấy User</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style.css">
</head>
<body>
<main class="panel" style="text-align:center">
    <h1 style="font-size:60px;color:#bf3546">404</h1>
    <h2>Không tìm thấy người dùng!</h2>
    <p class="subtle">Người dùng không tồn tại hoặc đã bị xóa.</p>
    <a class="button" href="${pageContext.request.contextPath}/users">Quay lại danh sách</a>
</main>
</body>
</html>
