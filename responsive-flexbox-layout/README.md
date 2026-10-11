# [Thực hành] Xây dựng bố cục trang web với CSS Flexbox

Bài thực hành CodeGym về bố cục website responsive, gồm 5 phần **Header, Navigation, Main Content, Sidebar, Footer**. Dùng **HTML và CSS Flexbox**, không cần JavaScript hay hình ảnh bên ngoài.

## Cấu trúc thư mục

```text
responsive-flexbox-layout/
├── index.html
├── style.css
└── README.md
```

## CSS cốt lõi

Trên **desktop**, phần tử cha xếp dọc 4 vùng lớn, nội dung chính và sidebar xếp ngang với tỷ lệ 3:1:

```css
.container { display: flex; flex-direction: column; min-height: 100vh; }
.main-container { display: flex; flex: 1 0 auto; }
.content { flex: 3 1 0; }
.sidebar { flex: 1 1 0; }
```

Trên **mobile**, sidebar nằm ngay dưới nội dung chính:

```css
@media (max-width: 768px) {
  .main-container { flex-direction: column; }
  .content, .sidebar { flex: 0 1 auto; width: 100%; }
}
```

Các thẻ tính năng cũng dùng `display: flex` với `flex-wrap: wrap` để tự chuyển dòng.

## Cách chạy / kiểm tra

1. Mở `index.html` trong Chrome hoặc Edge, hoặc mở bằng VS Code Live Server.
2. Tại chiều rộng desktop (1280px), quan sát Main Content nằm bên trái Sidebar.
3. Nhấn F12 rồi Ctrl + Shift + M để chuyển sang chế độ mô phỏng thiết bị.
4. Thử chiều rộng 768px, 375px và 320px: Main Content và Sidebar xếp dọc; trang không bị tràn ngang.
5. Kiểm tra các đường dẫn menu nội bộ đều di chuyển tới khu vực tương ứng.

## Link nộp CodeGym

https://github.com/hatuan13406/code-gym/tree/main/responsive-flexbox-layout
