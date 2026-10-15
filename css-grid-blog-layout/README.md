# Dựng Layout Blog cổ điển bằng CSS Grid

## Các bước thực hiện
1. Tạo `blog-layout.html` với các thẻ ngữ nghĩa `header`, `main`, `aside`, `footer`.
2. Liên kết tệp `style.css` và thiết lập reset `box-sizing: border-box`.
3. Thiết lập `display: grid` trên `body.grid-container`.
4. Chia lưới thành 2 cột `2fr 1fr` và 3 hàng `auto 1fr auto`; dùng `gap: 20px` và `min-height: 100vh`.
5. Cho header và footer chiếm cả hai cột với `grid-column: 1 / 3`.
6. Đặt main ở cột 1, sidebar ở cột 2 bằng `grid-column`.
7. Thêm media query nhỏ để các khu vực xếp thành một cột trên màn hình hẹp.

## Cách chạy
Mở `blog-layout.html` trên trình duyệt hoặc dùng Live Server trong VS Code.

## Kết quả
Desktop: Header / Main (2 phần) + Sidebar (1 phần) / Footer.
Mobile: Các khu vực xếp dọc để không bị tràn ngang.
