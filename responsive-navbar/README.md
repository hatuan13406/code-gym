# [Thực hành] Tạo thanh điều hướng responsive

Website demo của bài CodeGym sử dụng **HTML, CSS Flexbox, Media Queries và JavaScript** để xây dựng thanh điều hướng responsive.

## Các file

```text
responsive-navbar/
├── index.html
├── style.css
├── script.js
└── README.md
```

## Chạy bài

1. Mở file `index.html` trên Chrome, Edge hoặc VS Code Live Server.
2. Trên màn hình rộng hơn **768px**, menu ngang gồm **Trang chủ, Giới thiệu, Dịch vụ, Liên hệ** luôn hiển thị và biểu tượng ☰ được ẩn.
3. Thu nhỏ trình duyệt xuống **768px hoặc thấp hơn**: menu ngang được ẩn, biểu tượng **☰** xuất hiện.
4. Nhấn ☰ để **mở menu**; nhấn ✕ để **đóng menu**.
5. Có thể đóng menu bằng phím **Escape**, nhấn bên ngoài thanh điều hướng, hoặc chọn một liên kết.
6. Khi trở lại desktop, menu tự hiển thị ngang và trạng thái mở của mobile được xoá.

## Điểm kỹ thuật quan trọng

- `.navbar` là thanh điều hướng; `.nav-container` dùng `display: flex`, `justify-content: space-between`.
- `.nav-links { display: flex; }` hiển thị menu ngang ở desktop.
- `.menu-icon { display: none; }` ẩn nút hamburger ở desktop.
- `@media (max-width: 768px)` ẩn `.nav-links`, hiện `.menu-icon` và đổi menu sang bố cục dọc.
- `.nav-links.active { display: flex; }` là lớp do JavaScript bật/tắt qua `classList.toggle()`.
- Nút `<button>` có `aria-expanded` và `aria-controls` để hỗ trợ bàn phím và công cụ đọc màn hình.
- Trang chạy offline, không cần thư viện bên ngoài hoặc máy chủ.

## Nộp bài

```text
https://github.com/hatuan13406/code-gym/tree/main/responsive-navbar
```
