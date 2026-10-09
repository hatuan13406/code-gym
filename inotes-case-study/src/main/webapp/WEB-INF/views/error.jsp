<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html><html lang="vi"><head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>Lỗi lưu trữ — iNotes</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style.css">
</head><body><main class="shell narrow"><section class="panel editor">
<h1>Không thể truy cập kho lưu trữ</h1>
<div class="alert error"><c:out value="${storageError}"/></div>
<p>Kiểm tra cấu hình MySQL, chạy file <code>database.sql</code>, hoặc chuyển về chế độ File TXT từ trang danh sách.</p>
<form action="${pageContext.request.contextPath}/notes" method="post" class="form-actions">
  <input type="hidden" name="action" value="switch">
  <input type="hidden" name="mode" value="file">
  <input type="hidden" name="_csrf" value="${csrf}">
  <button class="button primary" type="submit">Chuyển về File TXT</button>
  <a class="button ghost" href="${pageContext.request.contextPath}/notes">Thử lại</a>
</form>
</section></main></body></html>
