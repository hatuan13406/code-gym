# Ứng dụng chuyển đổi tiền tệ JSP

Bài thực hành CodeGym: đổi USD sang VNĐ sử dụng **JSP Scriptlet** (`<% ... %>`) và **JSP Expression** (`<%= ... %>`).

## Yêu cầu
- JDK 17+
- Apache Maven 3.8+
- Apache Tomcat 10.1+

## Chạy ứng dụng
1. Mở terminal trong thư mục `jsp-currency-converter`.
2. Chạy `mvn clean package`.
3. Sao chép `target/jsp-currency-converter.war` vào thư mục `webapps` của Tomcat 10.1+.
4. Khởi động Tomcat và mở `http://localhost:8080/jsp-currency-converter/`.

## Cách sử dụng
Điền tỉ giá VND/USD và số USD, nhấn **Tính toán** để chuyển sang `converter.jsp`.

Ví dụ: tỉ giá **25.000**, số tiền **100 USD** → **2.500.000 VNĐ**.

## Cấu trúc
- `pom.xml`: cấu hình Maven WAR và Jakarta Servlet/JSP.
- `src/main/webapp/index.jsp`: biểu mẫu POST.
- `src/main/webapp/converter.jsp`: tính toán và hiển thị kết quả.
- `src/main/webapp/WEB-INF/web.xml`: cấu hình Jakarta EE 10.

> Tỉ giá do người dùng nhập, không tự lấy từ ngân hàng.
