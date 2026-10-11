# [Thực hành] CSS | flex-flow Property

Hai ví dụ CodeGym dùng CSS Flexbox:

- **Ví dụ 1:** `flex-flow: row nowrap;` — Item hiển thị theo thứ tự 1, 2, 3 từ trái sang phải.
- **Ví dụ 2:** `flex-flow: row-reverse nowrap;` — Item 1 ở mép phải; nhìn từ trái qua phải thấy 3, 2, 1.

## Cách chạy

Mở `index.html` trong Chrome/Edge hoặc VS Code Live Server. Không cần JavaScript hay thư viện bên ngoài.

## Cấu trúc

```
flex-flow-practice/
├── index.html
├── style.css
└── README.md
```

## Kiến thức chính

`flex-flow` viết tắt cho `flex-direction` và `flex-wrap` và dùng trên Flex Container có `display: flex`.

```css
.container-1 { display: flex; flex-flow: row nowrap; }
.container-2 { display: flex; flex-flow: row-reverse nowrap; }
```

**Link nộp:** https://github.com/hatuan13406/code-gym/tree/main/flex-flow-practice
