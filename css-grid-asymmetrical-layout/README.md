# Thử thách bố cục bất đối xứng (CSS Grid)

## Các bước thực hiện
1. Tạo `creative-layout.html`, liên kết `style.css` và thêm 6 phần tử `.item` trong container.
2. Reset `box-sizing`, đặt nền tối và màu riêng cho mỗi item.
3. Dùng `display: grid`, `grid-template-columns: repeat(4, 1fr)`, `grid-auto-rows: 120px`, `gap: 10px`.
4. Đặt Item 1 chiếm 2 cột và 2 hàng với `grid-column: span 2` và `grid-row: span 2`.
5. Đặt Item 3 chiếm 2 cột; Item 4 chiếm 2 hàng.
6. Thêm bo góc và căn giữa chữ; hỗ trợ 2 cột trên màn hình nhỏ.

## Cách chạy
Mở `creative-layout.html` trong trình duyệt hoặc Live Server của VS Code.

## Ghi chú
Có thể thử thay `repeat(4, 1fr)` thành `1fr 2fr 1fr 1fr` hoặc điều chỉnh `grid-column`, `grid-row` để khám phá bố cục mosaic khác.
