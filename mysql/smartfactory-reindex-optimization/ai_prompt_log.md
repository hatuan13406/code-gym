# AI Prompt Log - SmartFactory Index Trade-off

## 1. Covering Index là gì?

**Prompt:** Covering Index trong MySQL là gì và vì sao nó có thể làm SELECT nhanh hơn?

**AI trả lời:** Một Index được gọi là covering khi nó chứa đủ các cột cần cho điều kiện lọc và dữ liệu SELECT. MySQL có thể trả kết quả trực tiếp từ secondary index mà không cần quay lại clustered index để lấy row đầy đủ. Trong EXPLAIN, trường hợp này thường có `Using index` trong cột Extra.

## 2. Clustered Index và Secondary Index trong InnoDB

**Prompt:** InnoDB lưu clustered index và secondary index khác nhau như thế nào?

**AI trả lời:** InnoDB tổ chức bảng theo clustered index, thường là Primary Key. Leaf page của clustered index chứa toàn bộ row. Leaf entry của secondary index chứa khóa phụ và Primary Key của row, để MySQL có thể dùng Primary Key quay lại clustered index khi cần lấy thêm cột.

## 3. Write Penalty của Index

**Prompt:** Vì sao thêm nhiều cột vào một Composite Index làm INSERT chậm hơn?

**AI trả lời:** Mỗi INSERT phải tạo thêm một entry lớn hơn trong Index, cập nhật B-Tree, ghi redo log và có thể gây page split. Entry càng rộng thì ít entry vừa trong một page hơn, khiến cây lớn hơn và tăng I/O cũng như áp lực Buffer Pool.

## 4. Ước lượng byte của Fat Index

**Prompt:** Hãy ước lượng thô số byte của các kiểu dữ liệu trong idx_fat_covering.

**AI trả lời:** Với MySQL hiện đại, `INT` thường 4 byte, `BIGINT` 8 byte, `DATETIME` không có phần thập phân khoảng 5 byte, và `DECIMAL(5,2)` khoảng 3 byte. `VARCHAR(20)` phụ thuộc charset và nội dung; với utf8mb4 có thể cần tối đa khoảng 80 byte cho ký tự, cộng byte lưu độ dài. Secondary index còn lưu Primary Key. Đây chỉ là ước lượng payload, chưa gồm record/page overhead.

## 5. So sánh Fat và Lean Index về kích thước

**Prompt:** Từ các kích thước kiểu dữ liệu trên, Lean Index có thể tiết kiệm gì?

**AI trả lời:** Lean Index chỉ cần `sensor_id` khoảng 4 byte, `recorded_at` khoảng 5 byte và Primary Key `log_id` khoảng 8 byte trong leaf entry, chưa tính overhead. Fat Index còn thêm hai `DECIMAL(5,2)` và một `VARCHAR(20)`, nên entry có thể rộng hơn nhiều. Mức tiết kiệm thực tế phải đo bằng `INDEX_LENGTH`.

## 6. Using index và Using index condition

**Prompt:** Sau khi bỏ Covering Index, vì sao EXPLAIN có thể hiện Using index condition thay vì Using index?

**AI trả lời:** `Using index` thường chỉ covering index. `Using index condition` là Index Condition Pushdown, nghĩa là MySQL lọc một phần điều kiện tại tầng Index nhưng vẫn phải đọc row từ bảng để lấy các cột không nằm trong Index.

## 7. Khi nào Covering Index vẫn hợp lý?

**Prompt:** Nếu bảng gần như chỉ đọc, rất ít INSERT/UPDATE/DELETE, Covering Index có còn xấu không?

**AI trả lời:** Không nhất thiết. Với workload thiên về đọc và dữ liệu ít thay đổi, chi phí ghi thấp nên Covering Index có thể là lựa chọn hợp lý nếu nó giảm đáng kể I/O cho các truy vấn quan trọng. Quyết định phải dựa vào workload, dung lượng và số liệu đo thực tế.

## 8. VARCHAR(20) so với TINYINT cho status

**Prompt:** Đổi status từ VARCHAR(20) sang TINYINT có tác động gì tới Data Length và Index Length?

**AI trả lời:** `TINYINT` chỉ cần khoảng 1 byte, trong khi `VARCHAR(20)` có thể cần nhiều byte tùy charset và chuỗi thực tế. Nếu status nằm trong bảng hoặc trong Index, dùng mã số nhỏ có thể giảm Data Length và Index Length. Đổi lại, ứng dụng cần ánh xạ mã số sang ý nghĩa như NORMAL, WARNING, CRITICAL.
