<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
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

    <!-- Country filtering and name sorting are handled by dedicated Servlet actions. -->
    <form class="filter-form" action="${pageContext.request.contextPath}/users" method="get">
        <div class="filter-field">
            <label for="country">Tìm kiếm theo quốc gia</label>
            <input type="search" id="country" name="country" maxlength="120"
                   value="${fn:escapeXml(country)}" placeholder="Ví dụ: Viet Nam">
        </div>
        <div class="filter-field">
            <label for="sort">Sắp xếp theo tên</label>
            <select id="sort" name="sort">
                <c:choose>
                    <c:when test="${sort eq 'desc'}">
                        <option value="asc">Tên A - Z</option>
                        <option value="desc" selected="selected">Tên Z - A</option>
                    </c:when>
                    <c:otherwise>
                        <option value="asc" selected="selected">Tên A - Z</option>
                        <option value="desc">Tên Z - A</option>
                    </c:otherwise>
                </c:choose>
            </select>
        </div>
        <button type="submit" name="action" value="search" class="button">Tìm kiếm</button>
        <button type="submit" name="action" value="sort" class="button">Sắp xếp</button>
        <a class="button button-gray" href="${pageContext.request.contextPath}/users">Đặt lại</a>
    </form>

    <div class="toolbar">
        <span>Tổng số người dùng: <strong><c:out value="${listUser.size()}"/></strong></span>
        <a class="button button-green" href="${pageContext.request.contextPath}/users?action=create">+ Thêm User</a>
    </div>

    <section class="panel" style="margin: 22px 0; max-width: none;">
        <h2>Thực hành JDBC Transaction: COMMIT / ROLLBACK</h2>
        <p>Nhấn nút bên dưới để chèn một User thử nghiệm cùng quyền hợp lệ,
           sau đó cố tình chạy câu SQL sai. Chương trình sẽ gọi
           <code>connection.rollback()</code> và kiểm tra xem User có bị lưu hay không.</p>
        <form action="${pageContext.request.contextPath}/users?action=test-add-user-transaction" method="post">
            <button class="button button-red" type="submit">Thử SQL lỗi và Rollback</button>
        </form>
        <p class="subtle">Chỉ chạy trên localhost. Chức năng thêm User thông thường vẫn dùng COMMIT.</p>
    </section>

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
                <tr><td colspan="5">Không tìm thấy người dùng phù hợp hoặc danh sách đang trống.</td></tr>
            </c:if>
        </tbody>
    </table>
    </div>
</main>
</body>
</html>
