# Báo cáo Storage & Performance - QuickFeed

Bảng `Posts` ban đầu có 5 secondary index ngoài Primary Key. Điều này giúp một số truy vấn đọc nhanh hơn, nhưng mỗi lần `INSERT`, MySQL phải ghi bản ghi mới vào clustered index và đồng thời cập nhật từng cây B-Tree phụ. Vì vậy càng nhiều index thì chi phí CPU, I/O, ghi log và bảo trì page càng lớn, khiến thao tác đăng bài dễ chậm hoặc timeout.

Ba index bị loại bỏ là `idx_content`, `idx_post_type` và `idx_is_visible`. `content` là cột TEXT dài nên B-Tree prefix index tốn nhiều dung lượng. `post_type` chỉ có vài giá trị và `is_visible` chỉ có 0/1 nên cardinality thấp, khiến Optimizer thường không có lợi khi dùng index nếu truy vấn trả về phần lớn bảng.

Hai index được giữ lại là `idx_user_id` và `idx_created_at` vì phục vụ trực tiếp các truy vấn phổ biến: xem bài theo người dùng và tải newsfeed theo thời gian.

Số liệu thực tế cần lấy từ hai lần truy vấn `information_schema.TABLES`: trước và sau khi DROP index. So sánh `Index_MB` để chứng minh dung lượng index đã giảm. Việc xóa 3 index cũng giúp mỗi lệnh INSERT bớt 3 lần cập nhật B-Tree phụ.
