# [Bài tập] Phát triển trang web xem hoạt hình trực tuyến

Website **Hoạt Hình Vui** là bài thực hành xây dựng layout bằng `<div>`, **CSS/Flexbox**, dùng `<iframe>` nhúng phim hoạt hình tiếng Việt và dùng thẻ **`<video>` HTML5** để phát một file MP4/WebM từ thiết bị người xem.

## Cấu trúc

```text
cartoon-video-website/
├── index.html   # Header, Head-link, Left Content, Right Content, Footer
├── style.css    # Layout 2 cột, header fixed, hover, responsive
├── script.js    # Danh sách phim, tìm kiếm, sắp xếp, chọn phim và file video
└── README.md
```

## Chạy bài

1. Tải thư mục về hoặc clone repository `hatuan13406/code-gym`.
2. Mở `cartoon-video-website/index.html` bằng Chrome, Edge hoặc mở qua VS Code Live Server.
3. Đảm bảo có Internet để nhúng video YouTube và tải ảnh thumbnail.
4. Nhấn một phim ở menu bên trái để xem tại khung bên phải (mặc định chọn phim **mới nhất**).
5. Tìm kiếm bằng tên, thay đổi **Mới cập nhật / Nhiều lượt xem nhất / Tên A–Z**, lọc **Gia đình / Học tập / Kỹ năng sống**.
6. Cuộn trang: `header` cố định bằng `position: fixed`, `z-index: 1000`; menu `head-link` bám ngay dưới.
7. Thử thu nhỏ trình duyệt để thấy responsive theo PC → tablet → điện thoại.
8. Nhấn **Video MP4 của bạn**, chọn tệp MP4/WebM **đang có trên thiết bị** để phát bằng `<video controls>`. Tệp không bị tải lên máy chủ. Trình duyệt kiểm tra độ phân giải ngang nằm trong khoảng 1280×720 tới 1920×1080.

Không cần cài Node.js, Bootstrap hoặc thư viện phụ thuộc nào. Chỉ cần HTML + CSS + JavaScript thuần.

## Nguồn phim đã chọn

Các video được **nhúng** từ kênh hoạt hình tiếng Việt trên YouTube. Không sao chép file video, không tự nhận sở hữu hình ảnh / âm thanh. Thông tin ngày đăng và lượt xem là **mẫu tại thời điểm tạo bài**, không kết nối YouTube API và không tự cập nhật.

| Tên phim | Link kênh/video gốc |
|---|---|
| Wolfoo được bố mẹ nhận nuôi - Câu chuyện gia đình | https://www.youtube.com/watch?v=oLcRCi0OQ3g |
| Ngày đầu tiên đi học của Wolfoo | https://www.youtube.com/watch?v=3BzUyQI-dvU |
| Năm mới đầy niềm vui cùng gia đình Wolfoo | https://www.youtube.com/watch?v=R9kvGmhC-L8 |
| Dừng lại, Lucy! Bài học an toàn giao thông | https://www.youtube.com/watch?v=imkr0z9PAhc |

**Lưu ý giới hạn của nhúng YouTube:** Giao diện do bài tập tạo ra **không chứa banner quảng cáo, pop-up quảng cáo hoặc script quảng cáo**. Nhưng YouTube quản lý quảng cáo trong trình phát iframe; website **không thể bảo đảm không quảng cáo** và không thể ép cố định chất lượng 720p/1080p. Video có thể không nhúng được nếu chủ sở hữu thay đổi quyền nhúng, khu vực hoặc xóa video. Có nút **Xem tại kênh gốc** để truy cập nguồn hợp pháp khi gặp sự cố.

Chế độ phát video bằng thẻ `<video>` chạy với file **người dùng tự chọn**; người dùng cần có quyền sử dụng file. Chế độ này không có quảng cáo do website chèn. Nội dung thuyết minh và chất lượng phụ thuộc file người xem đã chọn.

## Những yêu cầu được thực hiện

- **Header:** Logo nằm trái, `position: fixed`, `top:0`, `z-index:1000`. Body có `padding-top` để tránh chồng lấn.
- **Head-link:** Navigation nằm ngay dưới header, bám theo khi cuộn.
- **Left Content:** Các thẻ phim gồm ảnh thu nhỏ, tên, số lượt xem tham khảo, chủ đề; có nút tìm kiếm/lọc/sắp xếp.
- **Right Content:** Video đầu tiên mở mặc định; bấm một phim sẽ thay `iframe.src`, cập nhật mô tả và liên kết nguồn gốc.
- **Video HTML5:** File input kết hợp `URL.createObjectURL`, `<video controls preload="metadata">` và `loadedmetadata`.
- **Footer:** Bản quyền và tuyên bố nguồn video.
- **Responsive:** Flexbox và media queries ở 1150px / 860px / 600px.
- **Trải nghiệm:** Không dùng thư viện CSS/JS; iframe và thumbnails tải lazy; không autoplay khi đổi phim; có trạng thái tìm kiếm trống; UI có nhãn cho người dùng bàn phím.

## Kiểm tra nhanh

1. Vào trang: khung phải phải hiển thị phim đầu tiên và danh sách ở trái.
2. Nhập `Wolfoo` trong ô tìm kiếm: chỉ còn các phim phù hợp.
3. Chọn `Nhiều lượt xem nhất`: phim **Năm mới đầy niềm vui** lên đầu theo số lượt xem mẫu.
4. Chọn chủ đề `Học tập`: còn **Ngày đầu tiên đi học của Wolfoo**.
5. Nhấn phim để chuyển video đang xem và cập nhật tiêu đề.
6. Nhấn `Video MP4 của bạn`, chọn file hợp lệ, thử Play/Pause. Thử file ngoài khoảng HD/FHD để xem cảnh báo.
7. Thu nhỏ xuống <600px: danh sách và trình phát xếp theo một cột, menu ngang vẫn sử dụng được.
8. Cuộn trang xuống và quan sát header giữ nguyên ở trên.

> Mã nguồn phục vụ bài thực hành giao diện, chưa phải nền tảng phát hành nội dung có giấy phép hoặc kiểm duyệt nội dung trẻ em hoàn chỉnh.
