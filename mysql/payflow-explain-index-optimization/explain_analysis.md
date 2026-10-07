# Phân tích EXPLAIN trước và sau tối ưu

Trước tối ưu, truy vấn dùng `YEAR(created_at)` và `MONTH(created_at)`. Đây là dạng **Non-SARGable** vì MySQL phải tính hàm trên từng dòng trước khi kiểm tra điều kiện. Khi chưa có index phù hợp, `EXPLAIN` thường cho `type = ALL`, `possible_keys = NULL` và `rows` xấp xỉ số dòng của bảng, tức Full Table Scan.

Sau tối ưu, tạo composite index `idx_type_date(transaction_type, created_at)` và đổi điều kiện ngày sang khoảng `created_at >= ... AND created_at < ...`. Truy vấn trở thành SARGable nên MySQL có thể tìm theo B-Tree. `possible_keys` và `key` có thể hiển thị `idx_type_date`, còn `type` thường chuyển sang `range` hoặc `ref`.

Giá trị `rows` sau tối ưu phải giảm mạnh so với trước, nhưng con số cụ thể phụ thuộc số lượng dữ liệu, phân bố giá trị và thống kê của Optimizer.
