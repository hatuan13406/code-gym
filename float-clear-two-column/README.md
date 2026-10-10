# [Thực hành] Tạo bố cục hai cột bằng Float và Clear

Bài tập CodeGym luyện tập các thuộc tính CSS `float` và `clear`, triển khai trực tiếp bằng **HTML + CSS thuần**.

## Cấu trúc

```
float-clear-two-column/
├── index.html
├── style.css
└── README.md
```

## Kết quả

- **Cột trái:** `width: 60%`, `float: left`, nền `lightblue`.
- **Cột phải:** `width: 38%`, `float: right`, nền `lightgreen`.
- **Khoảng trống:** 2% do tổng hai chiều rộng bằng 98%.
- **Chống lỗi bố cục:** `.container::after { content: ""; display: block; clear: both; }`.
- **Bổ sung:** `box-sizing: border-box` để `padding` không làm hai cột vượt 100%; responsive để cột xếp dọc trên điện thoại.

> Phần layout chính dùng float và clear theo đúng bài học; Flexbox chỉ sử dụng cho một vài thành phần trang trí ở bên trong cột.

## Cách chạy

1. Tải thư mục về hoặc clone repo `hatuan13406/code-gym`.
2. Mở file `index.html` bằng Chrome, Edge hoặc VS Code Live Server.
3. Quan sát cột trái rộng hơn cột phải, cả hai nằm trên cùng một hàng.
4. Quan sát phần thông báo **Đã xử lý Float bằng Clear** luôn hiển thị bên dưới hai cột.
5. Thu nhỏ cửa sổ trình duyệt xuống dưới 700px để kiểm tra bố cục responsive.

Không cần cài thêm thư viện, npm, backend hay database.

## Nộp bài

Dán đường dẫn GitHub sau vào CodeGym:
`https://github.com/hatuan13406/code-gym/tree/main/float-clear-two-column`
