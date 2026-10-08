# Bài thực hành: Tạo trang web hiển thị thời gian hệ thống

## 1. Cấu trúc dự án Maven Webapp

```text
jsp-servlet-demo/
├── pom.xml
└── src/
    └── main/
        ├── java/
        │   └── com/
        │       └── codegym/
        │           └── HelloServlet.java
        └── webapp/
            ├── index.jsp
            └── WEB-INF/
                └── web.xml
```

Dự án sử dụng Java 17, Maven, Jakarta Servlet API 6.0 và tương thích Tomcat 10.1+.

---

## 2. File pom.xml

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">

    <modelVersion>4.0.0</modelVersion>

    <groupId>com.codegym</groupId>
    <artifactId>jsp-servlet-demo</artifactId>
    <packaging>war</packaging>
    <version>1.0-SNAPSHOT</version>
    <name>jsp-servlet-demo Maven Webapp</name>

    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>

    <dependencies>
        <dependency>
            <groupId>jakarta.servlet</groupId>
            <artifactId>jakarta.servlet-api</artifactId>
            <version>6.0.0</version>
            <scope>provided</scope>
        </dependency>

        <dependency>
            <groupId>jakarta.servlet.jsp</groupId>
            <artifactId>jakarta.servlet.jsp-api</artifactId>
            <version>3.1.1</version>
            <scope>provided</scope>
        </dependency>
    </dependencies>

    <build>
        <finalName>jsp-servlet-demo</finalName>

        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-war-plugin</artifactId>
                <version>3.4.0</version>
            </plugin>
        </plugins>
    </build>
</project>
```

---

## 3. File src/main/java/com/codegym/HelloServlet.java

```java
package com.codegym;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "HelloServlet", urlPatterns = {"/hello"})
public class HelloServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html lang='vi'>");
            out.println("<head>");
            out.println("<meta charset='UTF-8'>");
            out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
            out.println("<title>Hello Servlet</title>");
            out.println("</head>");
            out.println("<body style='font-family: Arial, sans-serif; text-align: center; margin-top: 100px;'>");
            out.println("<h1 style='color: #1b2a7a;'>Chào mừng bạn đến với Servlet đầu tiên!</h1>");
            out.println("<p style='color: #f15a24; font-size: 18px;'>Ứng dụng đang chạy trên Jakarta Servlet / Tomcat 10+</p>");
            out.println("<a href='" + request.getContextPath() + "/'>Quay lại trang chủ JSP</a>");
            out.println("</body>");
            out.println("</html>");
        }
    }
}
```

---

## 4. File src/main/webapp/index.jsp

```jsp
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
```

Trang JSP lấy thời gian trực tiếp từ máy chủ bằng `LocalDateTime.now()` và hiển thị theo định dạng `dd/MM/yyyy HH:mm:ss`.

---

## 5. File src/main/webapp/WEB-INF/web.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="https://jakarta.ee/xml/ns/jakartaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="https://jakarta.ee/xml/ns/jakartaee https://jakarta.ee/xml/ns/jakartaee/web-app_6_0.xsd"
         version="6.0">

    <display-name>JSP Servlet Demo</display-name>

    <welcome-file-list>
        <welcome-file>index.jsp</welcome-file>
    </welcome-file-list>

</web-app>
```

---

## 6. Các bước sử dụng AI Agent

Prompt dùng để khởi tạo dự án:

> Hãy tạo một dự án Maven Webapp tiêu chuẩn cho Java JSP/Servlet tương thích với Tomcat 10.1+. Dùng groupId com.codegym, artifactId jsp-servlet-demo. Tạo cấu trúc src/main/java và src/main/webapp/WEB-INF, file pom.xml, web.xml, index.jsp và HelloServlet.java. Sử dụng Jakarta Servlet API thay cho javax.servlet.

Sau khi AI Agent tạo file, kiểm tra lại:
- `pom.xml` có packaging `war`.
- Package Servlet là `jakarta.servlet.*`.
- `HelloServlet` ánh xạ URL `/hello`.
- `index.jsp` hiển thị thời gian hiện tại của máy chủ.
- `web.xml` dùng schema Jakarta EE Web 6.0.

---

## 7. Đóng gói bằng Maven

Mở Terminal tại thư mục gốc và chạy:

```bash
mvn clean package
```

Khi Maven hiển thị:

```text
BUILD SUCCESS
```

file WAR được tạo tại:

```text
target/jsp-servlet-demo.war
```

---

## 8. Triển khai lên Tomcat 10.1+

Có thể deploy bằng IDE hoặc copy WAR trực tiếp vào thư mục `webapps` của Tomcat.

Ví dụ trên Windows:

```powershell
mvn clean package
copy target\jsp-servlet-demo.war "C:\Tomcat 10.1\webapps\jsp-servlet-demo.war"
cd "C:\Tomcat 10.1\bin"
startup.bat
```

Sau khi Tomcat khởi động, truy cập:

```text
http://localhost:8080/jsp-servlet-demo/
```

Trang Servlet:

```text
http://localhost:8080/jsp-servlet-demo/hello
```

---

## 9. Kết quả mong đợi

- Trang `index.jsp` hiển thị thời gian hiện tại của máy chủ.
- Link `Đi tới HelloServlet` mở Servlet tại đường dẫn `/hello`.
- Servlet chạy đúng với Jakarta Servlet API trên Tomcat 10.1+.
- Maven đóng gói thành công ứng dụng dưới dạng WAR.
