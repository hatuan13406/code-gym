<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Danh sách khách hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
</head>
<body>
<main class="container">
    <h1>Danh sách khách hàng</h1>
    <p class="muted">Ứng dụng quản lý khách hàng theo mô hình MVC</p>

    <c:if test="${param.success == 'created'}">
        <div class="alert alert-success">Thêm khách hàng thành công.</div>
    </c:if>
    <c:if test="${param.success == 'updated'}">
        <div class="alert alert-success">Cập nhật khách hàng thành công.</div>
    </c:if>
    <c:if test="${param.success == 'deleted'}">
        <div class="alert alert-success">Xóa khách hàng thành công.</div>
    </c:if>

    <div class="toolbar">
        <span>Có <strong><c:out value="${customers.size()}"/></strong> khách hàng</span>
        <a class="btn btn-success" href="${pageContext.request.contextPath}/customers?action=create">
            + Thêm khách hàng mới
        </a>
    </div>

    <div class="table-wrap">
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Họ và tên</th>
                <th>Email</th>
                <th>Địa chỉ</th>
                <th>Hành động</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${requestScope.customers}" var="customer">
                <tr>
                    <td><c:out value="${customer.id}"/></td>
                    <td>
                        <a href="${pageContext.request.contextPath}/customers?action=view&amp;id=${customer.id}">
                            <c:out value="${customer.name}"/>
                        </a>
                    </td>
                    <td><c:out value="${customer.email}"/></td>
                    <td><c:out value="${customer.address}"/></td>
                    <td class="actions">
                        <a href="${pageContext.request.contextPath}/customers?action=view&amp;id=${customer.id}">Xem</a>
                        <a href="${pageContext.request.contextPath}/customers?action=edit&amp;id=${customer.id}">Sửa</a>
                        <a class="danger-link" href="${pageContext.request.contextPath}/customers?action=delete&amp;id=${customer.id}">Xóa</a>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty customers}">
                <tr><td colspan="5">Chưa có khách hàng nào.</td></tr>
            </c:if>
            </tbody>
        </table>
    </div>
</main>
</body>
</html>
