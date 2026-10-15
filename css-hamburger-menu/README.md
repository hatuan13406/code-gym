# Hamburger Menu Responsive (CSS Only)

## Các bước thực hiện
1. Tạo `responsive-nav.html`, thêm thẻ `meta viewport` và liên kết `style.css`.
2. Tạo Header chứa logo, `input type="checkbox"`, `label` có ba thanh hamburger và `nav` với bốn liên kết.
3. Viết CSS theo hướng Mobile First: căn logo và icon với Flexbox, ẩn menu mobile mặc định.
4. Dùng `.menu-toggle:checked ~ .main-nav` để mở menu, đồng thời biến ba thanh thành dấu X, hoàn toàn không có JavaScript.
5. Dùng `@media (min-width: 768px)` để ẩn hamburger và hiển thị menu ngang trên desktop.
6. Thêm nội dung trang demo, kiểu chữ, trạng thái hover và hỗ trợ focus khi dùng bàn phím.

## Cách chạy
Mở `responsive-nav.html` bằng trình duyệt hoặc Live Server của VS Code.

## Cách kiểm tra
- **Mobile (< 768px):** Logo và nút hamburger; nhấn hamburger để hiện/ẩn menu thả xuống.
- **Desktop (>= 768px):** Menu ngang hiển thị liên tục, hamburger ẩn.
- Thử dùng Tab rồi Space để bật/tắt checkbox từ bàn phím.

## Ghi chú
Bài tập sử dụng CSS checkbox hack, không yêu cầu JavaScript hoặc thư viện ngoài. Checkbox được ẩn về mặt hiển thị nhưng vẫn có thể nhận focus.
