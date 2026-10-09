<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thêm khách hàng mới</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
</head>
<body>
<main class="panel">
    <h1>Thêm khách hàng mới</h1>
    <p class="muted">Nhập thông tin bên dưới để lưu khách hàng.</p>
    <c:if test="${not empty error}">
        <div class="alert alert-error"><c:out value="${error}"/></div>
    </c:if>
    <form action="${pageContext.request.contextPath}/customers?action=create" method="post" accept-charset="UTF-8">
        <label for="name">Họ và tên</label>
        <input type="text" id="name" name="name" maxlength="100"
               value="${fn:escapeXml(customer.name)}" required autofocus>

        <label for="email">Email</label>
        <input type="email" id="email" name="email" maxlength="254"
               value="${fn:escapeXml(customer.email)}" required>

        <label for="address">Địa chỉ</label>
        <input type="text" id="address" name="address" maxlength="255"
               value="${fn:escapeXml(customer.address)}" required>

        <div class="form-actions">
            <button class="btn btn-success" type="submit">Lưu khách hàng</button>
            <a class="btn btn-muted" href="${pageContext.request.contextPath}/customers">Hủy</a>
        </div>
    </form>
</main>
</body>
</html>
