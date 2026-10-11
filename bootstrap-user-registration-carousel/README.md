# [Bài tập] Tạo Trang Đăng Ký Người Dùng

Bài tập CodeGym tạo trang **MemberSpace** bằng **Bootstrap 5.3.3**, tập trung Bootstrap Forms, Input Group, Buttons, Carousel và Grid responsive.

## Thành phần

- **Carousel**: 3 ảnh SVG minh họa lợi ích, tự chuyển slide mỗi 4,5 giây, có nút Previous / Next và indicators.
- **Form đăng ký**: Họ và tên, Email, Mật khẩu, Xác nhận mật khẩu.
- **Bootstrap UI**: `container`, `row`, `col-lg-6`, `input-group`, `form-control`, `btn btn-primary btn-lg`, `rounded-4`, `shadow-sm`, `text-secondary`.
- **Validation**: kiểm tra trường bắt buộc, email hợp lệ, họ tên ≥2 ký tự, mật khẩu ≥8 ký tự, xác nhận khớp, checkbox đồng ý và nút Ẩn/Hiện mật khẩu.
- **Responsive**: desktop hai cột (Carousel / Form); mobile xếp dọc với Carousel nằm trên.

## Cấu trúc

```
bootstrap-user-registration-carousel/
├── index.html
├── style.css
├── script.js
├── images/
│   ├── benefit-easy.svg
│   ├── benefit-secure.svg
│   └── benefit-experience.svg
└── README.md
```

## Cách chạy và kiểm tra

1. Mở `index.html` trong Chrome, Edge hoặc VS Code Live Server.
2. **Cần Internet** để tải Bootstrap CSS và JavaScript từ CDN jsDelivr. **Ảnh SVG lưu trực tiếp trong dự án**.
3. Kiểm tra Carousel chuyển ảnh qua ba slides; bấm Previous / Next.
4. Thử submit form trống, email sai, mật khẩu dưới 8 ký tự và xác nhận khác mật khẩu.
5. Điền dữ liệu hợp lệ, tick ô đồng ý và nhấn Đăng ký. Trang sẽ báo hợp lệ nhưng không tạo tài khoản thật.
6. Kiểm tra responsive bằng DevTools (F12 → Ctrl+Shift+M) ở 1440px, 768px, 390px và 320px.

**Bảo mật:** Đây chỉ là bản demo frontend. Không có API/backend, không truyền hay lưu mật khẩu. Không dùng mật khẩu cá nhân thật khi thử nghiệm.

## Link nộp bài

https://github.com/hatuan13406/code-gym/tree/main/bootstrap-user-registration-carousel
