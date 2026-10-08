<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>System Time - JSP</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #f8fafc;
            color: #1f2937;
            font-family: Arial, Helvetica, sans-serif;
        }

        .card {
            width: min(680px, calc(100% - 32px));
            padding: 40px;
            text-align: center;
            background: #ffffff;
            border-radius: 16px;
            box-shadow: 0 12px 35px rgba(15, 23, 42, 0.10);
        }

        h1 {
            margin-top: 0;
            color: #1b2a7a;
        }

        .time {
            margin: 24px 0;
            color: #f15a24;
            font-size: 26px;
            font-weight: bold;
        }

        .btn {
            display: inline-block;
            padding: 11px 22px;
            color: white;
            background: #1b2a7a;
            border-radius: 6px;
            text-decoration: none;
        }

        .btn:hover {
            background: #111d5c;
        }
    </style>
</head>

<body>
<%
    LocalDateTime now = LocalDateTime.now();
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
    String formattedTime = now.format(formatter);
%>

<div class="card">
    <h1>Chào mừng tới lớp học Java Web!</h1>

    <p>Đây là trang JSP động được biên dịch trực tiếp bởi Tomcat Server.</p>

    <p>Thời gian hệ thống hiện tại của máy chủ là:</p>

    <div class="time"><%= formattedTime %></div>

    <a class="btn" href="hello">Đi tới HelloServlet</a>
</div>
</body>
</html>
