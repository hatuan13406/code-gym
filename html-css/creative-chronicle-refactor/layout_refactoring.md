# CreativeChronicle - Layout Refactoring

Legacy layout dùng `float` cho Author Info nên phải dựa vào clearfix hoặc `overflow: hidden` để phần tử cha ôm được các phần tử con. Cách này khó căn giữa theo chiều dọc và dễ vỡ khi tên tác giả dài. Flexbox phù hợp hơn vì Author Info là bố cục một chiều, hỗ trợ `align-items: center`, `justify-content: space-between` và `flex-wrap`.

Mosaic Gallery cũ dùng `position: absolute` nên các ảnh bị lấy khỏi normal flow. Vì vậy phần tử cha phải có chiều cao cố định, và khi viewport nhỏ lại nội dung bên dưới dễ bị đè lên. CSS Grid giải quyết đúng bài toán hai chiều: ảnh chính có thể `grid-row: span 2`, hai ảnh phụ tự xếp ở cột còn lại, có `gap` rõ ràng và chuyển về một cột bằng media query.

Recommended Articles dùng Bootstrap Grid với `col-12 col-md-6 col-lg-3`, tự chuyển từ 1 cột sang 2 và 4 cột theo breakpoint mà không cần tự tính phần trăm.
