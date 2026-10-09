# iNotes – Case Study Java Web (Strategy Pattern)

Ứng dụng quản lý ghi chú cá nhân với **Java 17**, **Servlet/JSP (Tomcat 10.1+)**, **Maven**, **JDBC MySQL** và **File TXT**. Code nghiệp vụ không thay đổi khi chuyển nguồn lưu trữ.

## Các chức năng

- Thêm mới, xem chi tiết, sửa, xóa ghi chú
- Tìm kiếm nội dung hoặc tiêu đề, không phân biệt chữ hoa/chữ thường
- Phân loại **Cá nhân**, **Công việc**, **Học tập**; lọc theo danh mục
- Đổi chiến lược lưu trữ **File TXT / MySQL** ngay trên Dashboard
- Validate độ dài và typeId, escape HTML trong JSP, SQL PreparedStatement, CSRF token cho các form POST
- File TXT được ghi UTF-8, thay thế nguyên tử; nội dung có dấu `|` và xuống dòng được escape an toàn

## Cấu trúc MVC / Strategy Pattern

```
src/main/java/com/codegym/
  model/Note.java
  model/NoteType.java
  storage/NoteStrategy.java
  storage/NoteDBStrategy.java
  storage/NoteFileStrategy.java
  storage/StorageException.java
  service/NoteManagement.java
  web/NotesServlet.java

src/main/webapp/
  index.jsp
  assets/style.css
  WEB-INF/web.xml
  WEB-INF/views/list.jsp
  WEB-INF/views/form.jsp
  WEB-INF/views/detail.jsp
  WEB-INF/views/error.jsp
```

`NoteStrategy` định nghĩa `save(Note)`, `delete(int)`, `findAll()`, `search(String)` và hai hàm phụ `findById(int)`, `findTypes()`. `NoteManagement` giữ `private volatile NoteStrategy strategy;` và `setStrategy(...)`; `NotesServlet` chỉ sử dụng tầng nghiệp vụ.

## Cách cài đặt

1. Cài **JDK 17+**, **Maven**, **Tomcat 10.1+**.
2. Tại thư mục `inotes-case-study`, chạy:
   ```bash
   mvn clean package
   ```
3. Sao chép `target/inotes.war` vào thư mục `webapps` của Tomcat, khởi động lại Tomcat.
4. Mở **http://localhost:8080/inotes/notes**. Ứng dụng mặc định chạy ở **chế độ File TXT**, không cần MySQL.

## Cấu hình MySQL

1. Mở MySQL Workbench, chạy toàn bộ file `database.sql` để tạo `inotes_db` và hai bảng quan hệ 1-N.
2. Cấu hình biến môi trường trước khi khởi chạy Tomcat:

   | Biến | Giá trị mặc định | Ý nghĩa |
   |---|---|---|
   | `INOTES_DB_URL` | `jdbc:mysql://localhost:3306/inotes_db?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC` | JDBC URL |
   | `INOTES_DB_USER` | `root` | User MySQL |
   | `INOTES_DB_PASSWORD` | *(rỗng)* | Password MySQL |
   | `INOTES_FILE_PATH` | `~/.inotes/notes.txt` | Nơi lưu file TXT |

3. Truy cập Dashboard và nhấn **MySQL** tại vùng chuyển lưu trữ.

**Quan trọng:** Khi chuyển File ↔ MySQL, ứng dụng **không tự động di chuyển ghi chú** giữa hai kho. Mỗi chiến lược sử dụng dữ liệu riêng. Chỉ chuyển thành công khi backend đã sẵn sàng. Chế độ lưu trữ chung cho một phiên chạy ứng dụng (không có đăng nhập, không phục vụ multi-tenant).

## Format File

Một ghi chú là một dòng:

```text
id|title|content|typeId
```

Văn bản escape `\\`, `|`, dấu xuống dòng thành `\\`, `\\|`, `\\n`, `\\r` theo thứ tự, giữ đủ 4 trường và hỗ trợ Unicode. Đừng sửa trực tiếp file khi Tomcat đang ghi dữ liệu.

## Kiểm thử nhanh

1. Ở chế độ File, thêm ghi chú thuộc **Học tập**, tiêu đề `Ôn Servlet`, nội dung `Strategy Pattern\nJDBC`.
2. Tìm `Strategy`; lọc **Học tập**; xem, sửa, xóa ghi chú.
3. Chuyển MySQL sau khi tạo bảng; làm lại các thao tác để thấy dữ liệu đi vào bảng `notes`.
4. Quay lại File, ghi chú từ File còn nguyên.
5. Chạy `NoteFileStrategySelfTest` khi có JDK:

```bash
mkdir -p target/selftest
javac --release 17 -encoding UTF-8 -d target/selftest \
  src/main/java/com/codegym/model/Note.java \
  src/main/java/com/codegym/model/NoteType.java \
  src/main/java/com/codegym/storage/NoteStrategy.java \
  src/main/java/com/codegym/storage/StorageException.java \
  src/main/java/com/codegym/storage/NoteFileStrategy.java \
  src/main/java/com/codegym/service/NoteManagement.java \
  src/test/java/com/codegym/storage/NoteFileStrategySelfTest.java
java -cp target/selftest com.codegym.storage.NoteFileStrategySelfTest
```

> Chưa triển khai xác thực tài khoản người dùng. Đây là ứng dụng thực hành, không nên mở công khai trên Internet hoặc dùng để lưu bí mật cá nhân.
