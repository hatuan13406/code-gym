# Mini project: Trang chủ báo online với CSS Grid

## Mục tiêu
Xây dựng bố cục trang báo online hiện đại, sử dụng CSS Grid lồng nhau (nested grids) và thẻ tin bất đối xứng.

## Các bước thực hiện
1. Tạo `homepage.html` và liên kết `style.css`, khai báo tiếng Việt và viewport.
2. Xây dựng `body.page-container` với các thành phần `header`, `main.content-grid`, `footer`.
3. Sử dụng `display: grid`, `grid-template-rows: auto 1fr auto`, `min-height: 100vh` cho bố cục tổng.
4. Thiết lập `grid-column: 1 / -1` để header và footer chiếm toàn bộ chiều ngang.
5. Tạo lưới lồng trong main bằng `grid-template-columns: repeat(4, minmax(0, 1fr))`, `grid-auto-rows: 200px`, `gap: 16px`.
6. Thêm sáu thẻ tin dạng mosaic, sử dụng `grid-column: span 2` và `grid-row: span 2` để tạo điểm nhấn.
7. Thiết kế nền, kiểu chữ, nhãn chuyên mục, hiệu ứng hover và responsive cho tablet/mobile.

## Cách chạy
Mở file `homepage.html` trong trình duyệt hoặc dùng Live Server của VS Code. Không yêu cầu cài thư viện hay Internet.

## Kiểm tra
- Desktop: lưới 4 cột, thẻ nổi bật chiếm 2 cột và 2 hàng.
- Tablet: lưới 2 cột.
- Mobile: lưới 1 cột.
- Header và footer luôn trải hết bề ngang trang.
