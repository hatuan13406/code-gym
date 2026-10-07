# Consistency Report - HealthSync

Thiết kế cơ sở dữ liệu cũ có ba điểm vênh nghiêm trọng với quy trình nghiệp vụ. Thứ nhất, bảng `Appointments` chỉ có cột `is_active` kiểu Boolean, trong khi một lịch hẹn phải trải qua năm trạng thái `PENDING`, `CONFIRMED`, `CHECKED_IN`, `COMPLETED` và `CANCELLED`. Boolean chỉ phân biệt hai trạng thái nên không thể phản ánh đúng vòng đời của lịch hẹn, gây khó khăn cho Backend khi kiểm tra điều kiện nghiệp vụ.

Thứ hai, thiết kế cũ không có `deposit_amount`, `penalty_fee` và `cancel_reason`. Vì vậy hệ thống không thể lưu tiền cọc, số tiền bị phạt khi hủy lịch hoặc nguyên nhân hủy. Điều này ảnh hưởng trực tiếp đến khả năng đối soát doanh thu, hoàn tiền và kiểm tra lịch sử giao dịch. Các giá trị tài chính được thiết kế bằng `DECIMAL` để tránh sai số làm tròn của `FLOAT` hoặc `DOUBLE`.

Thứ ba, cơ sở dữ liệu hoàn toàn thiếu bảng `Prescriptions`. Khi lịch hẹn đã `COMPLETED`, bác sĩ không có nơi lưu đơn thuốc. Thiết kế mới bổ sung bảng `Prescriptions` liên kết với `Appointments` bằng khóa ngoại và ràng buộc duy nhất trên `appointment_id`. Trigger cũng được dùng để ngăn việc tạo đơn thuốc cho lịch hẹn chưa hoàn tất. Nhờ đó ERD mới bám sát quy trình nghiệp vụ và bảo vệ tính toàn vẹn dữ liệu.
