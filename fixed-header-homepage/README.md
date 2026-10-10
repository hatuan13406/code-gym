# [Bài tập] Tạo giao diện giản lược của trang chủ

Bài tập HTML5 + CSS3 về thuộc tính **position**.

## Xem giao diện

1. Mở thư mục này trong VS Code hoặc Antigravity.
2. Mở file `index.html` bằng Chrome, Edge hoặc Live Server.
3. Cuộn trang xuống và quan sát **header vẫn cố định ở trên cùng**.
4. Thử thu nhỏ cửa sổ trình duyệt: bố cục chuyển từ ba cột sang xếp dọc trên màn hình nhỏ.

## Tổ chức thư mục

```
fixed-header-homepage/
├── index.html
├── style.css
└── README.md
```

## Các kiến thức áp dụng

- **`position: fixed`** với `top: 0; left: 0; width: 100%`: cố định header.
- **`z-index: 1000`**: header nằm trên nội dung khác.
- **`body { padding-top: var(--header-height) }`**: tránh header cố định che nội dung.
- **`display: flex`**: chia trang thành sidebar trái, nội dung chính, sidebar phải.
- **`flex: 1`, `flex-shrink: 0`, `gap`**: kiểm soát kích thước và khoảng cách ba cột.
- **Media Queries**: bố cục thích ứng khi màn hình thu nhỏ.
- **`scroll-margin-top`**: khi nhấn các liên kết điều hướng, tiêu đề không bị header che.

Không cần cài đặt thư viện hoặc backend. Chỉ có HTML và CSS thuần; không dùng Bootstrap, JavaScript hay dịch vụ bên ngoài.

## Link bài tập

Sau khi đưa vào repo `hatuan13406/code-gym`, đường dẫn:
`https://github.com/hatuan13406/code-gym/tree/main/fixed-header-homepage`
