# Bài thực hành: Ứng dụng chuyển đổi tiền tệ - Servlet

## 1. Cấu trúc dự án

```text
jsp-servlet-currency-converter/
├── pom.xml
└── src/
    └── main/
        ├── java/
        │   └── com/
        │       └── codegym/
        │           └── ConverterServlet.java
        └── webapp/
            ├── index.jsp
            └── WEB-INF/
                └── web.xml
```

Dự án sử dụng Java 17, Maven, Jakarta Servlet API 6.0 và tương thích Tomcat 10.1+.

---

## 2. pom.xml

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">

    <modelVersion>4.0.0</modelVersion>

    <groupId>com.codegym</groupId>
    <artifactId>jsp-servlet-currency-converter</artifactId>
    <packaging>war</packaging>
    <version>1.0-SNAPSHOT</version>
    <name>Currency Converter Maven Webapp</name>

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
        <finalName>jsp-servlet-currency-converter</finalName>

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
    <title>Currency Converter</title>
</head>
<body>
    <h2>Chuyển đổi USD sang VNĐ</h2>

    <form action="convert" method="POST">
        <label for="rate">Tỉ giá (VND/USD):</label>
        <input id="rate" type="number" name="rate" value="25000" step="any" required>

        <label for="usd">Lượng USD cần đổi:</label>
        <input id="usd" type="number" name="usd" step="any" required>

        <button type="submit">Chuyển đổi</button>
    </form>
</body>
</html>
```

Điểm quan trọng:
- Form dùng `method="POST"`
- Form gửi tới `action="convert"`
- Hai tham số là `rate` và `usd`

---

## 4. ConverterServlet.java

```java
package com.codegym;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.NumberFormat;
import java.util.Locale;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ConverterServlet", urlPatterns = {"/convert"})
public class ConverterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            try {
                double rate = Double.parseDouble(request.getParameter("rate"));
                double usd = Double.parseDouble(request.getParameter("usd"));

                if (rate <= 0 || usd < 0) {
                    throw new NumberFormatException();
                }

                double vnd = rate * usd;

                NumberFormat vndFormat = NumberFormat.getNumberInstance(new Locale("vi", "VN"));
                NumberFormat usdFormat = NumberFormat.getNumberInstance(Locale.US);

                out.println("<!DOCTYPE html>");
                out.println("<html lang='vi'>");
                out.println("<head><meta charset='UTF-8'><title>Currency Converter Result</title></head>");
                out.println("<body>");
                out.println("<h2>KẾT QUẢ CHUYỂN ĐỔI</h2>");
                out.println("<p>Tỉ giá: " + vndFormat.format(rate) + " VND/USD</p>");
                out.println("<p>Số tiền USD: $" + usdFormat.format(usd) + "</p>");
                out.println("<h3>Thành tiền VNĐ: " + vndFormat.format(vnd) + " VNĐ</h3>");
                out.println("<a href='" + request.getContextPath() + "/'>Quay lại</a>");
                out.println("</body>");
                out.println("</html>");

            } catch (NumberFormatException | NullPointerException e) {
                out.println("<!DOCTYPE html>");
                out.println("<html lang='vi'>");
                out.println("<head><meta charset='UTF-8'><title>Lỗi</title></head>");
                out.println("<body>");
                out.println("<h2>Lỗi: Vui lòng nhập số hợp lệ!</h2>");
                out.println("<a href='" + request.getContextPath() + "/'>Quay lại</a>");
                out.println("</body>");
                out.println("</html>");
            }
        }
    }
}
```

Công thức xử lý:

```text
VND = USD × Rate
```

Ví dụ:
- Rate = 25000
- USD = 100
- Kết quả = 2,500,000 VNĐ

---

## 5. web.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="https://jakarta.ee/xml/ns/jakartaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="https://jakarta.ee/xml/ns/jakartaee https://jakarta.ee/xml/ns/jakartaee/web-app_6_0.xsd"
         version="6.0">

    <display-name>JSP Servlet Currency Converter</display-name>

    <welcome-file-list>
        <welcome-file>index.jsp</welcome-file>
    </welcome-file-list>

</web-app>
```

Servlet được định tuyến bằng annotation:

```java
@WebServlet(name = "ConverterServlet", urlPatterns = {"/convert"})
```

---

## 6. Prompt sử dụng với AI Agent

> Hãy tạo một dự án Maven Webapp chuẩn Java JSP/Servlet tương thích Tomcat 10.1+, groupId com.codegym, artifactId jsp-servlet-currency-converter. Tạo pom.xml, index.jsp, WEB-INF/web.xml và ConverterServlet.java. Form index.jsp phải nhập rate và usd, dùng POST gửi tới /convert. ConverterServlet nhận rate và usd, tính VND = USD * Rate và hiển thị kết quả.

Kiểm tra sau khi AI tạo dự án:
- Dùng `jakarta.servlet.*`
- `packaging` là `war`
- `index.jsp` có form POST
- Servlet dùng `doPost()`
- URL mapping là `/convert`

---

## 7. Build bằng Maven

Chạy:

```bash
mvn clean package
```

Kết quả mong đợi:

```text
BUILD SUCCESS
```

File WAR:

```text
target/jsp-servlet-currency-converter.war
```

---

## 8. Deploy Tomcat 10.1+

Ví dụ Windows:

```powershell
mvn clean package
copy target\jsp-servlet-currency-converter.war "C:\Tomcat 10.1\webapps\jsp-servlet-currency-converter.war"
cd "C:\Tomcat 10.1\bin"
startup.bat
```

Truy cập:

```text
http://localhost:8080/jsp-servlet-currency-converter/
```

---

## 9. Kiểm thử

### Test 1

```text
rate = 25000
usd = 100
```

Kết quả mong đợi:

```text
2,500,000 VNĐ
```

### Test 2

Nhập dữ liệu không hợp lệ hoặc rate <= 0.

Kết quả mong đợi:

```text
Lỗi: Vui lòng nhập số hợp lệ!
```

Bài đáp ứng mục tiêu tạo Servlet, nhận dữ liệu từ form POST, tính toán phía server và trả kết quả về trình duyệt.
