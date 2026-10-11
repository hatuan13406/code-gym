# [Thực hành] Tạo Trang Giới Thiệu Doanh Nghiệp với Bootstrap

Bài thực hành CodeGym xây dựng trang giới thiệu doanh nghiệp **NovaTech** bằng Bootstrap 5.3.0 và CSS. NovaTech là thương hiệu minh họa, không phải thông tin doanh nghiệp thật.

## Các phần bắt buộc

- **Navbar:** `navbar navbar-expand-lg navbar-light bg-light` với Trang Chủ, Về Chúng Tôi, Dịch Vụ, Liên Hệ. Nút hamburger trên mobile dùng `collapse` của Bootstrap.
- **Hero:** tiêu đề, giới thiệu, nút “Khám phá dịch vụ”.
- **About:** giới thiệu doanh nghiệp công nghệ; 4 thẻ mô tả giá trị.
- **Services:** **3 Bootstrap Cards** trong `row g-4` / `col-md-4`: Thiết kế Website, Marketing Online, Hỗ trợ khách hàng.
- **Contact:** email minh họa `contact@example.com` và giờ hỗ trợ minh họa; không sử dụng dữ liệu liên lạc thật.
- **Footer:** tên doanh nghiệp minh họa, thông báo bản quyền và liên kết về đầu trang.
- **Responsive:** Bootstrap Grid System và Media Queries; tất cả hình trang trí xây dựng bằng CSS.

## Cấu trúc thư mục

```
bootstrap-company-introduction/
├── index.html
├── style.css
└── README.md
```

## Chạy và kiểm tra

1. Mở `index.html` bằng Chrome hoặc Edge / VS Code Live Server.
2. **Cần có Internet** để tải Bootstrap CSS và JavaScript từ CDN jsDelivr.
3. Desktop: thử Navbar, Hero, About, 3 Cards dịch vụ, Contact, Footer.
4. Mobile: nhấn F12 → Ctrl + Shift + M; ở chiều rộng 375px, thử nút hamburger và kiểm tra Cards xếp dọc.
5. Nhấp menu và nút CTA để kiểm tra liên kết đến các mục tương ứng.

## Link nộp CodeGym

https://github.com/hatuan13406/code-gym/tree/main/bootstrap-company-introduction
