# [Thực hành] CSS | grid-column-start Property

Bài thực hành CodeGym minh họa **đầy đủ ba giá trị `auto`, `span n` và `column-line`** của thuộc tính CSS `grid-column-start`.

## Các ví dụ

1. **`auto`:** `.grid-auto { grid-template-columns: 100px 100px 100px; }` và `.grid-auto .item1 { grid-column-start: auto; }` — 3 ô được sắp xếp theo luồng mặc định.
2. **`span 2`:** `.grid-span { grid-template-columns: repeat(4, 1fr); }` (thực tế dùng `minmax(0,1fr)` tránh tràn) và `.grid-span .item1 { grid-column-start: span 2; }` — Item 1 chiếm 2 cột.
3. **`column-line`:** `.grid-line { grid-template-columns: repeat(4, 1fr); }` và `.grid-line .item1 { grid-column-start: 2; }` — Item 1 bắt đầu tại đường kẻ cột thứ 2.

## Các tệp

- `index.html`: trang tổng hợp cả ba ví dụ.
- `style.css`: CSS định dạng và phần minh họa có các thuộc tính cần học.
- Ảnh `ket-qua-grid-column-start.png` chụp kết quả thực tế được cung cấp để tải trong phần trả lời của ChatGPT, dung lượng dưới 2 MB.

## Cách chạy và nộp

Mở `index.html` bằng trình duyệt. Đối chiếu lần lượt cả ba ô ví dụ. Tải ảnh `ket-qua-grid-column-start.png` để nộp vào mục **File** của CodeGym. Có thể tham khảo toàn bộ mã nguồn tại:

https://github.com/hatuan13406/code-gym/tree/main/grid-column-start-practice