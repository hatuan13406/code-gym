<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Xác nhận xóa sản phẩm</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style.css">
</head>
<body>
<main class="panel">
    <h1>Xác nhận xóa sản phẩm</h1>
    <div class="alert alert-error">Bạn có chắc chắn muốn xóa sản phẩm này? Thao tác này không thể hoàn tác.</div>

    <table class="details">
        <tbody>
            <tr><th>ID</th><td><c:out value="${product.id}"/></td></tr>
            <tr><th>Tên sản phẩm</th><td><c:out value="${product.name}"/></td></tr>
            <tr><th>Giá</th><td><c:out value="${product.price}"/> VNĐ</td></tr>
            <tr><th>Nhà sản xuất</th><td><c:out value="${product.manufacturer}"/></td></tr>
        </tbody>
    </table>

    <form action="${pageContext.request.contextPath}/products?action=delete" method="post">
        <input type="hidden" name="id" value="${product.id}">
        <div class="actions">
            <button class="btn danger" type="submit">Đồng ý xóa</button>
            <a class="btn secondary" href="${pageContext.request.contextPath}/products">Hủy bỏ</a>
        </div>
    </form>
</main>
</body>
</html>
