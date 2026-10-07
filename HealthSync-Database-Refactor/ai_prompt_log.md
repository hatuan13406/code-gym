# AI Prompt Log - HealthSync

## 1. Lifecycle status

**Prompt:** Trong thiết kế cơ sở dữ liệu quan hệ, tại sao dùng một cột `is_active` kiểu Boolean để theo dõi vòng đời của lịch hẹn là một anti-pattern? Nên thay thế bằng cấu trúc nào?

**Kết quả rút ra:** Boolean chỉ thể hiện hai trạng thái. Với quy trình nhiều trạng thái nên dùng `ENUM` hoặc bảng trạng thái riêng. Trong bài này sử dụng `ENUM('PENDING','CONFIRMED','CHECKED_IN','COMPLETED','CANCELLED')`.

## 2. Kiểu dữ liệu tài chính

**Prompt:** Với `deposit_amount` và `penalty_fee` trong MySQL, nên dùng `FLOAT`, `DOUBLE` hay `DECIMAL`? Vì sao?

**Kết quả rút ra:** Chọn `DECIMAL(12,2)` vì lưu giá trị thập phân chính xác, phù hợp cho tiền tệ và tránh sai số biểu diễn nhị phân của `FLOAT` hoặc `DOUBLE`.

## 3. ALTER TABLE

**Prompt:** Cú pháp MySQL để xóa cột `is_active` và thêm cột `status` kiểu `ENUM` vào bảng có sẵn là gì?

**Kết quả rút ra:** Có thể dùng `ALTER TABLE ... DROP COLUMN ... , ADD COLUMN ...` để tái cấu trúc bảng mà không cần xóa toàn bộ dữ liệu.

## 4. Khóa ngoại và ON DELETE

**Prompt:** Với quan hệ giữa lịch hẹn và đơn thuốc, nên dùng `ON DELETE CASCADE` hay `ON DELETE RESTRICT` nếu cần bảo toàn lịch sử khám chữa bệnh?

**Kết quả rút ra:** Chọn `RESTRICT` để tránh việc xóa một lịch hẹn làm mất đơn thuốc liên quan. Điều này phù hợp hơn với dữ liệu y tế cần lưu vết.

## 5. Trigger bảo vệ nghiệp vụ

**Prompt:** Làm thế nào để ngăn việc thêm đơn thuốc cho một lịch hẹn chưa ở trạng thái `COMPLETED` ngay tại tầng cơ sở dữ liệu?

**Kết quả rút ra:** Dùng `BEFORE INSERT` và `BEFORE UPDATE` trigger trên bảng `Prescriptions`, kiểm tra trạng thái của lịch hẹn và dùng `SIGNAL SQLSTATE '45000'` nếu trạng thái không hợp lệ.
