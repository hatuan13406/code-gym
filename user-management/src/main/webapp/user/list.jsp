<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Danh sách người dùng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style.css">
</head>
<body>
<main class="container">
    <h1>Quản lý người dùng</h1>
    <p class="subtle">Java Servlet, JSP, JDBC, MySQL – kiến trúc MVC</p>

    <c:if test="${param.notice == 'created'}">
        <div class="notice notice-success">Thêm mới người dùng thành công.</div>
    </c:if>
    <c:if test="${param.notice == 'updated'}">
        <div class="notice notice-success">Cập nhật người dùng thành công.</div>
    </c:if>
    <c:if test="${param.notice == 'deleted'}">
        <div class="notice notice-success">Xóa người dùng thành công.</div>
    </c:if>

    <div class="toolbar">
        <span>Tổng số người dùng: <strong><c:out value="${listUser.size()}"/></strong></span>
        <a class="button button-green" href="${pageContext.request.contextPath}/users?action=create">+ Thêm User</a>
    </div>

    <div class="table-scroll">
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Họ tên</th>
                <th>Email</th>
                <th>Quốc gia</th>
                <th>Thao tác</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${requestScope.listUser}" var="user">
                <tr>
                    <td><c:out value="${user.id}"/></td>
                    <td><c:out value="${user.name}"/></td>
                    <td><c:out value="${user.email}"/></td>
                    <td><c:out value="${user.country}"/></td>
                    <td class="actions">
                        <a href="${pageContext.request.contextPath}/users?action=edit&amp;id=${user.id}">Sửa</a>
                        <a class="link-delete" href="${pageContext.request.contextPath}/users?action=delete&amp;id=${user.id}">Xóa</a>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty requestScope.listUser}">
                <tr><td colspan="5">Chưa có người dùng nào trong cơ sở dữ liệu.</td></tr>
            </c:if>
        </tbody>
    </table>
    </div>
</main>
</body>
</html>
