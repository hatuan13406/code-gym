# [Thực hành] Xây dựng Landing Page với Bootstrap

Bài thực hành CodeGym tạo Landing Page **MyBrand** bằng **Bootstrap 5.3.0** và CSS.

## Thành phần theo yêu cầu

- **Navbar:** `navbar navbar-expand-lg navbar-dark bg-dark`, menu Home / About / Services / Contact và nút hamburger mobile.
- **Hero Section:** Tiêu đề lớn, đoạn giới thiệu, nút Bootstrap `btn btn-light` và `btn btn-outline-light`.
- **Grid System:** Các dịch vụ dùng `row g-4` và `col-md-4`, hiển thị 3 cột trên desktop/tablet đủ rộng; 1 cột trên mobile.
- **Cards:** 3 dịch vụ Thiết kế Web, SEO & Marketing, Hỗ trợ 24/7 dùng `card` và `card-body`.
- **Footer:** Bản quyền và liên kết về đầu trang.
- **Responsive:** Bootstrap breakpoints kết hợp media queries trong `style.css`.
- Minh họa Hero hoàn toàn bằng CSS, không tải ảnh ngoài. Trang chỉ cần Bootstrap CDN cho giao diện và menu.

## Cấu trúc

```
bootstrap-landing-page/
├── index.html
├── style.css
└── README.md
```

## Hướng dẫn mở bài

1. Tải mã nguồn, sau đó mở `index.html` bằng Chrome/Edge hoặc VS Code Live Server.
2. **Cần có Internet** để tải Bootstrap CSS và JavaScript từ CDN jsDelivr.
3. Trên desktop (≥992px), menu hiển thị ngang; các dịch vụ hiển thị 3 thẻ một hàng khi màn hình từ 768px.
4. Trên mobile, nhấn hamburger để mở/đóng menu, bấm Services để chuyển tới vùng dịch vụ.
5. Mở DevTools bằng F12 → Ctrl + Shift + M, thử chiều rộng 1440px, 768px, 375px.

## Link nộp bài

https://github.com/hatuan13406/code-gym/tree/main/bootstrap-landing-page
