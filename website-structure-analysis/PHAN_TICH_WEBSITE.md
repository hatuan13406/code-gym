# Phân tích và xây dựng cấu trúc Website Template

## 1. Website thực tế được chọn

- **Tên:** MDN Web Docs (Mozilla Developer Network).
- **Trang gốc:** https://developer.mozilla.org/en-US/
- **Mục đích:** Cung cấp tài liệu và hướng dẫn về các công nghệ web (HTML, CSS, JavaScript, Web APIs...).
- **Ngày tham khảo nội dung:** 11/10/2026.
- **Phạm vi phân tích:** cấu trúc nội dung và điều hướng của trang chủ; **không sao chép nguyên giao diện, hình hoặc tài liệu của MDN**.

## 2. Phân tích bốn thành phần chính

| Thành phần | Vai trò | Bố trí quan sát / phân tích |
| --- | --- | --- |
| **Header** | Nhận diện website, giúp người đọc hiểu tên và mục đích của trang. | Khu vực trên cùng có nhận diện MDN và dẫn đến những nhóm tài liệu chính. |
| **Navigation Menu** | Dẫn người dùng tới nội dung cần học. | Hệ thống điều hướng tới HTML, CSS, JavaScript, Web APIs và các khu vực như Learn, Tools, About. |
| **Content Section** | Trình bày nội dung chính của trang chủ. | Vùng giới thiệu tài liệu web, bài viết nổi bật, cập nhật mới và các nội dung dành cho người phát triển web. |
| **Footer** | Thông tin hỗ trợ, các liên kết phụ và bản quyền. | Phía cuối trang chứa những nhóm liên kết như About, Contribute, Developers cùng thông tin bản quyền. |

### Mô tả cách bố trí

Trang MDN tổ chức thông tin theo chiều dọc: điều hướng nằm ở khu vực đầu trang để người đọc chọn chủ đề; tiếp theo là phần nội dung giới thiệu và các nhóm tài liệu/bài viết; cuối trang có footer với các nhóm liên kết hỗ trợ và thông tin bản quyền. Trong bản dựng lại, em giản lược thành **Header → Navbar → Content → Footer** để tập trung học cấu trúc HTML và CSS.

## 3. Phân tích bố cục bản xây dựng

**Header:** Thẻ `<header>` đặt tên LearnWeb và giới thiệu ngắn; bố trí ngang bằng Flexbox.

**Navigation Menu:** Thẻ `<nav>` có **5 mục điều hướng**: Trang chủ, HTML, CSS, JavaScript, Web APIs. Liên kết dẫn đến các `id` thực tế trong trang.

**Content Section:** Thẻ `<main>` gồm:
- Hero: tiêu đề, đoạn giới thiệu và hình **minh họa dựng bằng CSS**, không dùng hình bên ngoài.
- Các chủ đề: dùng CSS Grid tạo 4 thẻ HTML, CSS, JavaScript, Web APIs.
- Khu vực giải thích vai trò của 4 thành phần website.

**Footer:** Thẻ `<footer>` có bản quyền và liên kết tới trang MDN gốc; bố trí thành hai phần trên desktop.

**Responsive:** Grid 4 cột trên desktop, 2 cột tablet và 1 cột điện thoại; phần Hero và Footer cũng tự xếp dọc khi màn hình hẹp.

## 4. Điểm giống và khác

**Giống:** Có nhận diện website, điều hướng theo nhóm công nghệ, vùng nội dung chính chia thành chủ đề và footer.

**Khác:** Bản xây dựng chỉ là **template luyện tập**. Cấu trúc MDN thực tế phong phú và phức tạp hơn, trong khi bài này dùng ít văn bản, màu sắc riêng, thẻ đơn giản và hình CSS để ưu tiên hiểu bố cục. Trang LearnWeb **không liên quan hoặc đại diện cho MDN**.

## 5. Ảnh chụp màn hình website gốc — cần bổ sung

**Ảnh chụp màn hình gốc chưa được tạo**, vì môi trường trình duyệt tự động không truy cập trực tiếp được MDN. Không sử dụng hình minh họa hoặc ảnh dựng lại làm ảnh chụp MDN.

Để đáp ứng yêu cầu nộp bài, học viên mở **https://developer.mozilla.org/en-US/** trong Chrome/Edge, chụp cửa sổ tại thời điểm xem bằng **Win + Shift + S** rồi lưu dưới tên **`screenshots/mdn-original.png`**.

Sau đó có thể tải ảnh này vào thư mục `website-structure-analysis/screenshots/` trên GitHub trước khi nộp bài. Hãy mở trang ở đầu trang sao cho thấy rõ điều hướng và các nhóm nội dung chính.

> Ghi chú: Cấu trúc website gốc có thể được MDN thay đổi theo thời gian; mô tả trên dựa trên nội dung đã truy cập qua nguồn web và không khẳng định ảnh chụp hiện trạng giao diện.

## 6. Cấu trúc file

```text
website-structure-analysis/
├── index.html
├── style.css
├── PHAN_TICH_WEBSITE.md
├── README.md
└── screenshots/
    └── README.md        (hướng dẫn bổ sung mdn-original.png)
```

## 7. Tài liệu tham khảo

Trang chủ MDN Web Docs: https://developer.mozilla.org/en-US/
