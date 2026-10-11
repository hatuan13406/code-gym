# [Bài tập] Tạo layout với RWD

Bài thực hành CodeGym dùng **DIV, HTML5 và CSS thuần** để dựng giao diện Responsive Web Design (RWD), phù hợp với desktop, tablet và mobile.

**Không có ảnh mẫu đi kèm đề bài**, vì vậy layout được xây dựng theo bố cục website thông dụng: header, navbar, hero, sidebar trái, nội dung chính, sidebar phải và footer. Không tuyên bố khớp một ảnh mẫu cụ thể.

## Cấu trúc

```text
rwd-layout/
├── index.html
├── style.css
└── README.md
```

## Cách chạy

1. Clone hoặc tải repo `hatuan13406/code-gym` về máy.
2. Mở thư mục `rwd-layout`.
3. Mở `index.html` bằng Chrome hoặc Edge (hoặc dùng VS Code Live Server).
4. Mở DevTools (phím F12) → bật chế độ thiết bị bằng **Ctrl + Shift + M** và thử thu/phóng giao diện.

Không cần JavaScript, Node.js, framework, API hay tài nguyên ảnh ngoài. Toàn bộ minh hoạ dùng CSS và ký tự.

## Nội dung đã thực hiện

- **Header + menu:** Flexbox, liên kết điều hướng trong trang.
- **Hero:** CSS Grid 2 cột ở desktop, 1 cột trên mobile.
- **Layout chính:** `.layout` dùng CSS Grid 3 cột: `205px minmax(0,1fr) 235px`.
- **Tablet (701–1024px):** Chuyển thành 2 cột; sidebar phải xuống hàng riêng.
- **Mobile (≤700px):** Toàn bộ bố cục còn 1 cột, ưu tiên hiển thị nội dung chính; thanh điều hướng tự sắp xếp xuống hàng kế tiếp.
- **Mobile nhỏ (≤520px/360px):** Các thẻ dịch vụ và số liệu tự đổi thành 1 cột khi cần.
- **An toàn tràn ngang:** Có `box-sizing: border-box`, `minmax(0,1fr)`, `min-width:0`, chiều rộng container co giãn và media queries.
- **Footer:** Bản quyền và nút trở về đầu trang.

## Checklist thủ công

- Desktop khoảng 1440px: header, hero, 3 cột, footer hiển thị hợp lý.
- Tablet khoảng 768px: 2 cột ở vùng nội dung, sidebar phải nằm hàng dưới.
- Mobile khoảng 375px: nội dung xếp dọc, menu vẫn sử dụng được.
- Mobile nhỏ 320px: không có nội dung bị tràn ra ngoài khung nhìn.
- Click các mục menu để kiểm tra liên kết tới phần tương ứng.

## Nộp bài CodeGym

Sao chép link sau:

```text
https://github.com/hatuan13406/code-gym/tree/main/rwd-layout
```
