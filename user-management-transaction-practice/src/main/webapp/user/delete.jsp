<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Xác nhận xóa User</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style.css">
</head>
<body>
<main class="panel">
    <h1>Xác nhận xóa User</h1>
    <div class="notice notice-error">Bạn chắc chắn muốn xóa người dùng này khỏi MySQL?</div>

    <table class="details">
        <tbody>
            <tr><th>ID</th><td><c:out value="${user.id}"/></td></tr>
            <tr><th>Họ và tên</th><td><c:out value="${user.name}"/></td></tr>
            <tr><th>Email</th><td><c:out value="${user.email}"/></td></tr>
            <tr><th>Quốc gia</th><td><c:out value="${user.country}"/></td></tr>
        </tbody>
    </table>

    <form action="${pageContext.request.contextPath}/users?action=delete" method="post">
        <input type="hidden" name="id" value="${user.id}">
        <div class="form-actions">
            <button class="button button-red" type="submit">Đồng ý xóa</button>
            <a class="button button-gray" href="${pageContext.request.contextPath}/users">Hủy bỏ</a>
        </div>
    </form>
</main>
</body>
</html>
