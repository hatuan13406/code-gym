# [Thực hành] Tạo Bố Cục 3 Cột bằng Bootstrap Grid và Flexbox

Bài thực hành CodeGym với **Bootstrap 5.3.3**, **Font Awesome 6.5.2**, Grid System, Display Property, Flexbox, Margin & Padding, Carousel và Form.

## Cấu trúc

```
bootstrap-three-column-layout/
├── index.html
├── style.css
├── script.js
└── README.md
```

## 6 bước theo đề bài

1. **Grid 3 cột:** `row` + 3 `col-md-4`, bên trong dùng `d-flex justify-content-center align-items-center bg-light p-3` hoặc `bg-secondary text-white`. Từ 768px trở lên hiển thị 3 cột; nhỏ hơn 768px xếp thành 1 cột.
2. **Margin & Padding:** khu vực `container my-5 py-3`, có cả các ví dụ spacing khác.
3. **Display:** `d-none d-md-block bg-warning text-center p-3` chỉ hiển thị từ 768px; thêm nhãn riêng cho mobile qua `d-block d-md-none`.
4. **Carousel:** `#myCarousel` với 3 ảnh, `carousel-item active`, nút Previous/Next và slide indicators.
5. **Font Awesome:** icon trong Navbar, các cột và nút gửi của form.
6. **Form:** nhập Họ và tên, Email, Nội dung bằng `form-control`; nút `btn btn-primary`, kiểm tra dữ liệu hợp lệ ở trình duyệt.

## Cách chạy

1. Mở `index.html` bằng Chrome, Edge hoặc VS Code Live Server.
2. **Cần Internet** để tải Bootstrap CSS/JS, Font Awesome và các ảnh ví dụ từ Unsplash.
3. Xem 3 cột, kéo nhỏ màn hình để thấy chúng xếp dọc.
4. Mở DevTools (F12 → Ctrl+Shift+M) và thử 1440px, 768px, 375px.
5. Nhấn Previous, Next và các indicators của Carousel; Carousel cũng tự chuyển slide sau 5 giây.
6. Thử gửi form trống, sai email và điền đầy đủ thông tin để kiểm tra thông báo.

**Lưu ý:** Form chỉ dùng để minh họa giao diện frontend, không gửi hoặc lưu dữ liệu lên máy chủ.

## Link nộp CodeGym

https://github.com/hatuan13406/code-gym/tree/main/bootstrap-three-column-layout
