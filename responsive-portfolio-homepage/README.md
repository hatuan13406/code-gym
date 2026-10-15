# Mini project – Responsive Portfolio Homepage (Mobile-First)

Dự án tốt nghiệp HTML/CSS: chuyển mẫu `homepage.html` ở bài CSS Grid trước thành portfolio có 6 thẻ dự án, sử dụng một tệp `style.css` mới viết theo phương pháp **Mobile-First**.

## Các bước đã thực hiện

1. Dựa trên cấu trúc trang chủ bài trước: `body.page-container`, `header`, `main.content-grid`, 6 thẻ `.card`, `footer`. Đổi nội dung mẫu từ báo online thành các dự án portfolio.
2. Thêm `<meta name="viewport" content="width=device-width, initial-scale=1.0">` và liên kết `style.css`.
3. Viết CSS mới từ đầu, mở đầu với `box-sizing: border-box`; dùng `rem`, `%`, `vw`, `clamp()`.
4. **Mobile (<768px):** toàn trang và lưới dự án có 1 cột, thẻ xếp dọc; ảnh `max-width: 100%`, `object-fit: cover`.
5. **Tablet (>=768px):** dùng `@media (min-width: 768px)`, lưới 2 cột; một số thẻ nổi bật chiếm 2 cột.
6. **Desktop (>=1024px):** dùng `@media (min-width: 1024px)`, lưới 4 cột; áp dụng `grid-column: span 2`, `grid-row: span 2` để tạo mosaic; giới hạn `max-width` và căn giữa toàn trang.
7. **Hình ảnh đáp ứng:** ảnh của thẻ dự án 1 sử dụng `srcset` (480w/960w/1440w) và `sizes` để trình duyệt chọn ảnh phù hợp màn hình. Các ảnh khác có `loading="lazy"`, tất cả ảnh đặt kích thước gốc để hạn chế dịch chuyển bố cục.
8. Thêm điều hướng, trạng thái hover/focus, và tôn trọng `prefers-reduced-motion`.

## Cách chạy

Mở trực tiếp `homepage.html` trong trình duyệt hoặc sử dụng Live Server trên VS Code. **Cần Internet để tải ảnh minh họa từ Picsum Photos**.

## Kiểm tra bằng DevTools (F12)

| Chiều rộng | Kết quả mong đợi |
| --- | --- |
| 375px / 430px | Mobile: 1 cột |
| 768px / 900px | Tablet: 2 cột |
| 1024px / 1440px | Desktop: 4 cột, mosaic bất đối xứng |

Kiểm tra ảnh có tỷ lệ đúng, không xuất hiện thanh cuộn ngang, header/main/footer xếp theo thứ tự, và ảnh dự án 1 có thuộc tính `srcset` + `sizes`.

## Ghi chú

Đây là thư mục bài tập **riêng biệt**, giữ nguyên phiên bản dự án Module 7 trong `css-grid-online-newspaper/` để tiện đối chiếu trước và sau khi responsive.
