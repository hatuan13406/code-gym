# [Thực hành] Tạo Website Template Có Giao Diện Đẹp Mắt

Bài tập CodeGym xây dựng Website Template **Creative Web** bằng HTML5 và CSS3 (không sử dụng Bootstrap).

## Các yêu cầu

- **Header nền ảnh:** CSS `background: url("../images/banner.svg") center/cover`, hiệu ứng `filter:blur(7px)`, lớp phủ `linear-gradient`, tiêu đề và nút CTA.
- **Navbar cố định:** `position:fixed; top:0`, `z-index:1000`, `backdrop-filter:blur`, hiệu ứng hover và menu mobile có nút mở/đóng.
- **CSS Grid Cards:** `display:grid; grid-template-columns:repeat(3,minmax(0,1fr))`. 3 thẻ dịch vụ có hình, tiêu đề, mô tả mở đầu bằng dấu **•** và hover nâng card/phóng ảnh.
- **Footer hai cột:** bản quyền bên trái, điều hướng bên phải; phân cấp nội dung bằng **•**.
- **Responsive:** Desktop 3 cards; tablet 2 cards; mobile 1 card. Navbar thu gọn và Footer chuyển một cột.
- **Nội dung bổ sung:** giới thiệu, blog minh họa và phần liên hệ bằng email mẫu.

## Cấu trúc

```
website-template-advanced/
├── index.html
├── css/
│   └── style.css
├── js/
│   └── main.js
├── images/
│   ├── banner.svg
│   ├── service1.svg
│   ├── service2.svg
│   └── service3.svg
└── README.md
```

**Lưu ý về hình ảnh:** Thay vì `.jpg` trong ví dụ, dự án dùng **SVG minh họa lưu trực tiếp trong GitHub** để có ảnh rõ nét, không lỗi liên kết và không cần Internet. CSS/HTML đã liên kết đúng các file `.svg` này.

## Chạy và kiểm tra

1. Mở `index.html` bằng Chrome/Edge hoặc Live Server của VS Code.
2. Cuộn trang và kiểm tra Navbar cố định, Header mờ ảnh nền, Card hover và Footer hai cột.
3. Thử các menu dịch vụ, blog, liên hệ.
4. Mở DevTools (F12 → Ctrl+Shift+M) thử 1440px, 900px, 390px; bấm nút hamburger mobile.

## Link nộp CodeGym

https://github.com/hatuan13406/code-gym/tree/main/website-template-advanced
