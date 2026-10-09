<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Xác nhận xóa khách hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
</head>
<body>
<main class="panel">
    <h1>Xác nhận xóa khách hàng</h1>
    <div class="alert alert-error">Bạn có chắc chắn muốn xóa khách hàng này không?</div>
    <p><strong>Họ và tên:</strong> <c:out value="${customer.name}"/></p>
    <p><strong>Email:</strong> <c:out value="${customer.email}"/></p>
    <p><strong>Địa chỉ:</strong> <c:out value="${customer.address}"/></p>

    <form action="${pageContext.request.contextPath}/customers?action=delete" method="post">
        <input type="hidden" name="id" value="${customer.id}">
        <div class="form-actions">
            <button class="btn btn-danger" type="submit">Đồng ý xóa</button>
            <a class="btn btn-muted" href="${pageContext.request.contextPath}/customers">Hủy bỏ</a>
        </div>
    </form>
</main>
</body>
</html>
