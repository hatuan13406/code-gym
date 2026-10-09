# Luyện tập MySQL JDBC Transaction

Bài tập CodeGym: cập nhật ứng dụng quản lý User, sử dụng `commit()` và `rollback()` để kiểm nghiệm nguyên lý **All-or-Nothing**.

## Nội dung mã nguồn

- `IUserDAO.java`: khai báo `addUserTransaction(User user, int[] permissionIds)`, một overload để mô phỏng SQL sai và `userExistsByEmail()` để kiểm tra kết quả.
- `UserDAO.java`: gọi `setAutoCommit(false)`, thực thi INSERT User và user_permission, `commit()` nếu không lỗi, `rollback()` khi lỗi.
- `UserServlet.java`: xử lý POST action `test-add-user-transaction`; chỉ cho phép truy cập từ localhost; xử lý SQLException do cố ý sai cột.
- `user/list.jsp`: nút **Thử SQL lỗi và Rollback**.
- `transaction-result.jsp`: hiển thị lỗi SQL, email và kết quả kiểm tra dữ liệu sau rollback.
- `database.sql`: tạo bảng users, permission và user_permission, các stored procedure và truy vấn kiểm tra.

## Chạy bài

Yêu cầu JDK 17+, Maven, MySQL và Tomcat 10.1+.

1. Mở MySQL Workbench, chạy `database.sql` để chuẩn bị database `demo`. Kiểm tra cả bảng `users` và `user_permission` dùng **InnoDB**.
2. Đặt biến môi trường `DB_URL`, `DB_USER`, `DB_PASSWORD` theo MySQL tại máy (hoặc dùng cài đặt mặc định trỏ đến `demo`; tuyệt đối không commit mật khẩu lên GitHub).
3. Đóng gói:
   ```bash
   mvn clean package
   ```
4. Deploy `target/user-management-transaction-practice.war` vào `webapps/` của Tomcat.
5. Mở `http://localhost:8080/user-management-transaction-practice/users`. Nhấn **Thử SQL lỗi và Rollback**.

## Kết quả cần quan sát

- Khi tạo User thông thường, phương thức 2 tham số `addUserTransaction(user, permissionIds)` thực thi SQL hợp lệ, gọi **commit()**, lưu User và các quyền.
- Khi nhấn nút thử nghiệm, cùng phương thức `addUserTransaction(..., true)` chèn User trước, sau đó chạy câu SQL không hợp lệ sử dụng tên cột `invalid_permission_column` trong bảng `user_permission`. MySQL dự kiến trả lỗi **1054 / 42S22**, từ đó Java bắt SQLException và gọi **rollback()**.
- Servlet kiểm tra lại bằng một truy vấn SELECT trên email ngẫu nhiên của người dùng thử nghiệm; nếu `users` không còn bản ghi, trang sẽ báo **ĐÃ ROLLBACK**.
- Copy email trên trang kết quả, kiểm tra thủ công trong MySQL:
  ```sql
  SELECT * FROM demo.users WHERE email = 'THAY_BANG_EMAIL_TREN_TRANG_KET_QUA';
  ```
  Kết quả đúng: **0 bản ghi**.

> Lưu ý: Không chạy bài trên cơ sở dữ liệu có dữ liệu quan trọng. Không sửa SQL trong chế độ tạo User bình thường. Chức năng thử nghiệm chỉ chạy trên localhost và không xóa dữ liệu cũ.
