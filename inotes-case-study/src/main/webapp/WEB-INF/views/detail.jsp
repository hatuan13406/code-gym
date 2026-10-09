<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chi tiết ghi chú — iNotes</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style.css">
</head>
<body>
<header class="topbar"><div class="shell topbar-inner">
    <a class="brand" href="${pageContext.request.contextPath}/notes"><span class="brand-mark">✎</span> iNotes</a>
    <span class="storage-label">Đang lưu bằng: <strong><c:out value="${storageName}"/></strong></span>
</div></header>
<main class="shell narrow">
    <a class="back" href="${pageContext.request.contextPath}/notes">← Quay về danh sách</a>
    <article class="panel detail">
        <div class="note-top"><span class="tag"><c:out value="${typeNames[note.typeId]}"/></span><small>#<c:out value="${note.id}"/></small></div>
        <h1><c:out value="${note.title}"/></h1>
        <div class="detail-content"><c:out value="${note.content}"/></div>
        <div class="form-actions">
            <a class="button primary" href="${pageContext.request.contextPath}/notes?action=edit&amp;id=${note.id}">Chỉnh sửa</a>
            <form method="post" action="${pageContext.request.contextPath}/notes">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="id" value="${note.id}">
                <input type="hidden" name="_csrf" value="${csrf}">
                <button class="button destructive" onclick="return confirm('Bạn có chắc muốn xóa ghi chú này?')" type="submit">Xóa</button>
            </form>
        </div>
    </article>
</main>
</body>
</html>
