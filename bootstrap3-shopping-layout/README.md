# [Thực hành] Tạo layout trong Bootstrap 3

Bài thực hành CodeGym triển khai đúng **Bootstrap 3.3.7**, không dùng class Bootstrap 5. Tệp bắt buộc **`layout.html`** nằm ở thư mục gốc bài tập.

## Cấu trúc

```
bootstrap3-shopping-layout/
├── layout.html
├── index.html
├── poly.css
├── script.js
├── images/
│   ├── header-object.svg
│   ├── shoppingcart.svg
│   └── product-1.svg ... product-6.svg
└── README.md
```

## Những phần đã làm

- **Header** có `.shopping-mall`, ảnh giỏ hàng bên phải (`.pull-right`).
- **Navbar** `.navbar.navbar-inverse`, 6 mục chính và **Glyphicons** theo đề; tài khoản có dropdown.
- **Main / Sidebar:** `.row` với `article.col-sm-9` và `aside.col-sm-3`.
- **Sidebar:** giỏ hàng dùng Bootstrap `.panel` (ảnh chiếm `col-xs-5`, nội dung `col-xs-7`), ô tìm kiếm `.form-control`, danh mục `.list-group`.
- **Products:** 6 sản phẩm, mỗi hàng **3 sản phẩm** qua `.col-sm-4`, panel heading/body/footer lần lượt tên/ảnh/giá.
- **Footer** dùng `.panel.panel-default` và `.panel-heading.text-center`.
- Có chức năng bổ sung: lọc sản phẩm theo tên, chủng loại; nút Mua tăng số lượng và tổng tiền giỏ hàng **trong bộ nhớ trang**, không xử lý thanh toán.
- Ảnh sản phẩm và giỏ hàng là **SVG minh họa được lưu trong repository**, không phụ thuộc link ảnh từ bên ngoài.
- **Responsive:** từ 768px trở lên lưới 3 cột; dưới 768px lưới sản phẩm 2 cột (rất hẹp vẫn có thể xem), sidebar chuyển xuống dưới.

## Cách chạy

1. Mở **`layout.html`** hoặc `index.html` bằng Chrome/Edge hay VS Code Live Server.
2. **Cần Internet** để tải Bootstrap 3.3.7 và jQuery 3.2.1 qua CDN.
3. Thử Navbar và menu Tài khoản, ô Keywords, danh mục Chủng Loại, nút Mua.
4. Dùng F12 → Ctrl+Shift+M để kiểm tra 1280px, 768px, 390px và 320px.

Đây là bài thực hành frontend, không có API thanh toán và không có tài khoản thực.

## Link nộp bài

https://github.com/hatuan13406/code-gym/tree/main/bootstrap3-shopping-layout
