# [Thực hành] CSS | grid-template-columns Property

Bài tập CodeGym gồm **đầy đủ 2 ví dụ** sử dụng thuộc tính `grid-template-columns`:

1. `grid-template-columns: 1fr 1fr 1fr;` — 6 ô màu **lightblue**, 3 cột bằng nhau × 2 hàng.
2. `grid-template-columns: 100px 200px 1fr;` — 6 ô màu **lightgreen**, các cột lần lượt rộng 100px, 200px và phần còn lại.

## Cấu trúc mã nguồn GitHub

```text
grid-template-columns-practice/
├── index.html
├── style.css
└── README.md
```

Ảnh chụp kết quả `ket-qua-grid-template-columns.png` được cung cấp riêng qua tệp đính kèm ChatGPT hoặc gói ZIP đi kèm bài làm để nộp trực tiếp lên CodeGym.

## Cách chạy

1. Tải thư mục về máy, sau đó mở `index.html` bằng Chrome/Edge hoặc VS Code Live Server.
2. Quan sát 2 ví dụ, mỗi lưới có 6 ô được xếp thành 2 hàng × 3 cột.
3. Mở DevTools và xem CSS của `.grid-equal` và `.grid-different` để xác nhận kích thước cột.
4. Để tạo ảnh nộp bài, bạn có thể sử dụng tệp PNG đi kèm hoặc chụp ảnh màn hình trình duyệt.

### Kết quả kiểm tra trình duyệt

Đã kiểm tra với Chromium tại chiều rộng **1280px**: lưới 1 có 3 cột khoảng **315px** bằng nhau; lưới 2 có 3 cột lần lượt **100px – 200px – 644px**. Mỗi lưới có đúng 6 ô. Thử ở **375px**: trang không tràn ngang, riêng ví dụ 2 có thể cuộn ngang trong khu vực minh họa để giữ nguyên kích thước cột theo đề.

Bài viết bằng HTML/CSS thuần, không cần JavaScript.

## Link GitHub

https://github.com/hatuan13406/code-gym/tree/main/grid-template-columns-practice
