# AI Prompt Log - FlashMart JOIN

## 1. JOIN mặc định trong MySQL

**Prompt:** Trong MySQL, khi chỉ viết JOIN mà không ghi LEFT hay RIGHT thì nó hoạt động như thế nào?

**AI trả lời:** `JOIN` mặc định là `INNER JOIN`. Chỉ các dòng có khóa khớp ở cả hai bảng mới được giữ lại. Vì vậy khách hàng chưa có đơn hàng sẽ bị loại khỏi kết quả.

## 2. COUNT khi dùng LEFT JOIN

**Prompt:** Khi dùng LEFT JOIN để đếm đơn hàng, nên dùng COUNT(*) hay COUNT(order_id)?

**AI trả lời:** Nên dùng `COUNT(o.order_id)`. `COUNT(*)` đếm cả dòng được LEFT JOIN giữ lại dù phía Orders là NULL, còn `COUNT(o.order_id)` bỏ qua NULL nên khách chưa mua hàng nhận giá trị 0.

## 3. Anti-Join và NOT IN

**Prompt:** LEFT JOIN kết hợp IS NULL khác gì NOT IN khi tìm bản ghi chưa tồn tại ở bảng khác?

**AI trả lời:** `LEFT JOIN ... WHERE right_key IS NULL` thể hiện anti-join rõ ràng và không gặp bẫy NULL như `NOT IN`. Một lựa chọn khác cũng an toàn là `NOT EXISTS`. MySQL Optimizer có thể tối ưu cả hai tùy dữ liệu và chỉ mục.

## 4. FULL OUTER JOIN trong MySQL

**Prompt:** Có thể giả lập FULL OUTER JOIN trong MySQL như thế nào?

**AI trả lời:** MySQL không có cú pháp `FULL OUTER JOIN` trực tiếp. Có thể ghép kết quả của `LEFT JOIN` và phần còn thiếu từ `RIGHT JOIN` bằng `UNION` hoặc `UNION ALL` kèm điều kiện loại dòng trùng.

## 5. Nested-Loop Join và Optimizer

**Prompt:** MySQL Optimizer xử lý JOIN bằng Nested-Loop Join như thế nào và index có tác dụng gì?

**AI trả lời:** Optimizer ước lượng chi phí để chọn thứ tự bảng. Với Nested-Loop Join, MySQL đọc một dòng từ bảng ngoài rồi tìm các dòng phù hợp ở bảng trong. Nếu cột JOIN của bảng trong có index, việc tìm kiếm có thể dùng index thay vì quét toàn bảng, giảm đáng kể số dòng phải kiểm tra. Vì vậy các cột `Orders.customer_id` và `Orders.product_id` nên có index khi dữ liệu lớn.

## 6. CROSS JOIN

**Prompt:** Cross Join là gì và khi nào JOIN vô tình thành Cartesian Product?

**AI trả lời:** `CROSS JOIN` tạo mọi tổ hợp giữa hai bảng. Nếu bảng A có m dòng và bảng B có n dòng thì kết quả có m × n dòng. Việc quên hoặc viết sai điều kiện `ON` có thể khiến số dòng tăng bùng nổ và làm truy vấn rất nặng.
