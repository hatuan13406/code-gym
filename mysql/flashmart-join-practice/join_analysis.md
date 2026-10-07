# Phân tích COUNT trong LEFT JOIN

Trong báo cáo Marketing, `Customers` là bảng bên trái nên `LEFT JOIN` vẫn tạo một dòng cho khách hàng chưa có đơn hàng. Với dòng đó, các cột của `Orders` đều là `NULL`.

Nếu dùng `COUNT(*)`, MySQL đếm cả dòng do `LEFT JOIN` tạo ra, vì vậy Charlie có thể bị tính thành 1 đơn dù thực tế chưa mua gì.

Dùng `COUNT(o.order_id)` chính xác hơn vì `order_id` là khóa chính, chỉ có giá trị khi thật sự tồn tại đơn hàng. Hàm `COUNT(column)` bỏ qua `NULL`, nên Alice = 2, Bob = 1 và Charlie = 0.
