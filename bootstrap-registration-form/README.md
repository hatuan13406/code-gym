# [Bài tập] Thiết kế Trang Đăng Ký với Bootstrap Forms

Bài tập CodeGym tạo giao diện đăng ký người dùng bằng **Bootstrap 5.3.0**, gồm đủ các trường: Họ và tên, Email, Mật khẩu, Xác nhận mật khẩu, Giới tính (radio), Sở thích (checkbox), Quốc gia (select) và nút Submit.

## Cấu trúc

```text
bootstrap-registration-form/
├── index.html
├── style.css
├── script.js
└── README.md
```

## Công nghệ và các yêu cầu

- **Bootstrap Forms:** `form-label`, `form-control`, `form-select`, `form-check`, `form-check-inline`.
- **Bootstrap Buttons:** `btn btn-primary btn-lg` với chiều rộng `w-100`.
- **Bootstrap Text:** `text-muted`, `text-center`, v.v.
- **Responsive:** `container`, `row`, `col-lg-5`, `col-lg-7`, `col-sm-6` cho desktop/mobile.
- **Kiểm tra đầu vào phía trình duyệt:** email hợp lệ, trường bắt buộc, họ tên tối thiểu 2 ký tự, mật khẩu tối thiểu 8 ký tự, xác nhận mật khẩu trùng khớp, đã chọn giới tính và quốc gia.
- Sở thích không bắt buộc.

## Chạy và kiểm tra

1. Mở `index.html` bằng Chrome/Edge hoặc VS Code Live Server.
2. **Cần Internet** để tải CSS và JS của Bootstrap từ CDN jsDelivr.
3. Thử bỏ trống form và nhấn Submit để xem thông báo kiểm tra.
4. Thử mật khẩu xác nhận khác mật khẩu ban đầu, email sai định dạng và chưa chọn quốc gia.
5. Nhập dữ liệu hợp lệ, chọn giới tính, chọn quốc gia và nhấn Submit để xem thông báo xác nhận demo.
6. Nhấn **F12** → **Ctrl + Shift + M**, thử 1440px, 768px, 390px, 320px để quan sát responsive.

> **Lưu ý:** Đây là bản trình diễn **frontend**. Không có backend/API, không tạo tài khoản thực, không truyền hoặc lưu dữ liệu người dùng. Không nhập mật khẩu cá nhân thật vào form thực hành.

## Link nộp CodeGym

https://github.com/hatuan13406/code-gym/tree/main/bootstrap-registration-form
