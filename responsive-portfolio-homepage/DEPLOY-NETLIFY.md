# Xuất bản Portfolio với Netlify Drop

## Chuẩn bị
- Website tĩnh trong thư mục `responsive-portfolio-homepage`.
- Điểm vào (entry point) là `index.html` nằm cùng cấp với `style.css`.
- Không cần build, không cần Node.js.

## Cách xuất bản
1. Truy cập https://app.netlify.com/drop
2. Kéo thả thư mục chứa `index.html` và `style.css`, hoặc tải tệp ZIP đã đóng gói từ bài nộp lên.
3. Đợi Netlify deploy; sao chép URL chính thức có đuôi `.netlify.app`.
4. Mở URL đó ở cả điện thoại và máy tính, kiểm tra ảnh từ Picsum Photos (cần Internet).
5. Dán URL `.netlify.app` vào ô **Link** trên CodeGym để nộp bài.

## Checklist
- [x] Source lưu trong GitHub.
- [x] Có `index.html` ở thư mục gốc để host tĩnh.
- [x] CSS mobile-first, responsive ở 768px và 1024px.
- [x] Có ảnh responsive `srcset`/`sizes`.
- [ ] Triển khai Netlify Drop từ tài khoản người nộp.
- [ ] Kiểm tra URL công khai và gửi lên CodeGym.

Không coi URL GitHub là URL website đã xuất bản. Nếu dùng Netlify Drop không đăng nhập, nên đăng nhập hoặc nhận quyền sở hữu site để giữ quyền quản lý và cập nhật.
