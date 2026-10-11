# [Bài tập] Tạo Landing Page với Bootstrap và Hình Ảnh

Bài tập CodeGym: Landing Page **Lumina Studio** sử dụng **Bootstrap 5.3.0**, Bootstrap Container, Grid System, Images, Buttons và CSS.

## Các phần đã triển khai

- **Navbar responsive**: Bootstrap `navbar-expand-lg`, hamburger với `data-bs-toggle="collapse"`.
- **Hero / Banner**: tiêu đề, mô tả, 2 nút CTA, **ảnh lớn** với lớp `img-fluid`. Bootstrap 5 không còn Jumbotron, vì vậy bài dùng khu vực `hero-section` riêng.
- **Giới thiệu**: một `row` có **ảnh + nội dung**; ảnh dùng `img-fluid`, mô tả thay đổi theo kích thước màn hình.
- **Tính năng**: Bootstrap `row` với 4 cột `col-12 col-md-6 col-xl-3`. Mỗi tính năng có SVG icon, tiêu đề, mô tả.
- **CTA**: nút `btn btn-light btn-lg` “Đăng ký ngay” mở ứng dụng email, chỉ dùng địa chỉ `hello@example.com` minh họa.
- **Footer**: bản quyền và liên kết về đầu trang.

## Cấu trúc mã nguồn

```text
bootstrap-image-landing-page/
├── index.html
├── style.css
└── README.md
```

## Cách chạy

1. Tải mã nguồn hoặc clone repository, mở `index.html` bằng Chrome/Edge, hoặc dùng VS Code Live Server.
2. **Cần kết nối Internet:** Bootstrap, Google Fonts và ảnh mẫu được tải từ CDN (jsDelivr, Google Fonts và Unsplash).
3. Trên desktop: kiểm tra Hero có ảnh lớn; About gồm hai cột; 4 thẻ tính năng trên XL.
4. Trên tablet: các thẻ tính năng thành 2 cột (từ 768px). Trên mobile (<768px), các thẻ xếp 1 cột.
5. Nhấn **F12 → Ctrl+Shift+M**, thử chiều rộng 1440px, 992px, 768px và 375px; mở nút hamburger trên mobile để kiểm tra.
6. Nút “Đăng ký ngay” mở trình email mặc định; đây là minh họa, không có hệ thống đăng ký thật.

## Link GitHub nộp CodeGym

https://github.com/hatuan13406/code-gym/tree/main/bootstrap-image-landing-page
