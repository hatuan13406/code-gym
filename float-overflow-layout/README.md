# [Bài tập] Quản lý bố cục trang với overflow và float

Bài tập CodeGym về các thuộc tính **`float`**, **`clear`** và **`overflow`**. Trang chạy bằng HTML5 và CSS thuần, không cần cài đặt thư viện.

## Cấu trúc thư mục

```
float-overflow-layout/
├── index.html
├── style.css
└── README.md
```

## Các yêu cầu đã thực hiện

- Trang có tiêu đề chính xác: **“Bố cục trang với float và overflow”**.
- `.container { width: 100%; overflow: hidden; }` giúp khối cha bao trọn hai cột float.
- Cột trái `.left-column { width: 50%; float: left; background-color: lightgray; padding: 20px; }`.
- Cột phải `.right-column { width: 50%; float: right; background-color: lightgreen; padding: 20px; }`.
- Clearfix `.container::after { content: ""; display: block; clear: both; }` giúp các khối tiếp sau không bị chồng lấn.
- `.overflow-box { width: 300px; height: 100px; background-color: lightcoral; padding: 10px; overflow: auto; }`.
- Có văn bản đủ dài để xuất hiện thanh cuộn **bên trong** khối 300 × 100 px.
- `box-sizing: border-box` giúp kích thước 50% của mỗi cột đã tính cả phần padding. Responsive đưa các cột xuống một hàng trên điện thoại.

## Cách chạy

1. Mở thư mục `float-overflow-layout` bằng VS Code hoặc từ GitHub tải về.
2. Mở `index.html` trên Chrome / Edge hoặc sử dụng Live Server.
3. Kiểm tra hai cột nằm cạnh nhau, mỗi cột chiếm 50% chiều rộng và không tràn bố cục.
4. Đưa chuột vào **khối màu hồng** và dùng con lăn hoặc thanh cuộn để đọc hết nội dung.
5. Thu nhỏ trình duyệt xuống dưới 630px để thấy hai cột xếp dọc.

## Link nộp CodeGym

```text
https://github.com/hatuan13406/code-gym/tree/main/float-overflow-layout
```

> Ghi chú: Bố cục hai cột vẫn sử dụng **float**, không dùng Flexbox hay CSS Grid. Flexbox trong CSS chỉ giúp căn các chú thích, nhãn và các phần trang trí.
