# [Thực hành] CSS | grid-row-gap Property

Bài thực hành CodeGym về thuộc tính grid-row-gap. Bài gồm **6 minh hoạ**, bao phủ đủ ba nhóm: length, %, và các giá trị toàn cục initial, inherit, unset, revert.

## Cấu trúc

- index.html
- style.css
- README.md
- Ảnh kết quả ket-qua-grid-row-gap.png (tải từ cuộc trò chuyện).

## Nội dung

1. Length: .length-demo { grid-row-gap: 20px; }. Hai cột, 4 ô màu xanh dương.
2. Percentage: .percent-demo { grid-row-gap: 5%; height: 400px; }. Trong Grid cao 400px, khoảng cách giữa hai hàng là 20px.
3. Global values (cha có row-gap: 28px):
   - initial: normal, khoảng cách thực tế 0px trong CSS Grid.
   - inherit: kế thừa 28px từ cha.
   - unset: trở về normal (0px), do row-gap không tự kế thừa.
   - revert: hoàn nguyên theo tầng cascade, trong ví dụ về normal (0px).

grid-row-gap là tên cũ của row-gap. Bài giữ tên cũ theo đề CodeGym.

## Chạy

Mở index.html bằng Chrome hoặc Edge. Trang dùng HTML/CSS thuần và không cần Internet.

## Nộp bài

Tải ảnh PNG từ cuộc trò chuyện để nộp CodeGym (dưới 2 MB).

Link mã nguồn:
https://github.com/hatuan13406/code-gym/tree/main/grid-row-gap-practice
