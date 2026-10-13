# Kiểm tra bảo toàn giao diện

So sánh toàn trang bằng Chromium/Playwright, cùng viewport, nạp trực tiếp HTML và CSS của bản gốc (`original/`) với bản refactor (`index.html` + `css/main.css`).

| Viewport | Chiều cao trang gốc | Chiều cao bản refactor | Tràn ngang | Sai khác pixel |
| --- | ---: | ---: | --- | --- |
| 1440 × 900 | 2387px | 2387px | Không | Không |
| 768 × 900 | 3002px | 3002px | Không | Không |
| 390 × 844 | 3707px | 3707px | Không | Không |

**Phạm vi xác minh:** Bản CSS để xem trước hiện đang có trong repository được bảo toàn nguyên trạng từ source. Đây **chưa phải kết quả Sass CLI**. Vì môi trường không tải được Sass (`EAI_AGAIN`), cần chạy `npm run build` và tự so sánh lại ở ba viewport trên để xác nhận CSS biên dịch thực tế.
