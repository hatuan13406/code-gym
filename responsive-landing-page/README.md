# [Thực hành] Xây dựng trang web Landing Page Responsive

Bài thực hành HTML5/CSS3 từ CodeGym, minh họa **Flexbox, CSS Grid và Media Queries**. Website mang thương hiệu minh họa **MyBrand**.

## Cấu trúc

```text
responsive-landing-page/
├── index.html
├── style.css
└── README.md
```

## Cách chạy

Mở `index.html` bằng Chrome/Edge hoặc **Live Server** của VS Code. Không cần cài JavaScript, Node.js, Bootstrap hoặc thư viện.

## Các yêu cầu và cách thực hiện

- **Header**: logo MyBrand và 4 liên kết `Trang chủ`, `Dịch vụ`, `Đánh giá`, `Liên hệ`; dùng `display: flex`.
- **Hero**: tiêu đề, phần mô tả, nút `Khám phá dịch vụ` và minh họa dashboard tạo hoàn toàn bằng HTML/CSS; bố cục hai cột với CSS Grid trên desktop.
- **Dịch vụ**: 3 card `Thiết kế web`, `Phát triển phần mềm`, `Marketing số`; CSS Grid 3 cột desktop, 2 cột tablet, 1 cột mobile.
- **Testimonial**: 2 lời nhận xét **minh họa**, dùng CSS Grid; ở mobile chuyển thành một cột.
- **Footer**: thương hiệu, bản quyền, liên kết quay lên đầu trang.
- **Responsive**: media queries ở 1020px, 768px, 600px và 350px. Không gây tràn ngang ở kích thước phổ biến.
- **Không dùng JS**: thay vì giấu menu mobile không mở được, thanh menu vẫn xuất hiện và có thể cuộn ngang ở màn hình hẹp.

## Tự kiểm tra

1. Mở trang trên PC: các mục điều hướng xuất hiện ngang; hero có 2 cột; dịch vụ 3 cột.
2. Thu nhỏ cửa sổ tới 768px: hero còn một cột; menu vẫn sử dụng được.
3. Thu nhỏ tới 375px hoặc 320px: mọi card và đánh giá xếp thành 1 cột, không xuất hiện thanh cuộn ngang ở toàn bộ trang.
4. Nhấn menu `Dịch vụ`, `Đánh giá` và các nút CTA để kiểm tra cuộn tới vị trí đúng.

Lưu ý: Các chỉ số trong dashboard, ảnh đại diện, và lời nhận xét chỉ để **minh họa giao diện**. Địa chỉ `hello@example.com` cần được thay bằng email thật trước khi sử dụng thực tế.

## Link nộp CodeGym

https://github.com/hatuan13406/code-gym/tree/main/responsive-landing-page