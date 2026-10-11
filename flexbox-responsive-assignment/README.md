# [Bài tập] Tạo bố cục responsive bằng CSS Flexbox

Bài tập CodeGym sử dụng HTML5 và CSS Flexbox để xây dựng website gồm **Header**, **Navigation**, **Main Content**, **Sidebar**, **Footer**. Trên desktop Main Content và Sidebar xếp ngang, trên mobile xếp dọc.

Đây là **bài tập riêng** với thư mục `responsive-flexbox-layout/` của bài thực hành trước.

## Cấu trúc

```text
flexbox-responsive-assignment/
├── index.html
├── style.css
└── README.md
```

## CSS chính

```css
.container { display: flex; flex-direction: column; min-height: 100vh; }
.main-container { display: flex; flex: 1; }
.content { flex: 3 1 0; }
.sidebar { flex: 1 1 0; }

@media (max-width: 768px) {
    .main-container { flex-direction: column; }
    .content, .sidebar { flex: 0 1 auto; width: 100%; }
}
```

Sử dụng `flex-wrap: wrap` trên menu và các thẻ giới thiệu để nội dung tự chuyển dòng khi thiếu không gian.

## Cách chạy / kiểm tra

1. Mở `index.html` trong Chrome/Edge hoặc sử dụng VS Code Live Server.
2. Ở chiều rộng desktop 1280px, quan sát Main Content và Sidebar nằm cạnh nhau theo tỷ lệ 3:1.
3. Bật DevTools (F12 → Ctrl + Shift + M), thử độ rộng 768px, 375px và 320px.
4. Trên điện thoại, Main Content và Sidebar sẽ nằm dọc; các liên kết trong menu có thể nhấn để cuộn đến vị trí liên quan.
5. Không cần JavaScript, Node hay tải hình ảnh từ Internet.

## Link nộp CodeGym

https://github.com/hatuan13406/code-gym/tree/main/flexbox-responsive-assignment
