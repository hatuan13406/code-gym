<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thêm sản phẩm mới</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style.css">
</head>
<body>
<main class="panel">
    <h1>Thêm sản phẩm mới</h1>
    <p class="subtitle">Nhập đầy đủ thông tin sản phẩm.</p>

    <c:if test="${not empty error}">
        <div class="alert alert-error"><c:out value="${error}"/></div>
    </c:if>

    <form action="${pageContext.request.contextPath}/products?action=create" method="post" accept-charset="UTF-8">
        <label for="name">Tên sản phẩm *</label>
        <input type="text" id="name" name="name" maxlength="120" required autofocus
               value="${fn:escapeXml(product.name)}">

        <label for="price">Giá sản phẩm (VNĐ) *</label>
        <input type="number" id="price" name="price" min="0" max="999999999999.99"
               step="0.01" required value="${fn:escapeXml(priceInput)}">

        <label for="description">Mô tả sản phẩm</label>
        <textarea id="description" name="description" maxlength="1000"><c:out value="${product.description}"/></textarea>

        <label for="manufacturer">Nhà sản xuất *</label>
        <input type="text" id="manufacturer" name="manufacturer" maxlength="120"
               required value="${fn:escapeXml(product.manufacturer)}">

        <div class="actions">
            <button class="btn success" type="submit">Lưu sản phẩm</button>
            <a class="btn secondary" href="${pageContext.request.contextPath}/products">Hủy</a>
        </div>
    </form>
</main>
</body>
</html>
