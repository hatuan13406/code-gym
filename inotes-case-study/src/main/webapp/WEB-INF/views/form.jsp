<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${editing ? 'Chỉnh sửa ghi chú' : 'Ghi chú mới'} — iNotes</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style.css">
</head>
<body>
<header class="topbar"><div class="shell topbar-inner">
    <a class="brand" href="${pageContext.request.contextPath}/notes"><span class="brand-mark">✎</span> iNotes</a>
    <span class="storage-label">Đang lưu bằng: <strong><c:out value="${storageName}"/></strong></span>
</div></header>
<main class="shell narrow">
    <a class="back" href="${pageContext.request.contextPath}/notes">← Quay về danh sách</a>
    <div class="panel editor">
        <p class="eyebrow">${editing ? 'CHỈNH SỬA' : 'TẠO MỚI'}</p>
        <h1>${editing ? 'Chỉnh sửa ghi chú' : 'Thêm ghi chú mới'}</h1>
        <c:if test="${not empty formError}"><div class="alert error"><c:out value="${formError}"/></div></c:if>
        <form action="${pageContext.request.contextPath}/notes" method="post" accept-charset="UTF-8">
            <input type="hidden" name="action" value="save">
            <input type="hidden" name="id" value="${note.id}">
            <input type="hidden" name="_csrf" value="${csrf}">
            <label for="title">Tiêu đề <span class="required">*</span></label>
            <input id="title" name="title" type="text" maxlength="255"
                   value="${fn:escapeXml(note.title)}" required
                   placeholder="Ví dụ: Kế hoạch ôn tập Java">
            <label for="typeId">Phân loại <span class="required">*</span></label>
            <select id="typeId" name="typeId" required>
                <option value="">Chọn phân loại</option>
                <c:forEach var="t" items="${types}">
                    <option value="${t.id}" ${note.typeId == t.id ? 'selected' : ''}><c:out value="${t.name}"/></option>
                </c:forEach>
            </select>
            <label for="content">Nội dung</label>
            <textarea id="content" name="content" rows="13" maxlength="20000"
                      placeholder="Viết những điều bạn muốn ghi nhớ..."><c:out value="${note.content}"/></textarea>
            <div class="form-actions">
                <button class="button primary" type="submit">Lưu ghi chú</button>
                <a class="button ghost" href="${pageContext.request.contextPath}/notes">Hủy bỏ</a>
            </div>
        </form>
    </div>
</main>
</body>
</html>
