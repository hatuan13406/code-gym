<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Kết quả kiểm tra JDBC Transaction</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style.css">
</head>
<body>
<main class="panel">
    <h1>Kết quả kiểm tra Transaction</h1>
    <c:choose>
        <c:when test="${rolledBack}">
            <div class="notice notice-success">ĐÃ ROLLBACK: User thử nghiệm không tồn tại trong bảng users.</div>
        </c:when>
        <c:otherwise>
            <div class="notice notice-error">KHÔNG ĐẠT: User thử nghiệm vẫn tồn tại. Kiểm tra InnoDB / kết nối MySQL.</div>
        </c:otherwise>
    </c:choose>
    <p>SQL được cố ý viết sai cột sau khi INSERT User và quyền.</p>
    <p>Mã lỗi MySQL: <strong><c:out value="${mysqlCode}"/></strong>,
       SQLState: <strong><c:out value="${sqlState}"/></strong>.</p>
    <p>Chi tiết: <code><c:out value="${sqlError}"/></code></p>
    <p>Email để kiểm tra cơ sở dữ liệu:</p>
    <pre><c:out value="${demoEmail}"/></pre>
    <p>Trong MySQL Workbench, chạy:</p>
    <pre>SELECT * FROM users WHERE email = '<c:out value="${demoEmail}"/>';</pre>
    <p>Kết quả đúng là <strong>0 dòng</strong>.</p>
    <a class="button" href="${pageContext.request.contextPath}/users">Quay lại danh sách</a>
</main>
</body>
</html>
