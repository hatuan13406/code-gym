<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Sửa thông tin khách hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
</head>
<body>
<main class="panel">
    <h1>Cập nhật khách hàng #<c:out value="${customer.id}"/></h1>
    <c:if test="${not empty error}">
        <div class="alert alert-error"><c:out value="${error}"/></div>
    </c:if>
    <form action="${pageContext.request.contextPath}/customers?action=edit" method="post" accept-charset="UTF-8">
        <input type="hidden" name="id" value="${customer.id}">

        <label for="name">Họ và tên</label>
        <input type="text" id="name" name="name" maxlength="100"
               value="${fn:escapeXml(customer.name)}" required>

        <label for="email">Email</label>
        <input type="email" id="email" name="email" maxlength="254"
               value="${fn:escapeXml(customer.email)}" required>

        <label for="address">Địa chỉ</label>
        <input type="text" id="address" name="address" maxlength="255"
               value="${fn:escapeXml(customer.address)}" required>

        <div class="form-actions">
            <button class="btn btn-primary" type="submit">Lưu thay đổi</button>
            <a class="btn btn-muted" href="${pageContext.request.contextPath}/customers">Hủy</a>
        </div>
    </form>
</main>
</body>
</html>
