# CreativeChronicle - Layout Refactoring

Legacy layout dùng `float` cho Author Info nên phải cần clearfix hoặc `overflow: hidden` để phần tử cha ôm được các phần tử con. Cách này khó căn giữa dọc và dễ vỡ khi tên tác giả dài. Flexbox phù hợp hơn vì đây là bố cục một chiều, hỗ trợ `align-items: center`, `justify-content: space-between`, `gap` và `flex-wrap`.

Mosaic Gallery cũ dùng `position: absolute`, khiến ảnh bị tách khỏi normal flow. Phần tử cha phải có chiều cao cố định nên trên mobile ảnh có thể đè lên nội dung. CSS Grid phù hợp hơn vì quản lý đồng thời hàng và cột, cho phép ảnh chính `grid-row: span 2`, các ảnh phụ tự xếp bên cạnh và chuyển về một cột bằng media query.

Recommended Articles dùng Bootstrap `col-12 col-md-6 col-lg-3` để tự đổi từ 1, 2 sang 4 cột theo breakpoint.
