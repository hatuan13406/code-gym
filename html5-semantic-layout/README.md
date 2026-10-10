# [Bài tập] Tạo layout với các thẻ HTML5 và CSS

Bài tập thực hành CodeGym: xây dựng trang web với các **thẻ HTML5 có ngữ nghĩa** thay vì dùng `<div>` để mô tả tất cả các vùng.

## Cấu trúc thư mục

```text
html5-semantic-layout/
├── index.html
├── style.css
└── README.md
```

## Các thẻ HTML5 được sử dụng

| Thẻ | Vị trí / Chức năng |
|---|---|
| `<header>` | Logo, thông tin đầu trang và banner giới thiệu |
| `<nav>` | Thanh menu điều hướng ngang với các liên kết |
| `<section>` | Vùng nội dung chính, nhóm các bài viết có cùng chủ đề |
| `<article>` | Các bài viết độc lập bên trong section |
| `<aside>` | Sidebar bên phải: danh mục, kiến thức bổ trợ và ghi nhớ |
| `<footer>` | Thông tin cuối trang, bản quyền và liên kết quay về đầu trang |

Bài còn có `<time>`, `<main>`? **Không có thẻ `<main>`** vì `section` là khu vực chính để thực hành đúng 6 thẻ được đề nêu. Khối `.page-layout` chỉ có chức năng bao hai cột để bố trí bằng CSS Grid.

## Cách chạy

1. Mở thư mục `html5-semantic-layout` trong VS Code hoặc trình quản lý file.
2. Mở `index.html` bằng Chrome/Edge hoặc sử dụng Live Server.
3. Kiểm tra trang có đầy đủ header, menu, danh sách bài viết, sidebar và footer.
4. Kéo nhỏ trình duyệt: từ 790px trở xuống sidebar sẽ chuyển xuống dưới, từ 520px trở xuống thẻ article xếp ảnh minh hoạ lên trên nội dung.

## Công nghệ và kỹ thuật

- HTML5 semantic tags: `header`, `nav`, `section`, `article`, `aside`, `footer`.
- CSS3: CSS Grid, Flexbox, pseudo-element, gradient, transition hover.
- Bố cục theo 2 cột: `grid-template-columns: minmax(0, 1fr) 295px`.
- Responsive bằng media queries.
- Giao diện không có JavaScript, không dùng thư viện ngoài.
- Các hình minh hoạ dựng từ CSS nên chạy được kể cả không kết nối Internet.

## Kiểm tra nhanh

- Kiểm tra HTML có đủ 6 thẻ semantic.
- Có liên kết `<link rel="stylesheet" href="style.css">`.
- Menu có các liên kết đến ID thực sự trên trang.
- Ít nhất 2 thẻ `article` nằm trong `section`.
- Footer hiển thị bên dưới toàn bộ nội dung.
- Giao diện chuyển thành một cột trên màn hình nhỏ.

**Ghi chú:** Ảnh mẫu từ đường dẫn CodeGym không tải được tại lúc thực hiện. Bài hoàn thành theo mô tả và các thẻ bắt buộc của đề, không khẳng định giống hoàn toàn từng chi tiết so với hình minh họa.

## Link nộp CodeGym

```text
https://github.com/hatuan13406/code-gym/tree/main/html5-semantic-layout
```
