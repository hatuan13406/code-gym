# Bài thực hành: Ứng dụng Từ điển đơn giản - Servlet

## 1. Cấu trúc dự án

```text
jsp-servlet-dictionary/
├── pom.xml
└── src/
    └── main/
        ├── java/
        │   └── com/
        │       └── codegym/
        │           └── DictionaryServlet.java
        └── webapp/
            ├── index.jsp
            └── WEB-INF/
                └── web.xml
```

Dự án dùng Java 17, Maven, Jakarta Servlet API 6.0 và tương thích Tomcat 10.1+.

---

## 2. pom.xml

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">

    <modelVersion>4.0.0</modelVersion>

    <groupId>com.codegym</groupId>
    <artifactId>jsp-servlet-dictionary</artifactId>
    <packaging>war</packaging>
    <version>1.0-SNAPSHOT</version>
    <name>Dictionary Maven Webapp</name>

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
        <finalName>jsp-servlet-dictionary</finalName>
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

## 3. index.jsp

```jsp
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Từ điển Anh - Việt</title>
</head>
<body>
    <h2>Từ Điển Anh - Việt</h2>

    <form action="translate" method="POST">
        <input
            type="text"
            name="word"
            placeholder="Nhập từ tiếng Anh..."
            required
            autofocus
        >
        <button type="submit">Tìm kiếm</button>
    </form>
</body>
</html>
```

Điểm quan trọng:
- Form dùng `method="POST"`
- Form gửi tới `action="translate"`
- Tên input là `word`

---

## 4. DictionaryServlet.java

```java
package com.codegym;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "DictionaryServlet", urlPatterns = {"/translate"})
public class DictionaryServlet extends HttpServlet {

    private final Map<String, String> dictionary = new HashMap<>();

    @Override
    public void init() throws ServletException {
        dictionary.put("hello", "Xin chào");
        dictionary.put("how", "Thế nào");
        dictionary.put("book", "Quyển sách");
        dictionary.put("computer", "Máy tính");
        dictionary.put("student", "Sinh viên");
        dictionary.put("teacher", "Giáo viên");
        dictionary.put("school", "Trường học");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String searchWord = request.getParameter("word");

        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html lang='vi'>");
            out.println("<head><meta charset='UTF-8'><title>Kết quả tra cứu</title></head>");
            out.println("<body>");

            if (searchWord != null && !searchWord.trim().isEmpty()) {
                String normalizedWord = searchWord.trim().toLowerCase();
                String result = dictionary.get(normalizedWord);

                if (result != null) {
                    out.println("<h2>Từ khóa: " + escapeHtml(searchWord.trim()) + "</h2>");
                    out.println("<h3>Nghĩa tiếng Việt: " + result + "</h3>");
                } else {
                    out.println("<h2>Không tìm thấy từ: " + escapeHtml(searchWord.trim()) + "</h2>");
                }
            } else {
                out.println("<h2>Vui lòng nhập từ khóa hợp lệ!</h2>");
            }

            out.println("<a href='" + request.getContextPath() + "/'>Quay lại</a>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    private String escapeHtml(String value) {
        return value
                .replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace(""", "&quot;")
                .replace("'", "&#39;");
    }
}
```

Từ điển có sẵn:
- `hello` → `Xin chào`
- `how` → `Thế nào`
- `book` → `Quyển sách`
- `computer` → `Máy tính`
- `student` → `Sinh viên`
- `teacher` → `Giáo viên`
- `school` → `Trường học`

Nếu không tìm thấy, Servlet trả về:

```text
Không tìm thấy từ: [từ_khóa]
```

---

## 5. web.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="https://jakarta.ee/xml/ns/jakartaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="https://jakarta.ee/xml/ns/jakartaee https://jakarta.ee/xml/ns/jakartaee/web-app_6_0.xsd"
         version="6.0">

    <display-name>JSP Servlet Dictionary</display-name>

    <welcome-file-list>
        <welcome-file>index.jsp</welcome-file>
    </welcome-file-list>

</web-app>
```

Servlet được ánh xạ bằng:

```java
@WebServlet(name = "DictionaryServlet", urlPatterns = {"/translate"})
```

---

## 6. Prompt AI Agent đã sử dụng

> Hãy tạo dự án Maven Webapp Java JSP/Servlet tương thích Tomcat 10.1+, groupId com.codegym, artifactId jsp-servlet-dictionary. Tạo pom.xml, index.jsp, WEB-INF/web.xml và DictionaryServlet.java. index.jsp có form POST với input name="word" gửi tới /translate. DictionaryServlet dùng Map để lưu các cặp từ Anh - Việt, tra cứu từ người dùng nhập và hiển thị nghĩa hoặc thông báo không tìm thấy.

Kiểm tra sau khi AI tạo dự án:
- dùng `jakarta.servlet.*`
- packaging là `war`
- form dùng POST
- Servlet dùng `doPost()`
- mapping là `/translate`
- dữ liệu từ form được lấy bằng `request.getParameter("word")`

---

## 7. Build Maven

Chạy:

```bash
mvn clean package
```

Kết quả mong đợi:

```text
BUILD SUCCESS
```

File WAR được tạo:

```text
target/jsp-servlet-dictionary.war
```

---

## 8. Deploy Tomcat 10.1+

Ví dụ Windows:

```powershell
mvn clean package
copy target\jsp-servlet-dictionary.war "C:\Tomcat 10.1\webapps\jsp-servlet-dictionary.war"
cd "C:\Tomcat 10.1\bin"
startup.bat
```

Truy cập:

```text
http://localhost:8080/jsp-servlet-dictionary/
```

---

## 9. Kiểm thử

### Test 1

```text
word = hello
```

Kết quả:

```text
Nghĩa tiếng Việt: Xin chào
```

### Test 2

```text
word = book
```

Kết quả:

```text
Nghĩa tiếng Việt: Quyển sách
```

### Test 3

```text
word = apple
```

Kết quả:

```text
Không tìm thấy từ: apple
```

Bài đáp ứng yêu cầu tạo Servlet, nhận dữ liệu từ form POST, tra cứu dữ liệu trong Map và trả kết quả về trình duyệt.
