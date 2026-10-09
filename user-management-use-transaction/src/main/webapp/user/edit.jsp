<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Sửa thông tin người dùng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style.css">
</head>
<body>
<main class="panel">
    <h1>Sửa User #<c:out value="${user.id}"/></h1>
    <p class="subtle">Cập nhật thông tin rồi nhấn Lưu thay đổi.</p>

    <c:if test="${not empty requestScope.error}">
        <div class="notice notice-error"><c:out value="${error}"/></div>
    </c:if>

    <form action="${pageContext.request.contextPath}/users?action=edit" method="post" accept-charset="UTF-8">
        <input type="hidden" name="id" value="${user.id}">

        <label for="name">Họ và tên *</label>
        <input type="text" id="name" name="name" maxlength="120"
               value="${fn:escapeXml(user.name)}" required>

        <label for="email">Email *</label>
        <input type="email" id="email" name="email" maxlength="220"
               value="${fn:escapeXml(user.email)}" required>

        <label for="country">Quốc gia</label>
        <input type="text" id="country" name="country" maxlength="120"
               value="${fn:escapeXml(user.country)}">

        <div class="form-actions">
            <button class="button" type="submit">Lưu thay đổi</button>
            <a class="button button-gray" href="${pageContext.request.contextPath}/users">Hủy</a>
        </div>
    </form>
</main>
</body>
</html>
