<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chi tiết sản phẩm</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style.css">
</head>
<body>
<main class="panel">
    <h1>Chi tiết sản phẩm</h1>
    <table class="details">
        <tbody>
            <tr><th>Mã sản phẩm</th><td><c:out value="${product.id}"/></td></tr>
            <tr><th>Tên sản phẩm</th><td><c:out value="${product.name}"/></td></tr>
            <tr><th>Giá sản phẩm</th><td><c:out value="${product.price}"/> VNĐ</td></tr>
            <tr><th>Mô tả</th><td class="description"><c:out value="${product.description}"/></td></tr>
            <tr><th>Nhà sản xuất</th><td><c:out value="${product.manufacturer}"/></td></tr>
        </tbody>
    </table>
    <div class="actions">
        <a class="btn primary" href="${pageContext.request.contextPath}/products?action=edit&amp;id=${product.id}">Sửa</a>
        <a class="btn secondary" href="${pageContext.request.contextPath}/products">Quay lại danh sách</a>
    </div>
</main>
</body>
</html>
