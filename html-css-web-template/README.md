# [Thực hành] Template web page using HTML and CSS

Bài tập CodeGym tạo website **DevSpace** bằng HTML5, CSS thuần và một chút JavaScript để xử lý tìm kiếm/menu.

## Theo cấu trúc bài học

- Navbar `navbar background`, `nav-list`, logo riêng và ô Search.
- `firstsection`: Web Technology, định dạng bằng `box-main`, `firstHalf`.
- `secondsection`: C Programming với `section-Left { flex-direction: row-reverse; }` để đảo vị trí nội dung/ảnh.
- `section`: Java, có `paras` và `thumbnail img`.
- Footer có `text-footer`.
- Toàn bộ hình ảnh SVG là minh họa được lưu trong thư mục `images/`. Không phụ thuộc nguồn ảnh bên ngoài.
- Menu và nội dung có responsive cho desktop/mobile.
- Nút Search tìm các chủ đề Web/HTML/CSS, C Programming, Java và Courses trong trang; không gửi dữ liệu ra máy chủ.

## Cấu trúc

```
html-css-web-template/
├── index.html
├── style.css
├── script.js
├── images/
│   ├── logo.svg
│   ├── hero-code.svg
│   └── laptop.svg
└── README.md
```

## Chạy và kiểm tra

1. Mở `index.html` trong Chrome/Edge hoặc dùng Live Server trong VS Code.
2. Chọn Web Technology, C Programming, Java hoặc Courses trong Navbar.
3. Nhập từ khóa `html`, `c programming` hoặc `java` vào tìm kiếm.
4. Nhấn F12 → Ctrl+Shift+M và thử 1440px, 768px, 375px.
5. Ở mobile, sử dụng nút menu để mở/đóng thanh điều hướng.

Không cần Internet khi mở trang vì không sử dụng thư viện, font hoặc ảnh CDN.

## Link nộp CodeGym

https://github.com/hatuan13406/code-gym/tree/main/html-css-web-template
