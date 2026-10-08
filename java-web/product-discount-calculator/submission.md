# Bài tập: Product Discount Calculator

## 1. Cấu trúc dự án

```text
product-discount-calculator/
├── pom.xml
└── src/
    └── main/
        ├── java/
        │   └── com/
        │       └── codegym/
        │           └── DiscountServlet.java
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
    <artifactId>product-discount-calculator</artifactId>
    <packaging>war</packaging>
    <version>1.0-SNAPSHOT</version>
    <name>Product Discount Calculator</name>

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
        <finalName>product-discount-calculator</finalName>
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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Discount Calculator</title>
</head>
<body>
    <h1>Product Discount Calculator</h1>

    <form action="display-discount" method="POST">
        <label>Product Description</label>
        <input type="text" name="productDescription" required>

        <label>List Price</label>
        <input type="number" name="listPrice" min="0" step="any" required>

        <label>Discount Percent</label>
        <input type="number" name="discountPercent" min="0" max="100" step="any" required>

        <button type="submit">Calculate Discount</button>
    </form>
</body>
</html>
```

Form dùng:
- `method="POST"`
- `action="display-discount"`

Ba dữ liệu gửi lên:
- `productDescription`
- `listPrice`
- `discountPercent`

---

## 4. DiscountServlet.java

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

@WebServlet(name = "DiscountServlet", urlPatterns = {"/display-discount"})
public class DiscountServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String description = request.getParameter("productDescription");

        try (PrintWriter out = response.getWriter()) {
            try {
                double listPrice = Double.parseDouble(request.getParameter("listPrice"));
                double discountPercent = Double.parseDouble(request.getParameter("discountPercent"));

                if (listPrice < 0 || discountPercent < 0 || discountPercent > 100) {
                    throw new NumberFormatException();
                }

                double discountAmount = listPrice * discountPercent * 0.01;
                double discountPrice = listPrice - discountAmount;

                NumberFormat currency = NumberFormat.getCurrencyInstance(Locale.US);

                out.println("<!DOCTYPE html>");
                out.println("<html lang='en'>");
                out.println("<head><meta charset='UTF-8'><title>Discount Result</title></head>");
                out.println("<body>");
                out.println("<h1>Product Discount Result</h1>");
                out.println("<p><strong>Product Description:</strong> " + escapeHtml(description == null ? "" : description) + "</p>");
                out.println("<p><strong>List Price:</strong> " + currency.format(listPrice) + "</p>");
                out.println("<p><strong>Discount Percent:</strong> " + discountPercent + "%</p>");
                out.println("<p><strong>Discount Amount:</strong> " + currency.format(discountAmount) + "</p>");
                out.println("<p><strong>Discount Price:</strong> " + currency.format(discountPrice) + "</p>");
                out.println("<a href='" + request.getContextPath() + "/'>Back</a>");
                out.println("</body>");
                out.println("</html>");
            } catch (NumberFormatException e) {
                out.println("<h2>Invalid input. Please enter valid values.</h2>");
            }
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

Công thức:

```text
Discount Amount = List Price × Discount Percent × 0.01
Discount Price = List Price - Discount Amount
```

---

## 5. web.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="https://jakarta.ee/xml/ns/jakartaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="https://jakarta.ee/xml/ns/jakartaee https://jakarta.ee/xml/ns/jakartaee/web-app_6_0.xsd"
         version="6.0">

    <display-name>Product Discount Calculator</display-name>

    <welcome-file-list>
        <welcome-file>index.jsp</welcome-file>
    </welcome-file-list>

</web-app>
```

Servlet mapping:

```java
@WebServlet(name = "DiscountServlet", urlPatterns = {"/display-discount"})
```

---

## 6. Build Maven

Chạy:

```bash
mvn clean package
```

Kết quả mong đợi:

```text
BUILD SUCCESS
```

WAR:

```text
target/product-discount-calculator.war
```

---

## 7. Deploy Tomcat 10.1+

Ví dụ Windows:

```powershell
mvn clean package
copy target\product-discount-calculator.war "C:\Tomcat 10.1\webapps\product-discount-calculator.war"
cd "C:\Tomcat 10.1\bin"
startup.bat
```

Truy cập:

```text
http://localhost:8080/product-discount-calculator/
```

---

## 8. Kiểm thử

Ví dụ:

```text
Product Description: Laptop
List Price: 1000
Discount Percent: 10
```

Kết quả:

```text
Discount Amount: 100
Discount Price: 900
```

Bài đáp ứng yêu cầu tạo ứng dụng Web Java, nhận dữ liệu từ form POST, tính toán chiết khấu và hiển thị kết quả tại endpoint /display-discount.
