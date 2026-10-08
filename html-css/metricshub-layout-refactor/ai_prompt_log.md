# AI Prompt Log - MetricsHub

## 1. Grid hay Flexbox cho Bento?
**Prompt:** Khi một child cần span 2 hàng và 2 cột đan xen với các phần tử nhỏ, nên dùng CSS Grid hay Flexbox?

**AI:** CSS Grid phù hợp hơn vì quản lý đồng thời hàng và cột. Flexbox chủ yếu giải quyết một trục mỗi lần nên thường phải lồng nhiều container nếu muốn giả lập Bento layout.

## 2. Vì sao Navbar dùng Flexbox?
**Prompt:** Vì sao Flexbox phù hợp hơn Grid cố định cho Navbar có chuỗi dịch thuật dài?

**AI:** Flexbox phân phối không gian theo kích thước nội dung, hỗ trợ `gap`, `flex-wrap` và căn chỉnh trên một trục. Khi text dài, item có thể co giãn hoặc xuống dòng thay vì bị khóa vào cột pixel cố định.

## 3. Bootstrap col-sm-4 và col-md-4
**Prompt:** Trong Bootstrap 5, col-sm-4 khác col-md-4 như thế nào?

**AI:** `col-sm-4` bắt đầu chiếm 4/12 cột từ breakpoint sm trở lên; `col-md-4` bắt đầu từ md trở lên. Với `col-12 col-md-4`, card xếp dọc trên màn hình nhỏ và thành ba cột từ md.

## 4. gap thay cho margin
**Prompt:** Thuộc tính gap có dùng được cho cả Flexbox và Grid không, và có lợi gì?

**AI:** Có. `gap` tạo khoảng cách trực tiếp giữa các item mà không cần xử lý margin ở phần tử đầu/cuối, giúp CSS sạch và khoảng cách nhất quán hơn.

## 5. Navbar responsive bằng flex-wrap
**Prompt:** Làm sao để Navbar trên mobile xuống dòng mà không che Logo?

**AI:** Dùng `display:flex`, `flex-wrap:wrap`, `gap` và tại breakpoint nhỏ cho nhóm menu `flex-basis:100%`. Như vậy menu chuyển xuống hàng mới nhưng Logo/Profile vẫn giữ bố cục rõ ràng.

## 6. Kết hợp Grid và Flexbox
**Prompt:** Bên trong một widget Grid, nếu muốn căn giữa icon và text thì dùng gì?

**AI:** Có thể dùng Flexbox ngay bên trong widget với `display:flex`, `align-items:center`, `justify-content:center`. Grid quản lý vị trí widget, Flexbox quản lý nội dung component.
