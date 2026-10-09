<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, java.util.Map" %>
<%-- Tomcat 10.1+ uses Jakarta Tags 3.0; the old java.sun.com JSTL URI is for older Java EE. --%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    // Du lieu mau: ten, ngay sinh, dia chi va anh dai dien.
    List<Map<String, String>> customers = List.of(
        Map.of(
            "name", "Nguyễn Văn An",
            "birthday", "12/05/1992",
            "address", "Hà Nội",
            "image", "images/customer-an.svg"
        ),
        Map.of(
            "name", "Trần Thị Bình",
            "birthday", "23/09/1995",
            "address", "Đà Nẵng",
            "image", "images/customer-binh.svg"
        ),
        Map.of(
            "name", "Lê Văn Cường",
            "birthday", "08/03/1989",
            "address", "Hải Phòng",
            "image", "images/customer-cuong.svg"
        ),
        Map.of(
            "name", "Phạm Thị Dung",
            "birthday", "17/11/1998",
            "address", "TP. Hồ Chí Minh",
            "image", "images/customer-dung.svg"
        )
    );
    request.setAttribute("customers", customers);
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Danh sách khách hàng</title>
    <style>
        * { box-sizing: border-box; }
        body { margin: 0; padding: 60px 16px; background: #f4f7fb; color: #243246; font-family: Arial, sans-serif; }
        .container { max-width: 1050px; margin: 0 auto; background: #fff; border-radius: 12px; padding: 28px; box-shadow: 0 6px 26px rgba(28, 45, 80, .08); }
        h1 { font-size: 27px; color: #1b2a7a; margin: 0 0 10px; }
        .subtitle { margin: 0 0 24px; color: #627083; }
        .table-wrap { overflow-x: auto; }
        table { width: 100%; border-collapse: collapse; min-width: 630px; }
        thead { background: #1b2a7a; color: white; }
        th { text-align: left; padding: 16px 18px; font-size: 15px; }
        th:first-child { border-radius: 7px 0 0 0; }
        th:last-child { border-radius: 0 7px 0 0; }
        td { padding: 13px 18px; border-bottom: 1px solid #e9edf3; vertical-align: middle; }
        tbody tr:hover { background: #f7faff; }
        tbody tr:last-child td { border-bottom: 0; }
        .avatar { width: 72px; height: 72px; border-radius: 8px; display: block; object-fit: cover; }
        .name { font-weight: 600; color: #243246; }
        .note { margin: 18px 0 0; font-size: 13px; color: #768296; }
        @media (max-width: 600px) {
            body { padding: 20px 10px; }
            .container { padding: 18px 12px; }
            h1 { font-size: 23px; }
        }
    </style>
</head>
<body>
<main class="container">
    <h1>Danh sách khách hàng</h1>
    <p class="subtitle">Thông tin khách hàng được hiển thị bằng JSP và JSTL.</p>

    <div class="table-wrap">
        <table>
            <thead>
                <tr>
                    <th scope="col">Họ và tên</th>
                    <th scope="col">Ngày sinh</th>
                    <th scope="col">Địa chỉ</th>
                    <th scope="col">Ảnh</th>
                </tr>
            </thead>
            <tbody>
                <%-- Su dung JSTL c:forEach de lap qua danh sach. --%>
                <c:forEach var="customer" items="${customers}">
                    <tr>
                        <td class="name"><c:out value="${customer.name}"/></td>
                        <td><c:out value="${customer.birthday}"/></td>
                        <td><c:out value="${customer.address}"/></td>
                        <td>
                            <img class="avatar"
                                 src="${pageContext.request.contextPath}/${customer.image}"
                                 alt="Ảnh đại diện khách hàng"
                                 width="72" height="72">
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty customers}">
                    <tr><td colspan="4">Chưa có khách hàng nào.</td></tr>
                </c:if>
            </tbody>
        </table>
    </div>
    <p class="note">Dữ liệu minh họa phục vụ bài thực hành JSTL.</p>
</main>
</body>
</html>
