# [Thực hành] Tạo mixins & biến để tối ưu CSS của website mẫu

Dự án **MixLab** sử dụng **Sass Variables, Mixins, Nesting và Partials**. File `styles-before.css` giữ nguyên CSS ban đầu của đề để đối chiếu với mã SCSS mới.

## Cấu trúc thư mục

```text
sass-variables-mixins-practice/
├── index.html
├── styles-before.css
├── scss/
│   ├── abstracts/
│   │   ├── _variables.scss
│   │   └── _mixins.scss
│   ├── base/
│   │   ├── _global.scss
│   │   └── _typography.scss
│   ├── layout/
│   │   ├── _container.scss
│   │   └── _sections.scss
│   ├── components/
│   │   ├── _buttons.scss
│   │   └── _cards.scss
│   └── main.scss
├── css/
│   └── main.css
├── package.json
├── .gitignore
└── README.md
```

## Các yêu cầu hoàn thành về mã nguồn

**Variables:** `scss/abstracts/_variables.scss` chứa `$primary-color: red`, `$text-color: #222`, `$font-large: 32px`, `$font-medium: 28px`, `$padding-standard: 10px 20px` và `$box-shadow-default: 2px 2px 10px rgba(0,0,0,.1)`. Có biến bổ sung cho màu sắc của website demo.

**Mixins:** `scss/abstracts/_mixins.scss` định nghĩa `@mixin button-style($bg-color)`, `@mixin box-style` và mixin responsive `@mixin mobile`.

**Tái sử dụng:** `scss/components/_buttons.scss` gọi `@include mix.button-style(v.$primary-color)`; `scss/components/_cards.scss` gọi `@include mix.box-style` và có nesting `&:hover`. `scss/base/_typography.scss` dùng biến cho h1 và h2.

**Partials:** Tách rõ `abstracts/`, `base/`, `layout/`, `components/`. `scss/main.scss` nạp toàn bộ qua `@use` (thay `@import` cũ).

## Cách chạy trên Windows

Mở dự án bằng VS Code và Terminal tại thư mục có `package.json`. Nếu chưa có Node.js, cài bản LTS tại https://nodejs.org/en/download. Sử dụng Command Prompt (CMD):

```cmd
node -v
npm -v
npm install
npx sass --version
npm run build
```

Sass sẽ biên dịch `scss/main.scss` ra `css/main.css`. Mở `index.html` để xem giao diện.

### Watch mode

```cmd
npm run watch
```

Trong lúc watcher đang chạy, mở `scss/abstracts/_variables.scss`, sửa `$primary-color: red;` thành màu khác rồi lưu (Ctrl+S). Kiểm tra màu của nút `.button` trong `css/main.css` đã đổi. Dừng watcher bằng **Ctrl+C**.

## Kết quả và giới hạn xác minh

Trang demo dùng CSS tương đương với nguồn SCSS, **chưa được xác minh biên dịch bằng Sass CLI** ở môi trường tạo bài vì kết nối tới npm Registry gặp lỗi DNS `EAI_AGAIN`. Do đó `css/main.css` hiện là bản CSS viết tương đương phục vụ xem trước, **không phải kết quả được xác nhận từ lệnh sass**. Để hoàn thành kiểm chứng, chạy `npm install`, `npm run build` và cập nhật CSS đầu ra thật lên GitHub trên máy cá nhân.

## Link nộp CodeGym

https://github.com/hatuan13406/code-gym/tree/main/sass-variables-mixins-practice
