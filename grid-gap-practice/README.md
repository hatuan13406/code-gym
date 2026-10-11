# [Thực hành] CSS | grid-gap Property

Bài thực hành CodeGym gồm **đầy đủ 2 ví dụ** về thuộc tính `grid-gap`.

## Ví dụ 1 — Khoảng cách 20px đều nhau

Grid gồm 2 cột, 4 ô, có 2 hàng. CSS:

```css
.grid-equal {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  grid-gap: 20px;
}
```

Kết quả: **khoảng cách giữa hàng = 20px, giữa cột = 20px**.

## Ví dụ 2 — Khoảng cách hàng và cột khác nhau

Grid gồm 3 cột, 6 ô, có 2 hàng. CSS:

```css
.grid-different {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  grid-gap: 30px 10px;
}
```

Kết quả: **khoảng cách giữa hàng = 30px, giữa cột = 10px**.

> Trong CSS hiện đại, `gap: 30px 10px;` tương đương `grid-gap: 30px 10px;`.

## Chạy bài

Mở file `index.html` trong Chrome/Edge hoặc dùng VS Code Live Server. Không cần JavaScript, thư viện hay kết nối Internet.

## Minh chứng

File `ket-qua-grid-gap.png` chụp từ Chromium và thể hiện cả hai ví dụ. Kiểm tra bằng cách mở DevTools (F12), xem kích thước và khoảng trống các phần tử trong Grid.

## Nộp CodeGym

- Ảnh PNG: `ket-qua-grid-gap.png` (dưới 2 MB).
- Mã nguồn: `index.html`, `style.css`, `README.md`.
- GitHub: https://github.com/hatuan13406/code-gym/tree/main/grid-gap-practice