# [Thực hành] CSS | flex-grow Property

Bài thực hành CodeGym mô tả cách **Flex Item thứ 2 mở rộng** so với 4 Item còn lại trong cùng một Flex Container.

## Cấu trúc mã nguồn

```text
flex-grow-practice/
├── index.html
├── style.css
└── README.md
```

## Yêu cầu đã thực hiện

- Tạo **5 thẻ `div`** bên trong một Flex Container dùng `display: flex`.
- Hàng **Trước**: tất cả item có `flex-grow: 0` và kích thước cơ sở 120px.
- Hàng **Sau**: chỉ Item thứ hai có `flex-grow: 1`; phần không gian còn lại được Item này sử dụng.
- Không dùng JavaScript hoặc thư viện ngoài. Có chú thích mã nguồn và thiết kế phù hợp cả desktop/mobile.

```css
.flex-container {
    display: flex;
    flex-wrap: nowrap;
    gap: 12px;
}

.item { flex: 0 0 120px; }

.flex-expanded .item:nth-child(2) {
    flex-grow: 1;
}
```

**Lưu ý:** Mỗi Item phải là con trực tiếp của Flex Container. Trên điện thoại, vùng chứa ví dụ cho phép cuộn ngang **bên trong ví dụ** để giữ nguyên chiều rộng cơ sở 120px của 5 Item, tránh biến dạng số đo; toàn trang không cuộn ngang.

## Chạy bài

1. Mở file `index.html` bằng Chrome/Edge hoặc Live Server trong VS Code.
2. So sánh độ rộng **Ô 2** giữa hàng Trước và Sau.
3. Có thể dùng **F12 → Inspect** để xem giá trị `flex-grow` tính toán của từng Item.
4. Chụp ảnh kết quả hiển thị và nộp ảnh cùng link GitHub.

## Link nộp CodeGym

https://github.com/hatuan13406/code-gym/tree/main/flex-grow-practice
