# [Bài tập] Thiết kế Trang Web với Bootstrap Grid System

Bài tập CodeGym tạo trang web có **Header**, **Bootstrap Navbar (có Dropdown)**, **Main Content**, **Sidebar** và **Footer**, với bố cục responsive nhờ **Bootstrap 5.3.0 Grid System**.

## Cấu trúc

```
bootstrap-grid-system-layout/
├── index.html
├── style.css
└── README.md
```

## Bootstrap Container và Grid

Bố cục chính dùng:

```html
<div class="container">
  <div class="row g-4">
    <div class="col-12 col-lg-8">Main Content</div>
    <aside class="col-12 col-lg-4">Sidebar</aside>
  </div>
</div>
```

- **Desktop ≥992px:** Main Content chiếm **8/12**, Sidebar **4/12**; hiển thị cùng một hàng.
- **Mobile <992px:** Cả hai thành **col-12**, Sidebar chuyển xuống dưới Main Content.

**Lưu ý về đề bài:** Đề có nhắc `col-md-8` và `col-md-4`, nhưng các lớp này áp dụng từ 768px. Để tuân thủ mốc desktop **992px**, bài dùng chính xác `col-lg-8` / `col-lg-4`. Đề cũng ghi Sidebar 'chỉ xuất hiện trên màn hình lớn' nhưng yêu cầu cụ thể lại bảo Sidebar nằm dưới nội dung chính trên mobile; bài ưu tiên hiển thị Sidebar ở dưới trên mobile.

## Navbar / Dropdown

Navbar dùng `navbar-expand-lg`, nút Hamburger với `data-bs-toggle="collapse"`, và dropdown với `data-bs-toggle="dropdown"`. Bootstrap JS Bundle cung cấp các chức năng tương tác.

## Chạy thử

1. Mở `index.html` trong Chrome/Edge hoặc dùng Live Server của VS Code.
2. **Cần Internet** để tải Bootstrap 5.3 từ jsDelivr CDN.
3. Ở desktop (1440px hay 992px) xem hai cột Main Content (8) và Sidebar (4).
4. Nhấn F12 → Ctrl + Shift + M để thử kích thước 768px, 375px, 320px: các cột xếp dọc, Sidebar ở dưới.
5. Nhấn menu **Chủ đề** để kiểm tra Dropdown và thu nhỏ cửa sổ để dùng nút Hamburger.

## Link nộp CodeGym

https://github.com/hatuan13406/code-gym/tree/main/bootstrap-grid-system-layout
