# [Bài tập] Tái cấu trúc mã CSS cho sẵn — SASS

## Nguồn dự án gốc

- Repository CodeGym: https://github.com/codegym-vn/responsive-grid
- File gốc: https://github.com/codegym-vn/responsive-grid/blob/master/responsive_grid.htm
- Repo mẫu có một file HTML `responsive_grid.htm` (CSS được viết trong thẻ `<style>` và nhiều thuộc tính `style=""`), cùng README.

**Bài này tái cấu trúc đúng mẫu CodeGym**, không thay bằng mẫu web khác. Toàn bộ inline styles đã được chuyển thành các class trong SCSS. Bố cục và phối màu giữ nguyên thiết kế gốc.

## Nội dung tái cấu trúc

| Thành phần của mã gốc | Kết quả Sass |
| --- | --- |
| CSS reset `box-sizing:border-box` | `scss/base/_reset.scss` |
| Grid 12 cột `8.33%`, float, border | Mixin `grid-cell` |
| Chiều rộng sidebar `25%`, dải `100%` | Mixins `blank-column`, `color-band` |
| Các màu tím `#9933cc`, cyan `#33b5e5`, xanh `#0099cc` | `scss/abstracts/_variables.scss` |
| Hàng cao 90, 230, 50px và thước 370px | Biến và nesting trong `scss/layout/_grid.scss` |
| 4 thanh xanh `15%`, 1 thanh `92%` | Mixin `blue-block` và `scss/components/_bars.scss` |
| Overlay opacity `0.9`, lưới mờ `0.1` | `.gridcontainer--demo`, `.gridcontainer--guides` |
| 12 cột kẻ ranh giới | `gridcontent--guide`, `&:first-child` |

Kỹ thuật Sass: **variables**, **mixins** có tham số, **nesting**, **partials**, và **`@use`** hiện đại. Không dùng `@import` đã lỗi thời. Vẫn sử dụng float như mẫu gốc để giữ hành vi responsive.

## Cấu trúc thư mục

```text
sass-responsive-grid-refactor/
├── index.html
├── css/
│   └── main.css
├── scss/
│   ├── abstracts/
│   │   ├── _variables.scss
│   │   └── _mixins.scss
│   ├── base/
│   │   └── _reset.scss
│   ├── layout/
│   │   └── _grid.scss
│   ├── components/
│   │   └── _bars.scss
│   └── main.scss
├── package.json
├── .gitignore
└── README.md
```

## Cách chạy

Mở `index.html` bằng Chrome hoặc Edge. **Không cần Internet** để xem demo vì `css/main.css` đã có trong repository. Thu nhỏ/phóng to trình duyệt: các cột sử dụng tỷ lệ phần trăm, co giãn theo độ rộng trang.

Để **tự biên dịch Sass thật trên máy Windows**, mở CMD hoặc VS Code Terminal tại thư mục có `package.json`:

```cmd
node -v
npm -v
npm install
npx sass --version
npm run build
```

Lệnh `npm run build` chuyển `scss/main.scss` thành `css/main.css`, bao gồm các partials được `@use`.

Tự động cập nhật CSS:

```cmd
npm run watch
```

Trong khi đang watch, sửa `$purple: #9933cc;` trong `scss/abstracts/_variables.scss`, lưu bằng Ctrl+S, rồi tải lại `index.html`. Dừng bằng Ctrl+C.

## Trạng thái kiểm chứng

- Mã gốc đã được đọc trực tiếp từ GitHub và đối chiếu với bản chuyển đổi.
- Node.js v22.16.0 và npm 10.9.2 có trong môi trường tạo bài, **không đại diện cho máy Windows của học viên**.
- Npm Registry gặp lỗi DNS `EAI_AGAIN`, vì vậy **chưa thể cài Sass hoặc xác minh biên dịch bằng Sass CLI ở đây**.
- `css/main.css` hiện là **CSS tương đương để xem trước**, chưa phải file CSS được tạo/xác thực bằng Sass CLI. Học viên cần chạy `npm install` và `npm run build` trên máy, rồi commit lại CSS được tạo để hoàn tất chứng minh biên dịch.

## Nộp bài

https://github.com/hatuan13406/code-gym/tree/main/sass-responsive-grid-refactor
