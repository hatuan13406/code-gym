# Đáp ứng hóa Layout trang báo – Desktop First

## Các bước đã thực hiện
1. Tạo `newspaper.html` với thẻ `meta viewport`, liên kết `style.css`.
2. Xây dựng các khu vực: Header, bài viết chính, hai bài viết phụ và Footer.
3. Áp dụng CSS Grid 4 cột cho desktop bằng `grid-template-columns: repeat(4, minmax(0, 1fr))`.
4. Header/Footer trải dài tất cả cột (`grid-column: 1 / -1`); bài chính chiếm 3 cột và 2 hàng; hai bài phụ ở cột 4.
5. Thêm media query `@media (max-width: 800px)` để chuyển lưới về một cột.
6. Ghi đè `grid-column: auto` và `grid-row: auto` để các phần tử tự động xếp theo thứ tự HTML trên màn hình nhỏ.

## Cách chạy và kiểm tra
Mở `newspaper.html` trên trình duyệt hoặc dùng Live Server. Mở DevTools (F12), kiểm tra tại các độ rộng 1200px, 801px, 800px, 768px và 375px.

- Trên 800px: bố cục 4 cột, bài chính chiếm ba cột, hai bài phụ ở cột cuối.
- Từ 800px trở xuống: tất cả các khu vực xếp thành một cột.
