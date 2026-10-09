<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chi tiết khách hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
</head>
<body>
<main class="panel">
    <h1>Chi tiết khách hàng</h1>
    <table class="detail">
        <tbody>
            <tr><th>ID</th><td><c:out value="${customer.id}"/></td></tr>
            <tr><th>Họ và tên</th><td><c:out value="${customer.name}"/></td></tr>
            <tr><th>Email</th><td><c:out value="${customer.email}"/></td></tr>
            <tr><th>Địa chỉ</th><td><c:out value="${customer.address}"/></td></tr>
        </tbody>
    </table>
    <div class="form-actions">
        <a class="btn btn-primary" href="${pageContext.request.contextPath}/customers?action=edit&amp;id=${customer.id}">Sửa thông tin</a>
        <a class="btn btn-muted" href="${pageContext.request.contextPath}/customers">Quay lại danh sách</a>
    </div>
</main>
</body>
</html>
