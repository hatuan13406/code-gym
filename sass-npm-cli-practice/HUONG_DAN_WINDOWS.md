# Thực hành Sass CLI trên máy Windows — checklist nộp CodeGym

**Mục tiêu:** Bạn tự hoàn tất các thao tác bắt buộc trên máy cá nhân, vì thao tác cài npm/Sass trên máy bạn không thể được xác nhận từ repository.

## Bước 1: Clone hoặc tải thư mục bài

Repository: https://github.com/hatuan13406/code-gym/tree/main/sass-npm-cli-practice

Có thể chọn **Code → Download ZIP** từ repository, giải nén, sau đó mở **riêng thư mục `sass-npm-cli-practice`** bằng VS Code.

## Bước 2: Mở CMD và kiểm tra môi trường

Dùng VS Code → **Terminal → New Terminal**, chọn **Command Prompt**:

```cmd
node -v
npm -v
```

Nếu không có, cài Node.js LTS từ https://nodejs.org/en/download rồi mở Terminal mới.

📸 Gợi ý: Chụp terminal hiển thị cả 2 phiên bản bằng Win + Shift + S.

## Bước 3: Cài Sass, xác nhận phiên bản

Đảm bảo Terminal đang ở nơi có `package.json`:

```cmd
npm install
npx sass --version
```

Muốn thực hiện đúng cả bước cài global trong đề bài:

```cmd
npm install -g sass
sass --version
```

📸 Chụp terminal có thông báo `sass --version` (chụp thực tế, không dùng số phiên bản ví dụ).

## Bước 4: Biên dịch SCSS đơn

```cmd
sass styles.scss styles.css --no-source-map
```

Nếu chỉ cài local mà không cài global:

```cmd
npx sass styles.scss styles.css --no-source-map
```

Hoặc dùng `npm run build:single`. Mở `styles.css` để thấy các biến đã chuyển thành giá trị CSS.

📸 Chụp terminal + hai file mở trong VS Code.

## Bước 5: Watch một file

```cmd
npm run watch:single
```

Trong lúc terminal còn chạy, sửa `$accent` trong `styles.scss`, lưu bằng **Ctrl + S**. Mở `styles.css`, tìm background của `.demo-button` đã đổi màu. Dừng Watch bằng **Ctrl + C**.

📸 Chụp lệnh đang watch và file CSS đã cập nhật.

## Bước 6: Build cả thư mục

```cmd
npm run build:all
```

Sass sẽ tạo/cập nhật 2 file:
- `css/main.css`
- `css/components.css`

File `scss/_variables.scss` và `scss/_mixins.scss` chỉ là partial, không có file CSS riêng.

📸 Chụp terminal và cây thư mục CSS.

## Bước 7: Watch cả thư mục

```cmd
npm run watch:all
```

Trong lúc watcher đang hoạt động, sửa `$primary: #6858df;` thành màu khác ở `scss/_variables.scss`; lưu file. Kiểm tra CSS trong `css/main.css` và `css/components.css` cập nhật. Dừng watcher bằng **Ctrl + C**.

📸 Chụp watcher biên dịch lại CSS khi file SCSS thay đổi.

## Bước 8: Hoàn tất GitHub và nộp

1. Đưa **CSS mới do Sass CLI tạo** lên GitHub (thay bản CSS preview ban đầu), dùng Git hoặc GitHub Upload files.
2. Ảnh bằng chứng có thể lưu vào `screenshots/` trong repository, hoặc đính kèm riêng trên CodeGym.
3. Nộp link: https://github.com/hatuan13406/code-gym/tree/main/sass-npm-cli-practice

## Nếu PowerShell chặn npm.ps1 hoặc sass.ps1

Thử **CMD** hoặc hậu tố **`.cmd`**:

```powershell
npm.cmd install
npx.cmd sass --version
```

**Không chạy `Set-ExecutionPolicy Unrestricted`**. Đây là thiết lập quá rộng và không cần thiết cho bài thực hành.

## Lưu ý minh bạch

- Các file CSS trong repository lúc đầu chỉ là CSS tương đương để trình diễn giao diện.
- Việc cài Sass, compile và watch thực tế cần được bạn thực hiện ở trên máy Windows.
