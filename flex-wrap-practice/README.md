# [Thực hành] CSS | flex-wrap property

Bài thực hành CodeGym về thuộc tính `flex-wrap` bằng HTML, CSS và JavaScript đơn giản để đổi ví dụ trực tiếp.

## Nội dung đã làm

- **`flex-wrap: nowrap`**: các phần tử nằm cùng một dòng, được phép thu hẹp nhờ `flex-shrink`.
- **`flex-wrap: wrap`**: các phần tử tự động xuống dòng khi không đủ chỗ.
- **`flex-wrap: wrap-reverse`**: các dòng xếp theo hướng ngược lại; thứ tự item trong mỗi dòng không bị đảo.
- **`flex-wrap: initial`**: trả về giá trị mặc định `nowrap`.
- **Ví dụ tổng hợp**: container rộng `600px`, cao `300px`, 6 item rộng `180px`, cao `80px`, `gap: 10px`. Nhấn nút chọn 4 giá trị để xem kết quả thay đổi.

## Tệp nguồn

```text
flex-wrap-practice/
├── index.html
├── style.css
├── script.js
└── README.md
```

## Cách chạy

1. Mở `index.html` trên Chrome/Edge hoặc chạy qua VS Code Live Server.
2. Xem 4 ví dụ có sẵn ở phần **So sánh trực quan**.
3. Ở phần **Thử thay đổi trực tiếp**, nhấn lần lượt `nowrap`, `wrap`, `wrap-reverse`, `initial`.
4. Chụp ảnh giao diện để nộp CodeGym; có thể sử dụng tệp `ket-qua-flex-wrap.png` nếu được cung cấp cùng bài.

Lưu ý: Khi chiều rộng không đủ, các ô của `nowrap`/`initial` ở màn hình nhỏ có thể cuộn ngang **bên trong khung demo** nhằm không làm toàn trang bị tràn.

## GitHub

https://github.com/hatuan13406/code-gym/tree/main/flex-wrap-practice
