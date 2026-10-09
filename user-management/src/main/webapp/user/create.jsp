<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thêm User mới</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style.css">
</head>
<body>
<main class="panel">
    <h1>Thêm người dùng</h1>
    <p class="subtle">Nhập dữ liệu để lưu vào MySQL.</p>

    <c:if test="${not empty requestScope.error}">
        <div class="notice notice-error"><c:out value="${error}"/></div>
    </c:if>

    <form action="${pageContext.request.contextPath}/users?action=create" method="post" accept-charset="UTF-8">
        <label for="name">Họ và tên *</label>
        <input type="text" id="name" name="name" maxlength="120"
               value="${fn:escapeXml(user.name)}" required autofocus>

        <label for="email">Email *</label>
        <input type="email" id="email" name="email" maxlength="220"
               value="${fn:escapeXml(user.email)}" required>

        <label for="country">Quốc gia</label>
        <input type="text" id="country" name="country" maxlength="120"
               value="${fn:escapeXml(user.country)}">

        <div class="form-actions">
            <button class="button button-green" type="submit">Lưu User</button>
            <a class="button button-gray" href="${pageContext.request.contextPath}/users">Hủy</a>
        </div>
    </form>
</main>
</body>
</html>
