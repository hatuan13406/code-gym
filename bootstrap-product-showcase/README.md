# [Bài tập] Thiết kế Trang Giới Thiệu Sản Phẩm

Bài CodeGym xây dựng trang sản phẩm **AURA One Pro** (thương hiệu, tính năng và thiết bị **hư cấu**) lấy cảm hứng từ phong cách giới thiệu sản phẩm công nghệ tối giản. Không sao chép hình, nhãn hiệu hoặc nội dung của Apple.

## Công nghệ

- **Bootstrap 5.3.3** qua CDN, **Font Awesome 6.5.2** qua CDN.
- **Grid System**: `container`, `row`, `col-lg-5`, `col-lg-7`, `col-md-4`, `col-md-3`, `col-6`.
- **Display**: `d-flex`, `d-inline-flex`, `order-1`, `order-lg-2`, `order-2`, `order-lg-1`, `d-flex flex-wrap`; ví dụ CSS `display: contents` ở vùng thông số.
- **Flexbox**: `justify-content-center`, `justify-content-between`, `align-items-center`, `align-items-end`, `mt-auto`.
- **Spacing**: `py-5`, `mb-3`, `p-4`, `px-4`, `gap-3`, `g-4`, `g-5`.
- **Icons**: camera, tia sét, khiên, màn hình, bảng màu từ Font Awesome.
- Hình ảnh SVG **tự minh họa** lưu trong `images/` để luôn hiển thị sau khi tải repository.

## Cấu trúc

```
bootstrap-product-showcase/
├── index.html
├── style.css
├── script.js
├── images/
│   ├── aura-phone.svg
│   └── aura-camera.svg
└── README.md
```

## Cách chạy

1. Mở `index.html` bằng Chrome, Edge hoặc VS Code Live Server.
2. Cần Internet để lấy Bootstrap và Font Awesome qua CDN; **ảnh SVG không cần Internet**.
3. Kiểm tra Hero, ba thẻ tính năng, thiết kế camera, lựa chọn màu, vùng thông số và CTA.
4. Nhấn F12 → Ctrl + Shift + M thử desktop 1440px, tablet 768px và mobile 375px.
5. Thử menu mobile bằng nút hamburger và thử chọn ba màu (chỉ đổi nhãn màu, không thay đổi ảnh thiết bị).

Trang chỉ giới thiệu sản phẩm hư cấu, không có thanh toán và không có giá bán thực tế.

## Link nộp bài

https://github.com/hatuan13406/code-gym/tree/main/bootstrap-product-showcase
