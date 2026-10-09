<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>iNotes — Ghi chú của tôi</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style.css">
</head>
<body>
<header class="topbar">
    <div class="shell topbar-inner">
        <a class="brand" href="${pageContext.request.contextPath}/notes"><span class="brand-mark">✎</span> iNotes</a>
        <div class="storage-control">
            <span class="storage-label">Nơi lưu trữ: <strong><c:out value="${storageName}"/></strong></span>
            <form action="${pageContext.request.contextPath}/notes" method="post" class="storage-form">
                <input type="hidden" name="action" value="switch">
                <input type="hidden" name="_csrf" value="${csrf}">
                <button class="mode ${storageMode eq 'file' ? 'active' : ''}"
                        type="submit" name="mode" value="file">File TXT</button>
                <button class="mode ${storageMode eq 'mysql' ? 'active' : ''}"
                        type="submit" name="mode" value="mysql">MySQL</button>
            </form>
        </div>
    </div>
</header>
<main class="shell">
    <div class="hero">
        <div>
            <p class="eyebrow">QUẢN LÝ GHI CHÚ CÁ NHÂN</p>
            <h1>Ý tưởng của bạn, luôn trong tầm tay.</h1>
            <p class="subtitle">Lưu giữ công việc, kế hoạch và kiến thức ở một nơi gọn gàng.</p>
        </div>
        <a class="button primary" href="${pageContext.request.contextPath}/notes?action=create">+ Thêm ghi chú</a>
    </div>
    <c:if test="${param.notice eq 'created'}"><div class="alert success">Đã tạo ghi chú thành công.</div></c:if>
    <c:if test="${param.notice eq 'updated'}"><div class="alert success">Đã cập nhật ghi chú.</div></c:if>
    <c:if test="${param.notice eq 'deleted'}"><div class="alert success">Đã xóa ghi chú.</div></c:if>
    <c:if test="${param.notice eq 'switched'}"><div class="alert success">Đã đổi nguồn lưu trữ. Mỗi nguồn có dữ liệu riêng.</div></c:if>
    <div class="panel">
        <form action="${pageContext.request.contextPath}/notes" method="get" class="filters">
            <div class="search-box">
                <label for="q">Tìm theo tiêu đề hoặc nội dung</label>
                <input id="q" type="search" name="q" maxlength="255"
                       placeholder="Bạn đang tìm ghi chú nào?"
                       value="${fn:escapeXml(keyword)}">
            </div>
            <div class="type-box">
                <label for="type">Phân loại</label>
                <select id="type" name="type">
                    <option value="0">Tất cả</option>
                    <c:forEach var="t" items="${types}">
                        <option value="${t.id}" ${selectedType == t.id ? 'selected' : ''}><c:out value="${t.name}"/></option>
                    </c:forEach>
                </select>
            </div>
            <button class="button secondary" type="submit">Tìm kiếm</button>
            <a class="link-reset" href="${pageContext.request.contextPath}/notes">Đặt lại</a>
        </form>
    </div>
    <div class="section-head">
        <h2>Danh sách ghi chú</h2>
        <span class="count"><c:out value="${notes.size()}"/> ghi chú</span>
    </div>
    <c:choose>
        <c:when test="${empty notes}">
            <div class="empty-state">
                <div class="empty-icon">✍</div>
                <h3>Chưa có ghi chú phù hợp</h3>
                <p>Hãy thêm một ghi chú hoặc thử tìm kiếm với từ khóa khác.</p>
                <a class="button primary" href="${pageContext.request.contextPath}/notes?action=create">Viết ghi chú đầu tiên</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="note-grid">
                <c:forEach var="note" items="${notes}">
                    <article class="note-card">
                        <div class="note-top">
                            <span class="tag"><c:out value="${typeNames[note.typeId]}"/></span>
                            <small>#<c:out value="${note.id}"/></small>
                        </div>
                        <h3><c:out value="${note.title}"/></h3>
                        <p class="note-preview"><c:out value="${note.content}"/></p>
                        <div class="note-actions">
                            <a href="${pageContext.request.contextPath}/notes?action=view&amp;id=${note.id}">Xem</a>
                            <a href="${pageContext.request.contextPath}/notes?action=edit&amp;id=${note.id}">Sửa</a>
                            <form action="${pageContext.request.contextPath}/notes" method="post">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="${note.id}">
                                <input type="hidden" name="_csrf" value="${csrf}">
                                <button class="danger-link" type="submit"
                                        onclick="return confirm('Xóa ghi chú này?')">Xóa</button>
                            </form>
                        </div>
                    </article>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
    <footer>iNotes · Strategy Pattern · Servlet / JSP · MySQL / File TXT</footer>
</main>
</body>
</html>
