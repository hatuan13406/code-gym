<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quản lý sản phẩm</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style.css">
</head>
<body>
<main class="container">
    <h1>Quản lý sản phẩm</h1>
    <p class="subtitle">Ứng dụng Java Servlet + JSP theo kiến trúc MVC</p>

    <c:if test="${param.notice == 'created'}">
        <div class="alert alert-ok">Thêm sản phẩm thành công.</div>
    </c:if>
    <c:if test="${param.notice == 'updated'}">
        <div class="alert alert-ok">Cập nhật sản phẩm thành công.</div>
    </c:if>
    <c:if test="${param.notice == 'deleted'}">
        <div class="alert alert-ok">Xóa sản phẩm thành công.</div>
    </c:if>

    <form class="search-bar" action="${pageContext.request.contextPath}/products" method="get">
        <input type="search" name="keyword" value="${fn:escapeXml(keyword)}"
               placeholder="Tìm kiếm sản phẩm theo tên..." aria-label="Tìm sản phẩm theo tên">
        <button class="btn primary" type="submit">Tìm kiếm</button>
        <a class="btn secondary" href="${pageContext.request.contextPath}/products">Tất cả</a>
        <a class="btn success" href="${pageContext.request.contextPath}/products?action=create">+ Thêm sản phẩm</a>
    </form>

    <p class="subtitle">Tìm thấy <strong><c:out value="${products.size()}"/></strong> sản phẩm.</p>

    <div class="table-wrap">
    <table class="list-table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Tên sản phẩm</th>
                <th>Giá (VNĐ)</th>
                <th>Nhà sản xuất</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
        <c:forEach var="product" items="${products}">
            <tr>
                <td><c:out value="${product.id}"/></td>
                <td><a class="link-action" href="${pageContext.request.contextPath}/products?action=view&amp;id=${product.id}"><c:out value="${product.name}"/></a></td>
                <td class="money"><c:out value="${product.price}"/></td>
                <td><c:out value="${product.manufacturer}"/></td>
                <td>
                    <a class="link-action" href="${pageContext.request.contextPath}/products?action=view&amp;id=${product.id}">Xem</a>
                    <a class="link-action" href="${pageContext.request.contextPath}/products?action=edit&amp;id=${product.id}">Sửa</a>
                    <a class="link-action link-delete" href="${pageContext.request.contextPath}/products?action=delete&amp;id=${product.id}">Xóa</a>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${empty products}">
            <tr><td colspan="5">Không tìm thấy sản phẩm nào.</td></tr>
        </c:if>
        </tbody>
    </table>
    </div>
</main>
</body>
</html>
