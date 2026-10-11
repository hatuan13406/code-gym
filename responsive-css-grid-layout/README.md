# [Bài tập] Tạo bố cục responsive bằng CSS Grid

Bài tập CodeGym sử dụng HTML5 và CSS Grid để tạo bố cục website hiện đại, có đầy đủ **Header, Navigation, Main Content, Sidebar và Footer**. Không cần JavaScript hay thư viện bên ngoài.

## Cấu trúc thư mục

```text
responsive-css-grid-layout/
├── index.html
├── style.css
└── README.md
```

## Bố cục Desktop

Lưới chính có 2 cột, **Main Content chiếm 3 phần**, **Sidebar chiếm 1 phần**, còn Header, Navigation, Footer đều trải ngang cả 2 cột:

```css
.page-grid {
    display: grid;
    grid-template-columns: minmax(0, 3fr) minmax(0, 1fr);
    grid-template-areas:
        "header header"
        "nav nav"
        "main sidebar"
        "footer footer";
}
```

## Bố cục Mobile

Khi chiều rộng màn hình **≤768px**, toàn bộ 5 vùng xếp dọc theo đúng thứ tự:

```css
@media (max-width: 768px) {
    .page-grid {
        grid-template-columns: 1fr;
        grid-template-areas:
            "header"
            "nav"
            "main"
            "sidebar"
            "footer";
    }
}
```

Bố cục có thêm các Media Queries tại 1150px, 520px và 350px để tối ưu khoảng cách và các thẻ nội dung.

## Cách chạy / kiểm tra

1. Tải mã nguồn hoặc clone repository `hatuan13406/code-gym`.
2. Mở file `responsive-css-grid-layout/index.html` bằng Chrome hoặc Edge, hoặc sử dụng Live Server trong VS Code.
3. Trên **desktop** (ví dụ 1280px): Header → Navigation → Main Content bên trái + Sidebar bên phải → Footer.
4. Trên **mobile** (ví dụ 375px): Header → Navigation → Main Content → Sidebar → Footer, không cần kéo ngang.
5. Để kiểm tra responsive, nhấn **F12** → **Ctrl + Shift + M** rồi đổi các kích thước 1440px, 768px, 375px, 320px.

## Link GitHub nộp CodeGym

https://github.com/hatuan13406/code-gym/tree/main/responsive-css-grid-layout
