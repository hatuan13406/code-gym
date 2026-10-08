# MetricsHub Layout Strategy

Legacy Navbar dùng Grid cố định nên dễ tràn khi nội dung dài; giải pháp là Flexbox vì đây là bố cục 1 chiều và cần co giãn theo nội dung. Bento Dashboard cũ dùng Flexbox lồng nhiều lớp, khó biểu diễn widget chiếm nhiều hàng/cột; CSS Grid phù hợp hơn vì điều khiển đồng thời hai chiều và hỗ trợ `grid-column/grid-row: span`. Pricing chỉ cần ba cột bằng nhau nên dùng Bootstrap `row` + `col-12 col-md-4`, tránh tự viết media query.

Flexbox và Grid không đối lập: Grid tổ chức layout tổng thể, còn Flexbox rất tiện để căn nội dung bên trong từng widget. `gap` được dùng cho cả hai để tạo khoảng cách nhất quán, thay cho nhiều `margin` rời rạc.
