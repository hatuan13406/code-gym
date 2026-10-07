# ER - Activity Mapping: AutoRide

Thiết kế cũ bị lệch với quy trình thực tế ở ba điểm chính. Thứ nhất, bảng `Rentals` không có các cột `security_deposit`, `late_fee` và `damage_fee`, nên hệ thống không thể tính đúng số tiền hoàn lại sau khi khách trả xe. Trong đó, `damage_fee` là bắt buộc vì thiệt hại vật lý của xe tạo ra chi phí sửa chữa thực tế. Nếu không lưu khoản này, kế toán không thể đối soát doanh thu, nhân viên không thể khấu trừ tiền cọc và doanh nghiệp có nguy cơ hoàn tiền sai.

Thứ hai, `status` dạng `VARCHAR` cho phép nhập tùy ý, dễ tạo dữ liệu không hợp lệ. Thiết kế mới dùng `ENUM('BOOKED','ACTIVE','COMPLETED','CANCELLED')` để khóa chặt vòng đời hợp đồng.

Thứ ba, thiết kế cũ không có bảng `Inspections`. Việc tách biên bản kiểm tra thành bảng riêng giúp một hợp đồng có thể lưu nhiều lần kiểm tra, ngày kiểm tra, người kiểm tra và mô tả hư hỏng mà không làm bảng `Rentals` phình to. Quan hệ `Rentals 1-N Inspections` cũng thuận lợi cho mở rộng nghiệp vụ và lưu vết lịch sử.
