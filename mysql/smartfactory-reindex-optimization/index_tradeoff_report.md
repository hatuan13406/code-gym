# Báo cáo đánh đổi Index - SmartFactory

`idx_fat_covering(sensor_id, recorded_at, temperature, humidity, status)` giúp truy vấn Dashboard có thể trở thành covering query, tức MySQL đọc đủ dữ liệu ngay trên secondary index mà không cần quay lại clustered index. Điều này làm SELECT rất nhanh, nhưng không phù hợp với hệ thống IoT có lưu lượng ghi cực lớn.

Mỗi bản ghi mới không chỉ được chèn vào clustered index theo `log_id`, mà còn phải tạo và duy trì entry trong secondary index. Index càng rộng, số byte cần ghi càng lớn, nhiều page phải được đọc/ghi hơn và khả năng page split cũng tăng. Vì vậy chi phí INSERT, redo log, Buffer Pool và dung lượng SSD đều tăng.

Giải pháp là thay bằng `idx_lean_search(sensor_id, recorded_at)`. Hai cột này đủ để lọc cảm biến và khoảng thời gian. MySQL sau đó lookup bảng gốc để lấy `temperature`, `humidity`, `status`. SELECT có thể chậm hơn một chút, nhưng vẫn dùng Index và đổi lại chi phí ghi cùng dung lượng được giảm đáng kể.

Số MB và phần trăm tiết kiệm phải lấy từ `information_schema.TABLES` trước/sau khi đổi Index. Không nên coi các con số 5x hoặc 70% là kết quả thật nếu chưa đo trên dữ liệu thực tế.
