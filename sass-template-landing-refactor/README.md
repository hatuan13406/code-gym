# [Bài tập] Tái cấu trúc mã CSS các bài tập đã làm với Sass

## Nguồn đã sử dụng

**Landing Page MyBrand đã làm trước đây:** https://github.com/hatuan13406/code-gym/tree/main/responsive-landing-page

Trong repo hiện tại, chưa tìm thấy bốn bài Template được đề cập (navigation/header, sản phẩm nổi bật, thống kê, footer) dưới dạng bốn thư mục/bài làm riêng. Vì vậy dự án này dùng **trang Landing Page có sẵn gần nhất đã xác minh được**, không khẳng định đây chính là file thiết kế gốc của học phần Template.

Trang MyBrand bao gồm Header/Navbar, Hero, dashboard **số liệu thống kê**, ba **thẻ dịch vụ nổi bật** (không phải catalog sản phẩm), đánh giá, CTA và Footer. Bản refactor giữ nguyên HTML, nội dung, thứ tự các phần và giao diện; chỉ chuyển CSS qua Sass.

## Cấu trúc bài làm

```text
sass-template-landing-refactor/
├── index.html
├── original/
│   ├── index.html           # HTML gốc, không thay đổi
│   └── style.css            # CSS gốc, không thay đổi
├── scss/
│   ├── abstracts/
│   │   ├── _variables.scss  # Các biến Sass
│   │   └── _mixins.scss     # Các mixin tái sử dụng
│   ├── base/
│   │   └── _global.scss    # :root, CSS reset, global
│   ├── layout/
│   │   ├── _navigation.scss # Navbar/Header
│   │   ├── _footer.scss     # CTA/Footer
│   │   └── _responsive.scss # Breakpoints bản gốc
│   ├── sections/
│   │   ├── _hero.scss       # Hero, stats, chart và feature strip
│   │   ├── _services.scss   # Ba card dịch vụ
│   │   └── _testimonials.scss
│   └── main.scss            # Sass module entrypoint
├── css/
│   └── main.css            # CSS gốc để xem trước; Sass sẽ ghi đè khi build
├── package.json
├── .gitignore
├── VISUAL_CHECK.md
└── README.md
```

## Các tính năng Sass đã áp dụng

| Kỹ thuật | Cách sử dụng |
|---|---|
| **Variables** | Màu sắc, shadow, số cột nằm ở `abstracts/_variables.scss`. Interpolation `#{v.$primary}` xuất ra CSS custom property `--primary` để giữ nguyên cách hoạt động của trang cũ. |
| **Mixins** | `mx.columns()` được dùng cho dashboard thống kê và các thẻ; `mx.card-surface()` dùng cho thẻ dịch vụ/đánh giá; `mx.flex-center` dùng cho đồ họa Hero. |
| **Nesting** | `&:hover`, `&.current` và selector `span` trong navigation, button, dịch vụ và footer. |
| **Partials** | Chia theo từng thành phần và nạp bằng Sass `@use` (không dùng `@import` đã deprecated). |
| **Responsive** | Giữ tất cả breakpoint gốc 1020px, 768px, 600px, 350px cùng reduced-motion. |

## Chạy Sass trên Windows / VS Code

Mở Terminal tại thư mục có `package.json`:

```cmd
node -v
npm -v
npm install
npx sass --version
npm run build
```

Lệnh build biên dịch **`scss/main.scss` → `css/main.css`**:

```cmd
sass scss/main.scss css/main.css --no-source-map
```

Để theo dõi sửa file Sass:

```cmd
npm run watch
```

Thử sửa `$primary` trong `scss/abstracts/_variables.scss` rồi lưu, xem giao diện đổi màu. **Đổi lại giá trị màu gốc và build lại** để đảm bảo bài nộp giữ nguyên thiết kế.

## Tình trạng kiểm tra

Đã đối chiếu nguyên bản CSS của repository nguồn. `index.html` của bài chỉ thay liên kết stylesheet `style.css` thành `css/main.css`. CSS hiện có trong `css/main.css` giữ nguyên CSS gốc (thêm chú thích) để trang hiển thị đúng ngay cả khi chưa cài Sass.

Đã chạy Chromium/Playwright bằng cách nạp HTML/CSS trực tiếp, so sánh toàn trang tại **1440px, 768px, 390px**: **không khác một pixel**, cùng chiều cao và không tràn ngang. Chi tiết ở `VISUAL_CHECK.md`.

**Chưa xác minh Sass CLI biên dịch thực tế trong môi trường này:** Node.js/npm có sẵn nhưng npm Registry gặp lỗi DNS `EAI_AGAIN`; do đó `css/main.css` **chưa phải đầu ra xác minh từ Sass**. Bạn cần chạy `npm install` và `npm run build` trên máy, sau đó commit CSS vừa được tạo để hoàn tất bước biên dịch bắt buộc của đề.

## Link bài tập

https://github.com/hatuan13406/code-gym/tree/main/sass-template-landing-refactor
