# [Thực hành] CSS | flex-basis Property

Bài thực hành CodeGym gồm **4 ví dụ bắt buộc** và **1 ví dụ mở rộng** về các từ khóa `auto`, `initial`, `inherit`. Thiết kế bằng **HTML và CSS**, không dùng JavaScript hoặc thư viện ngoài.

## Các ví dụ

| Ví dụ | Thuộc tính | Kết quả cần quan sát |
|---|---|---|
| 1. Đơn vị px | 200px, 100px, 150px | 3 ô có cơ sở khác nhau theo chiều ngang |
| 2. Trục column | `flex-direction: column; flex-basis: 100px` | Mỗi ô cao 100px |
| 3. Phần trăm | `flex-basis: 50%` | Hai ô có cơ sở 50% container; co lại để dành chỗ cho gap 10px |
| 4. Kết hợp grow | `flex-basis: 100px`, `flex-grow: 1 2 1` | Không gian thừa được chia theo tỉ lệ 1:2:1 |
| 5. Từ khóa | `auto`, `initial`, `inherit` | Ô 1 và 2 có cơ sở 140px; ô 3 kế thừa cơ sở 180px từ cha |

**Lưu ý:** `flex-basis` là **kích thước cơ sở ban đầu**, không đồng nghĩa với kích thước cuối cùng nếu `flex-grow` hoặc `flex-shrink` thay đổi kích thước. Demo 1 và 2 dùng `flex-shrink: 0` để thấy chính xác các kích thước theo đề. Demo 4 dùng container rộng 600px, mỗi ô có basis 100px và gap 10px nên 280px dư được chia 70/140/70px, cho chiều rộng cuối cùng 170/240/170px.

## Cấu trúc

```text
flex-basis-practice/
├── index.html
├── style.css
├── README.md
└── ket-qua-flex-basis.png  (ảnh chụp khi nộp bài)
```

## Hướng dẫn chạy

1. Mở `index.html` trong Chrome hoặc Edge, hoặc bằng VS Code Live Server.
2. Quan sát đủ 5 ví dụ trong cùng trang.
3. Dùng F12 → Ctrl + Shift + M để thử các chiều rộng 1280px, 768px, 390px, 320px.
4. Chụp kết quả để nộp CodeGym. Mã nguồn và ảnh chụp có thể được nộp kèm GitHub.

## Link GitHub

https://github.com/hatuan13406/code-gym/tree/main/flex-basis-practice