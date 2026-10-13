# [Thực hành] Hướng dẫn cài đặt SASS bằng npm & SASS CLI

## Giới thiệu dự án

**SassLab** là website minh họa và bộ mã nguồn học Sass (Dart Sass) bằng npm/CLI:

- **Một file:** `styles.scss` ⇒ `styles.css`
- **Nhiều file:** `scss/main.scss`, `scss/components.scss` ⇒ `css/main.css`, `css/components.css`
- **Sass partials:** `scss/_variables.scss`, `scss/_mixins.scss` được nạp bằng `@use`, không sinh CSS riêng.
- Thực hành biến (`$...`), nesting, mixin (`@include`), CSS Grid và Flexbox.
- **Giao diện có thể mở trực tiếp** từ `index.html` nhờ các file CSS tương đương đã có sẵn.

**Trạng thái kiểm chứng:** Đây là bài chuẩn bị mã nguồn và hướng dẫn cho học viên. Ở môi trường tạo bài, `node -v` ra **v22.16.0**, `npm -v` ra **10.9.2**, nhưng **không cài/chạy được Dart Sass** do kết nối tới npm Registry gặp `EAI_AGAIN`. CSS trong repo là bản viết tương đương để preview, **chưa được xác minh bằng Sass CLI**. Các lệnh Sass CLI, đặc biệt `--watch`, phải được thực thi và chụp bằng **máy học viên** để hoàn thành phần thực hành. Phiên bản Node/npm trên môi trường làm bài **không phải** phiên bản trên máy bạn.

## Cấu trúc thư mục

```text
sass-npm-cli-practice/
├── index.html
├── styles.scss            # SCSS biên dịch 1 file
├── styles.css             # CSS tương đương để preview
├── scss/
│   ├── _variables.scss    # Partial: variables
│   ├── _mixins.scss       # Partial: mixins
│   ├── main.scss          # Biên dịch thành css/main.css
│   └── components.scss    # Biên dịch thành css/components.css
├── css/
│   ├── main.css           # CSS tương đương để preview
│   └── components.css     # CSS tương đương để preview
├── package.json
├── .gitignore
├── HUONG_DAN_WINDOWS.md
└── README.md
```

## 1. Kiểm tra Node.js và npm trên Windows

Mở **Command Prompt** (CMD) hoặc Terminal VS Code:

```cmd
node -v
npm -v
```

Nếu chưa có, cài Node.js phiên bản **LTS** từ https://nodejs.org/en/download rồi mở terminal mới và kiểm tra lại.

## 2. Cài và kiểm tra Sass

Di chuyển vào thư mục dự án (`package.json` nằm trong thư mục này):

```cmd
cd sass-npm-cli-practice
npm install
npx sass --version
```

`npm install` cài đúng dependency `sass` đã khai báo trong project. Có thể thử cài **global** theo yêu cầu bài học:

```cmd
npm install -g sass
sass --version
```

Không cần cài Sass global nếu chỉ dùng npm scripts, vì npm tự tìm executable cài trong `node_modules/.bin`.

## 3. Biên dịch một file SCSS sang CSS

```cmd
npx sass styles.scss styles.css --no-source-map
```

Tương đương npm script:

```cmd
npm run build:single
```

Đổi màu trong `styles.scss`, chạy lệnh trên và quan sát `styles.css`.

## 4. Theo dõi một file (`--watch`)

```cmd
npx sass --watch styles.scss styles.css --no-source-map
```

Hoặc:

```cmd
npm run watch:single
```

Giữ terminal mở, thay đổi `$accent` trong `styles.scss`, lưu file và kiểm tra `styles.css` được cập nhật. Nhấn **Ctrl + C** để dừng.

## 5. Biên dịch nhiều file từ một thư mục

```cmd
npx sass scss/:css/ --no-source-map
```

Hoặc:

```cmd
npm run build:all
```

Sass sẽ tạo/cập nhật `css/main.css` và `css/components.css`. Những file bắt đầu bằng `_` là **partials**, được dùng qua `@use`, và **không biên dịch thành các CSS riêng**. citeturn486833search2

## 6. Theo dõi toàn bộ thư mục

```cmd
npx sass --watch scss/:css/ --no-source-map
```

Hoặc:

```cmd
npm run watch:all
```

Giữ lệnh đang chạy, mở `scss/_variables.scss`, sửa `$primary`, lưu rồi kiểm tra `css/main.css` và `css/components.css` được cập nhật. Nhấn Ctrl + C để dừng.

## 7. Build toàn bộ và xem website

```cmd
npm run build
```

Sau đó mở `index.html` trong Chrome/Edge hoặc Live Server. Website đọc 3 file CSS: `css/main.css`, `css/components.css`, `styles.css`. Sau khi build, đây là CSS **thực sự do Sass tạo** trên máy bạn.

## 8. Lỗi PowerShell liên quan ExecutionPolicy

**Không dùng `Set-ExecutionPolicy Unrestricted`** để tránh vô hiệu hóa cơ chế bảo vệ quá rộng. Ưu tiên:

- Dùng CMD thay PowerShell trong VS Code.
- Trong PowerShell, thử `npm.cmd install`, `npx.cmd sass --version` hoặc `sass.cmd --version`.
- Chỉ khi hiểu tác động và thật sự cần, `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned` là phương án ít mở rộng hơn `Unrestricted`, nhưng thường không cần.

## 9. Bằng chứng yêu cầu thực hành cần tự hoàn tất

Hãy chụp màn hình terminal **trên chính máy của bạn** theo các bước trong `HUONG_DAN_WINDOWS.md`:
1. `node -v` và `npm -v`.
2. `npx sass --version` hoặc `sass --version`.
3. `npm run build:single` và CSS được cập nhật.
4. `npm run watch:single` trong lúc sửa SCSS.
5. `npm run build:all` và `npm run watch:all`, xác minh `css/main.css` và `css/components.css`.

**Không nên nộp bài dưới dạng đã thực hành Sass CLI thành công khi chưa chạy trên máy của bạn.**

## Link GitHub để nộp

https://github.com/hatuan13406/code-gym/tree/main/sass-npm-cli-practice

Tài liệu chính thức:
- https://sass-lang.com/install/
- https://sass-lang.com/documentation/cli/dart-sass/
- https://nodejs.org/en/download
