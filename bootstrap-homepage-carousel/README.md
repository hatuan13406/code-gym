# [Thực hành] Xây dựng Trang Chủ với Bootstrap

Bài CodeGym thực hành **Bootstrap 5.3.3**, gồm Navbar, Font Awesome, Carousel, Flexbox, Margin & Padding và Contact Form.

## Cấu trúc

```text
bootstrap-homepage-carousel/
├── index.html
├── style.css
├── script.js
└── README.md
```

## Các phần theo đề

- **Navbar**: `navbar navbar-expand-lg navbar-dark bg-dark`, icon Font Awesome 6.5.2, các mục Home, About, Services, Contact; hamburger menu trên mobile.
- **Hero Carousel**: `#heroCarousel`, 2 `carousel-item` với ảnh Unsplash, nút chuyển prev/next, slide indicators và tự chuyển 5 giây.
- **Display / Margin / Padding**: các utility `d-block`, `d-flex`, `mt-*`, `mb-*`, `py-*`, `px-*`.
- **Flexbox**: `d-flex flex-column justify-content-center align-items-center text-center` căn giữa nội dung giới thiệu.
- **Grid System**: 3 cột dịch vụ `col-md-4`; responsive trên mobile.
- **Contact Form**: `form-label`, `form-control`, `btn btn-primary`; kiểm tra tên, email, lời nhắn hợp lệ bằng JavaScript.

## Cách chạy và kiểm tra

1. Mở `index.html` trong trình duyệt Chrome/Edge hoặc VS Code Live Server.
2. **Cần Internet** để Bootstrap, Font Awesome và ảnh mẫu Unsplash hoạt động.
3. Kiểm tra Carousel tự chuyển slide và hai nút Previous / Next; thử menu Navbar trên desktop.
4. Dùng DevTools (F12 → Ctrl+Shift+M), đặt chiều rộng 375px để thử hamburger.
5. Thử gửi form trống, email không hợp lệ, và dữ liệu hợp lệ để quan sát thông báo.

**Lưu ý bảo mật:** Đây là form giao diện demo, không có API gửi email và không lưu dữ liệu người dùng.

## Link nộp bài

https://github.com/hatuan13406/code-gym/tree/main/bootstrap-homepage-carousel
