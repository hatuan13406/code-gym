# [Thực hành] CSS | grid-row Property

Bài thực hành CodeGym: tạo CSS Grid **3 cột × 3 hàng**, gồm 6 ô, thay đổi vị trí và số hàng mà **Ô 1** chiếm bằng `grid-row`.

## Các ví dụ

1. **`grid-row: 1 / 3`**: Ô 1 từ đường kẻ hàng 1 đến đường kẻ hàng 3, chiếm hàng 1 và hàng 2.
2. **`grid-row: 2 / 4`**: Ô 1 từ đường kẻ hàng 2 đến đường kẻ hàng 4, chiếm hàng 2 và hàng 3.
3. **`grid-row: span 2`**: Ô 1 chiếm 2 hàng và được trình duyệt tự động sắp xếp vị trí; với dữ liệu ở đây, Ô 1 nằm ở hàng 1 và 2.

Cấu hình CSS chung:

```css
.grid-container {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    grid-template-rows: repeat(3, 100px);
    gap: 10px;
}
```

## Cách chạy

Mở `index.html` bằng Chrome/Edge hoặc VS Code Live Server. Quan sát màu sắc và vị trí **Ô 1** trong cả 3 ví dụ. Bài không yêu cầu cài thư viện hoặc JavaScript.

## Nộp CodeGym

- Ảnh chụp đã được tạo và cung cấp riêng dưới dạng file `ket-qua-grid-row.png`, kích thước dưới 2 MB.
- Link GitHub: https://github.com/hatuan13406/code-gym/tree/main/grid-row-practice
