# [Bài tập] Tạo gallery đơn giản sử dụng RWD

Bài tập CodeGym: thực hành **Media Queries** để làm một **Responsive Image Gallery** gồm 4 ảnh phong cảnh với chú thích. Bố cục dựa trên bản mẫu: https://demo.codegym.vn/web/15/gallery/gallery.html

## Yêu cầu responsive

| Chiều rộng màn hình | Số ảnh trên mỗi hàng |
|---|---|
| Lớn hơn 700px | 4 |
| Từ 501px đến 700px | 2 |
| Tối đa 500px | 1 |

Dùng CSS Grid và hai Media Query tại `700px` và `500px`:

```css
.gallery { display: grid; grid-template-columns: repeat(4, minmax(0, 1fr)); }

@media screen and (max-width: 700px) {
    .gallery { grid-template-columns: repeat(2, minmax(0, 1fr)); }
}

@media screen and (max-width: 500px) {
    .gallery { grid-template-columns: 1fr; }
}
```

## Cấu trúc thư mục

```text
rwd-image-gallery/
├── index.html
├── style.css
└── README.md
```

## Chạy và kiểm tra

1. Mở `index.html` trong Chrome hoặc Edge, hoặc sử dụng VS Code Live Server.
2. Nhấn **F12**, sau đó nhấn **Ctrl + Shift + M** để mô phỏng thiết bị.
3. Thử các độ rộng `1200px`, `600px`, `375px` và đếm số hình trên mỗi hàng.
4. Kiểm tra trang không bị cuộn ngang trên màn hình nhỏ.

**Lưu ý ảnh:** Bốn ảnh phong cảnh được tải từ địa chỉ ảnh minh họa công khai của W3Schools. Cần kết nối Internet để trình duyệt tải ảnh; mã nguồn HTML/CSS vẫn chạy offline.

## Link nộp CodeGym

https://github.com/hatuan13406/code-gym/tree/main/rwd-image-gallery
