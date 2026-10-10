# [Thực hành] Tạo bố cục cơ bản — HTML DIV & CSS

Bài thực hành CodeGym: tạo trang chủ mô phỏng có các vùng **main, head, head-link, left, content, right, footer**. Bài xây dựng bằng HTML/CSS thuần, sử dụng **float**, **clear** và responsive. Không cần backend hoặc tải thư viện.

## Chạy thử

1. Tải mã nguồn hoặc clone repository `hatuan13406/code-gym`.
2. Mở thư mục `basic-web-layout` trong VS Code.
3. Mở file **`index.html`** bằng Chrome/Edge hoặc extension Live Server.
4. Quan sát 7 vùng trên trang và thay đổi độ rộng cửa sổ để xem responsive.

## Các vùng bố cục

| ID | Chức năng |
|---|---|
| `#main` | Bao toàn bộ trang, giới hạn rộng 1200px và căn giữa |
| `#head` | Logo bên trái và banner bên phải |
| `#head-link` | Menu ngang Home, Students, Courses, News, Gallery, Contact |
| `#left` | Các liên kết bên trái, rộng **200px**, `min-height: 400px; float: left` |
| `#content` | Nội dung giữa: **HOT NEWS**, **PHOTO SLIDE**, **NEWS 01–03** |
| `#right` | Nội dung phải: **Calendar**, **Stats Chart**, **Location Map** |
| `#footer` | Thông tin chủ sở hữu và các liên kết cuối trang |

Đoạn CSS cốt lõi:

```css
#main { width: min(1200px, calc(100% - 40px)); margin: 20px auto 26px; }
#left { width: 200px; min-height: 400px; float: left; }
#content { width: calc(100% - 430px); margin-left: 15px; float: left; }
#right { width: 200px; float: right; }
.columns::after { content: ""; display: block; clear: both; }
#footer { clear: both; }
```

**Lưu ý:** Toàn bộ lịch, biểu đồ, bản đồ và slide ảnh ở đây là nội dung **minh họa tĩnh**, không phải API, bản đồ thật hay carousel tự động. Hình ảnh được dựng bằng CSS để trang chạy offline và không phụ thuộc vào nguồn ảnh bên ngoài.

## Danh sách kiểm tra

- [x] HTML chuẩn (`<!DOCTYPE html>`, `head`, `body`) và liên kết `style.css`.
- [x] Có đủ 7 vùng `div`/HTML với các ID theo đề.
- [x] Logo và banner ở đầu trang; các liên kết ngay dưới header.
- [x] Left float trái, content ở giữa, right float phải.
- [x] Clearfix giữ chiều cao khối chứa, footer nằm dưới các cột.
- [x] Bổ sung nội dung vào các vùng, CSS rõ ràng, font thống nhất.
- [x] Responsive ở tablet/điện thoại, không phụ thuộc thư viện.

## Nộp bài

Dán link thư mục GitHub:

`https://github.com/hatuan13406/code-gym/tree/main/basic-web-layout`

## Ghi chú hình ảnh mẫu

Đường dẫn ảnh gốc của đề bài không tải được tại thời điểm thực hiện. Giao diện được thiết kế theo **mô tả cấu trúc của bài** (logo/banner, Home/Students/Courses, Hot news/Photo Slide/News 1–3, calendar/chart/map), không tuyên bố khớp 100% từng pixel với ảnh mẫu.
