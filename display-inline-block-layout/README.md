# [Bài tập] Xây dựng bố cục trang web với display và inline-block

Bài tập CodeGym thực hành **`display: block`**, **`display: inline-block`**, **`width`** và **`max-width`** bằng HTML5 và CSS thuần.

## Cấu trúc

```text
display-inline-block-layout/
├── index.html
├── style.css
└── README.md
```

## Các yêu cầu đã thực hiện

- Có tiêu đề `<h1>Bố cục trang web với display</h1>`.
- Có một thanh `<nav>` chứa đúng 4 liên kết: Trang chủ, Giới thiệu, Dịch vụ, Liên hệ.
- `<section class="three-columns">` chứa **3 khối `<div class="box">`**, mỗi khối đặt `display: inline-block`, `width: 30%`, `margin: 1%`, `vertical-align: top`.
- Có phần `<footer>` nằm ở cuối trang.
- `.page-container` dùng `width: 94%`, `max-width: 1120px` và `display: block` để giới hạn khung trang.
- `.three-columns { font-size: 0; }` xử lý khoảng trắng (whitespace) mặc định giữa các phần tử inline-block; `.box { font-size: 14px; }` đặt lại kích thước chữ.
- Giao diện đáp ứng màn hình tablet (2 cột) và điện thoại (1 cột) với Media Queries.

**Lưu ý:** Bố cục 3 cột được thực hiện bằng `inline-block` đúng bài học, **không dùng Flexbox hoặc CSS Grid** cho phần này.

## Cách chạy

1. Tải mã nguồn từ GitHub (hoặc clone repo `hatuan13406/code-gym`).
2. Mở thư mục `display-inline-block-layout`.
3. Mở `index.html` bằng Chrome, Edge hoặc VS Code Live Server.
4. Quan sát 3 cột ở màn hình rộng; thu nhỏ trình duyệt để kiểm tra 2 cột rồi 1 cột.

## Link GitHub nộp CodeGym

```text
https://github.com/hatuan13406/code-gym/tree/main/display-inline-block-layout
```
