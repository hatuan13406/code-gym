# Bài thực hành: Tạo trang web đăng nhập và hiển thị lời chào

## 1. Cấu trúc dự án Maven Webapp

```text
jsp-servlet-login/
├── pom.xml
└── src/
    └── main/
        ├── java/
        │   └── com/
        │       └── codegym/
        │           └── LoginServlet.java
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
    <artifactId>jsp-servlet-login</artifactId>
    <packaging>war</packaging>
    <version>1.0-SNAPSHOT</version>
    <name>jsp-servlet-login Maven Webapp</name>

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
        <finalName>jsp-servlet-login</finalName>

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

## 3. File src/main/webapp/index.jsp

```jsp
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding-top: 100px;
            background-color: #f8fafc;
            font-family: Arial, sans-serif;
        }

        .login-container {
            width: min(380px, calc(100% - 32px));
            padding: 30px;
            text-align: center;
            background: white;
            border-radius: 8px;
            box-shadow: 0 4px 14px rgba(0, 0, 0, 0.10);
        }

        h2 {
            margin-top: 0;
            color: #1b2a7a;
        }

        input {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 15px;
        }

        button {
            width: 100%;
            margin-top: 10px;
            padding: 10px 20px;
            color: white;
            background-color: #1b2a7a;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        button:hover {
            background-color: #111d5c;
        }
    </style>
</head>

<body>
    <div class="login-container">
        <h2>System Login</h2>

        <form action="login" method="POST">
            <input
                type="text"
                name="username"
                placeholder="Enter username"
                autocomplete="username"
                required
            >

            <input
                type="password"
                name="password"
                placeholder="Enter password"
                autocomplete="current-password"
                required
            >

            <button type="submit">Login</button>
        </form>
    </div>
</body>
</html>
```

Điểm quan trọng của form:

```html
<form action="login" method="POST">
```

Hai tham số gửi tới Servlet là:

```text
username
password
```

---

## 4. File src/main/java/com/codegym/LoginServlet.java

```java
package com.codegym;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html lang='vi'>");
            out.println("<head>");
            out.println("<meta charset='UTF-8'>");
            out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
            out.println("<title>Login Result</title>");
            out.println("</head>");
            out.println("<body style='font-family: Arial, sans-serif; text-align: center; margin-top: 100px; background: #f8fafc;'>");

            if ("admin".equals(user) && "admin".equals(pass)) {
                out.println("<h1 style='color: green;'>Welcome admin to website</h1>");
            } else {
                out.println("<h1 style='color: red;'>Login Error</h1>");
            }

            out.println("<br>");
            out.println("<a href='" + request.getContextPath() + "/' style='color:#1b2a7a;'>Go back</a>");
            out.println("</body>");
            out.println("</html>");
        }
    }
}
```

Logic đăng nhập đúng yêu cầu:
- username = `admin`
- password = `admin`
- đúng: `Welcome admin to website`
- sai: `Login Error`

---

## 5. File src/main/webapp/WEB-INF/web.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="https://jakarta.ee/xml/ns/jakartaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="https://jakarta.ee/xml/ns/jakartaee https://jakarta.ee/xml/ns/jakartaee/web-app_6_0.xsd"
         version="6.0">

    <display-name>JSP Servlet Login</display-name>

    <welcome-file-list>
        <welcome-file>index.jsp</welcome-file>
    </welcome-file-list>

</web-app>
```

Servlet được ánh xạ bằng annotation:

```java
@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
```

---

## 6. Prompt sử dụng với AI Agent

Prompt khởi tạo dự án:

> Hãy tạo một dự án Maven Webapp tiêu chuẩn cho Java JSP/Servlet tương thích với Tomcat 10.1+. Dùng groupId com.codegym và artifactId jsp-servlet-login. Tạo pom.xml, src/main/java, src/main/webapp, WEB-INF/web.xml, index.jsp và LoginServlet.java. index.jsp phải có form POST gửi username và password tới /login. LoginServlet dùng jakarta.servlet, xử lý bằng doPost. Nếu username và password đều là admin thì hiển thị Welcome admin to website, ngược lại hiển thị Login Error.

Sau khi AI tạo file, kiểm tra:
- `pom.xml` có `packaging` là `war`.
- Dùng `jakarta.servlet.*`, không dùng `javax.servlet.*`.
- Form dùng `method="POST"`.
- Form gửi tới `action="login"`.
- Servlet nhận bằng `request.getParameter("username")` và `request.getParameter("password")`.
- Servlet ánh xạ `/login`.

---

## 7. Đóng gói bằng Maven

Mở Terminal tại thư mục gốc dự án và chạy:

```bash
mvn clean package
```

Kết quả mong đợi:

```text
BUILD SUCCESS
```

Maven tạo file:

```text
target/jsp-servlet-login.war
```

---

## 8. Triển khai Tomcat 10.1+

Có thể deploy bằng Community Server Connectors hoặc copy WAR vào thư mục `webapps` của Tomcat.

Ví dụ Windows:

```powershell
mvn clean package
copy target\jsp-servlet-login.war "C:\Tomcat 10.1\webapps\jsp-servlet-login.war"
cd "C:\Tomcat 10.1\bin"
startup.bat
```

Sau khi Tomcat chạy, truy cập:

```text
http://localhost:8080/jsp-servlet-login/
```

---

## 9. Kịch bản kiểm thử

### Trường hợp 1: Đăng nhập đúng

Nhập:

```text
username: admin
password: admin
```

Kết quả:

```text
Welcome admin to website
```

### Trường hợp 2: Đăng nhập sai

Ví dụ:

```text
username: admin
password: 123
```

Kết quả:

```text
Login Error
```

### Trường hợp 3: Kiểm tra phương thức HTTP

Form dùng:

```html
method="POST"
```

và Servlet xử lý bằng:

```java
protected void doPost(...)
```

Đúng mục tiêu luyện tập truyền và nhận dữ liệu qua HTTP POST trong Java Servlet.
