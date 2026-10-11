# [Thực hành] Xây dựng bố cục trang web với CSS Grid

Bài thực hành CodeGym tạo một trang web đầy đủ **Header – Sidebar – Main Content – Footer**, chia vùng bằng **CSS Grid và grid-template-areas**. Giao diện hoạt động với HTML5 và CSS thuần, không cần JavaScript.

## Cấu trúc

```text
css-grid-layout/
├── index.html
├── style.css
└── README.md
```

## Yêu cầu chính

**Trên desktop (>768px):** Sidebar chiếm 1 phần, nội dung chính chiếm 3 phần; Header và Footer trải ngang cả 2 cột.

```css
.container {
    display: grid;
    grid-template-columns: 1fr 3fr;
    grid-template-rows: auto 1fr auto;
    grid-template-areas:
        "header header"
        "sidebar content"
        "footer footer";
    min-height: 100vh;
}
.header { grid-area: header; }
.sidebar { grid-area: sidebar; }
.content { grid-area: content; }
.footer { grid-area: footer; }
```

**Trên mobile (≤768px):** Các vùng chuyển sang một cột theo thứ tự Header → Sidebar → Content → Footer.

```css
@media (max-width: 768px) {
    .container {
        grid-template-columns: 1fr;
        grid-template-rows: auto auto 1fr auto;
        grid-template-areas:
            "header"
            "sidebar"
            "content"
            "footer";
    }
}
```

Ngoài Grid chính, phần nội dung có Hero, thẻ thông tin và khối ví dụ giúp dễ quan sát. Tất cả hình minh họa đều làm bằng CSS, không tải ảnh bên ngoài.

## Chạy và kiểm tra

1. Mở `index.html` bằng Chrome hoặc Edge; có thể dùng **Live Server** trong VS Code.
2. Kiểm tra màn hình Desktop (1440px): Header và Footer ngang toàn trang, Sidebar ở bên trái Main Content.
3. Bật DevTools bằng F12 → Ctrl + Shift + M, đặt chiều rộng 768px, 390px, 320px để quan sát Grid chuyển sang 1 cột và nội dung không bị tràn ngang.
4. Chụp ảnh kết quả để nộp CodeGym.

## GitHub

https://github.com/hatuan13406/code-gym/tree/main/css-grid-layout
