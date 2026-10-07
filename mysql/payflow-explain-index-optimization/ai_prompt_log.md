# AI Prompt Log - PayFlow EXPLAIN & Index

## 1. SARGable là gì?

**Prompt:** SARGable trong SQL là gì và tại sao việc viết `YEAR(created_at) = 2026` có thể làm Index hoạt động kém?

**AI trả lời:** SARGable là điều kiện tìm kiếm có thể được Optimizer ánh xạ trực tiếp thành phạm vi khóa trong Index. Khi bọc cột bằng hàm như `YEAR(created_at)`, MySQL thường phải tính hàm cho từng dòng nên không thể tìm trực tiếp theo phạm vi giá trị gốc của `created_at`. Viết điều kiện `created_at >= ... AND created_at < ...` giúp B-Tree được sử dụng hiệu quả.

## 2. Ý nghĩa các giá trị type trong EXPLAIN

**Prompt:** Trong MySQL EXPLAIN, ALL, index, range, ref và const khác nhau như thế nào?

**AI trả lời:** `ALL` thường là quét toàn bảng. `index` là quét toàn bộ Index. `range` đọc một khoảng khóa trong Index. `ref` tìm các dòng qua giá trị khóa không duy nhất. `const` thường xuất hiện khi Optimizer biết truy vấn chỉ cần một bản ghi cố định, ví dụ tìm theo Primary Key hoặc Unique Key với hằng số.

## 3. Thứ tự cột trong Composite Index

**Prompt:** Với Index `(transaction_type, created_at)`, thứ tự cột có quan trọng không?

**AI trả lời:** Có. Composite B-Tree tuân theo nguyên tắc leftmost prefix. Với truy vấn có `transaction_type = 'DEPOSIT'` và `created_at` là khoảng thời gian, đặt cột so sánh bằng trước rồi cột range sau thường phù hợp vì MySQL có thể thu hẹp theo loại giao dịch rồi tiếp tục quét đúng khoảng ngày.

## 4. Index Seek và Index Scan

**Prompt:** Index Seek khác Index Scan ở điểm nào?

**AI trả lời:** Index Seek dùng cấu trúc cây để đi thẳng tới vùng khóa cần thiết rồi đọc một phần nhỏ dữ liệu. Index Scan phải duyệt nhiều hoặc toàn bộ các entry trong Index. Seek thường có lợi khi điều kiện lọc chọn ra tỷ lệ nhỏ dữ liệu; Scan có thể hợp lý khi cần đọc phần lớn bảng.

## 5. Cấu trúc B-Tree hỗ trợ tìm kiếm như thế nào?

**Prompt:** B-Tree giúp MySQL tìm dữ liệu nhanh hơn Full Table Scan như thế nào?

**AI trả lời:** B-Tree giữ các khóa theo thứ tự và tổ chức theo nhiều mức. MySQL có thể lần theo các node để đến vùng khóa cần tìm thay vì kiểm tra từng dòng. Với điều kiện range, các giá trị liên tiếp trong Index còn giúp quét tuần tự một đoạn nhỏ sau khi tìm được điểm bắt đầu.

## 6. Xem thời gian thực thi thật

**Prompt:** Làm thế nào xem thời gian thực thi thật thay vì chỉ xem kế hoạch EXPLAIN?

**AI trả lời:** Trên MySQL 8.0.18+, `EXPLAIN ANALYZE` vừa chạy truy vấn vừa hiển thị thời gian thực tế, số vòng lặp và số dòng thực tế qua từng bước. `SET profiling = 1` từng được dùng ở các phiên bản cũ nhưng đã bị deprecate, vì vậy `EXPLAIN ANALYZE` thường phù hợp hơn trên MySQL mới.

## 7. Using index condition và Using index

**Prompt:** Trong cột Extra, `Using index condition` khác `Using index` như thế nào?

**AI trả lời:** `Using index condition` thường liên quan Index Condition Pushdown, MySQL lọc thêm điều kiện ngay khi đọc Index nhưng vẫn có thể phải truy cập dòng dữ liệu thật. `Using index` thường chỉ Covering Index, tức toàn bộ dữ liệu cần cho truy vấn đã có trong Index nên không cần đọc thêm row từ bảng.

## 8. Chi phí của quá nhiều Index

**Prompt:** Nếu Transactions có hàng nghìn INSERT/UPDATE/DELETE mỗi giây, tạo quá nhiều Index gây rủi ro gì?

**AI trả lời:** Mỗi thay đổi dữ liệu có thể phải cập nhật nhiều cấu trúc Index, làm tăng I/O, CPU, dung lượng lưu trữ và chi phí bảo trì B-Tree. Nhiều Index có thể giúp đọc nhanh nhưng làm ghi chậm hơn, vì vậy cần cân bằng theo workload thực tế.
