# [Thực hành] Tạo Navbar với Bootstrap

Bài tập CodeGym làm thanh điều hướng **Bootstrap 5.3.0** có menu, dropdown và responsive trên mobile.

## Các yêu cầu đã làm

- `navbar navbar-expand-lg navbar-dark bg-dark` tạo thanh điều hướng.
- `navbar-brand` hiển thị tên thương hiệu MyWebsite.
- `navbar-nav` gồm **Home**, **About**, **Services** (dropdown: **Web Design**, **SEO**) và **Contact**.
- `navbar-toggler` + `collapse navbar-collapse` cho phép thu gọn / mở menu trên điện thoại.
- `bootstrap.bundle.min.js` bao gồm Popper để dropdown hoạt động.
- Các mục menu được liên kết đến các phần nội dung thật trên trang (không chỉ dùng `href="#"`).
- `style.css` bổ sung giao diện, không thay thế Bootstrap.

## Cấu trúc thư mục

```text
bootstrap-navbar-practice/
├── index.html
├── style.css
└── README.md
```

## Chạy và kiểm tra

1. Mở `index.html` trong Chrome/Edge hoặc VS Code Live Server.
2. **Cần có Internet** vì CSS và JS Bootstrap được lấy từ CDN jsDelivr.
3. Trên desktop (>=992px): menu nằm ngang, bấm **Services** để kiểm tra dropdown Web Design và SEO.
4. Trên mobile (<992px): nhấn nút ☰ để mở/đóng menu và nhấn **Services** để mở danh sách con.
5. Nhấn Home/About/Contact và các mục dịch vụ để thử cuộn tới đúng nội dung.

## Link nộp CodeGym

https://github.com/hatuan13406/code-gym/tree/main/bootstrap-navbar-practice
