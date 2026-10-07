# AI Prompt Log - AutoRide

## 1. Kiểu dữ liệu cho tiền

**Prompt:** Với tiền cọc, phí trả trễ và phí hư hỏng trong MySQL, nên dùng FLOAT hay DECIMAL?

**Kết quả rút ra:** Dùng `DECIMAL(12,2)` vì tiền tệ cần độ chính xác thập phân. `FLOAT` và `DOUBLE` có thể xuất hiện sai số biểu diễn nhị phân.

## 2. Quan hệ Rentals - Inspections

**Prompt:** Khi thiết kế biên bản kiểm tra xe, quan hệ 1-1 và 1-N khác nhau thế nào? Trường hợp thuê xe nên chọn loại nào?

**Kết quả rút ra:** 1-1 phù hợp khi mỗi hợp đồng chắc chắn chỉ có một biên bản. 1-N linh hoạt hơn nếu cần kiểm tra trước giao, khi trả xe hoặc kiểm tra bổ sung. Bài này chọn 1-N.

## 3. ENUM cho vòng đời hợp đồng

**Prompt:** Làm thế nào để đổi cột status VARCHAR thành ENUM('BOOKED','ACTIVE','COMPLETED','CANCELLED') bằng ALTER TABLE?

**Kết quả rút ra:** Dùng `ALTER TABLE ... MODIFY COLUMN status ENUM(...) NOT NULL DEFAULT 'BOOKED'` và đảm bảo dữ liệu cũ đều thuộc tập giá trị hợp lệ trước khi đổi kiểu.

## 4. Xử lý NULL khi tính tiền hoàn lại

**Prompt:** Khi tính refund = security_deposit - late_fee - damage_fee, nên xử lý NULL thế nào?

**Kết quả rút ra:** Dùng `COALESCE(late_fee, 0)` và `COALESCE(damage_fee, 0)` để tránh toàn bộ biểu thức trở thành NULL.

## 5. ON DELETE RESTRICT

**Prompt:** Vì sao nên dùng ON DELETE RESTRICT giữa Rentals và Inspections?

**Kết quả rút ra:** `RESTRICT` ngăn xóa hợp đồng khi vẫn còn biên bản kiểm tra, giúp bảo toàn lịch sử nghiệp vụ và dữ liệu đối soát.

## 6. Chặn kiểm tra khi hợp đồng BOOKED

**Prompt:** Cơ sở dữ liệu có thể ngăn INSERT vào Inspections khi Rentals vẫn BOOKED bằng cách nào?

**Kết quả rút ra:** Dùng `BEFORE INSERT TRIGGER`, đọc trạng thái hợp đồng và phát `SIGNAL SQLSTATE '45000'` nếu trạng thái là `BOOKED` hoặc `CANCELLED`.
