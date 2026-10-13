# [Thực hành] Chuyển đổi CSS có sẵn sang SASS theo chuẩn

Bài thực hành CodeGym chuyển **4 rules CSS gốc** thành một dự án **SCSS chia module**, sử dụng các thành phần bắt buộc: **variables, mixins, nesting, partials, abstracts/base/layout/components và main.scss**.

Dự án dùng cú pháp **`@use` hiện đại** thay cho `@import` trong đề, vì `@import` đã bị Sass đánh dấu deprecated. Khi dùng `@use`, mỗi partial tự import namespace nó cần, không dựa vào biến global.

## Cấu trúc

```
sass-css-refactor-practice/
├── index.html                 # Trang minh họa giao diện
├── styles.css                # CSS gốc y hệt đề bài
├── scss/
│   ├── abstracts/
│   │   ├── _variables.scss
│   │   └── _mixins.scss
│   ├── base/
│   │   └── _global.scss
│   ├── layout/
│   │   └── _container.scss
│   ├── components/
│   │   ├── _buttons.scss
│   │   └── _cards.scss
│   └── main.scss             # Entrypoint
├── css/
│   ├── main.css              # CSS tương đương đầu ra SCSS
│   └── demo.css              # CSS TRÌNH BÀY cho trang index.html
├── package.json
├── .gitignore
└── README.md
```

## 1. CSS gốc

Nằm tại **`styles.css`**. Gồm bốn selector `body`, `.container`, `.button` và `.card` đúng như đề bài, được giữ riêng để dễ so sánh.

## 2. Tổ chức lại bằng SCSS

- **`abstracts/_variables.scss`**: `$primary-color`, `$text-color`, `$background-color`, `$border-color`, `$box-shadow`.
- **`abstracts/_mixins.scss`**: `@mixin button-style($bg-color)` và `@mixin box-shadow`.
- **`base/_global.scss`**: kiểu chữ, text color, nền trang.
- **`layout/_container.scss`**: `width: 80%; margin: 0 auto;`.
- **`components/_buttons.scss`**: dùng `@include mix.button-style(vars.$primary-color)`, thêm nesting `&:hover`, `&:focus-visible`.
- **`components/_cards.scss`**: dùng `@include mix.box-shadow`; nesting `h3` và `p`.
- **`main.scss`**: tập trung bốn câu lệnh `@use` để nạp toàn bộ các phần.

**Lưu ý:** Các thuộc tính CSS gốc không bị bỏ; SCSS chỉ tổ chức lại và thêm một số trạng thái minh họa.

## 3. Chạy trên Windows (CMD hoặc VS Code Terminal)

Nếu chưa cài Node.js/npm, cài bản LTS từ https://nodejs.org/en/download.

Kiểm tra môi trường:

```cmd
node -v
npm -v
```

Mở Terminal tại thư mục `sass-css-refactor-practice`, sau đó:

```cmd
npm install
npx sass --version
npm run build
```

Lệnh `npm run build` chạy:

```cmd
sass scss/main.scss css/main.css --no-source-map
```

Lệnh đó biên dịch toàn bộ các partial được nạp trong `scss/main.scss` thành **`css/main.css`**. File `css/demo.css` chỉ để trang mẫu đẹp hơn và **không thuộc đầu ra Sass**.

Để theo dõi thay đổi:

```cmd
npm run watch
```

Sửa `$primary-color` trong `scss/abstracts/_variables.scss`, nhấn Ctrl+S, kiểm tra `css/main.css` được cập nhật. Nhấn Ctrl+C để dừng `--watch`.

Sau khi build, mở `index.html` trên Chrome/Edge và xem trang minh họa. Không cần Internet để mở HTML/CSS, nhưng cần Internet khi chạy `npm install` lần đầu.

## 4. Tự kiểm tra kết quả

Mở `css/main.css` sau build, xác nhận:

```css
body { font-family: Arial, sans-serif; color: #333; background: #f4f4f4; }
.container { width: 80%; margin: 0 auto; }
.button { background: blue; color: white; padding: 10px 20px; border-radius: 5px; }
.card { border: 1px solid #ddd; padding: 20px; box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1); }
```

Một số rules bổ sung xuất hiện do nesting: `.button:hover`, `.button:focus-visible`, `.card h3`, `.card p`.

## 5. Trạng thái xác minh

**Đã tạo:** Toàn bộ file SCSS, CSS gốc, CSS tương đương, cấu hình npm, trang xem trước và hướng dẫn.

**Chưa xác minh bằng Sass CLI:** Môi trường tạo bài có Node.js/npm nhưng không truy cập được npm Registry (`EAI_AGAIN`), do đó không thể cài Sass hoặc xác nhận biên dịch thực tế. **`css/main.css` hiện tại được soạn tương đương để preview, không được trình bày là đầu ra biên dịch đã kiểm chứng.** Hãy chạy `npm install`, `npm run build` trên máy cá nhân để tạo đầu ra thật và kiểm tra trước khi nộp.

## Link nộp bài CodeGym

https://github.com/hatuan13406/code-gym/tree/main/sass-css-refactor-practice
