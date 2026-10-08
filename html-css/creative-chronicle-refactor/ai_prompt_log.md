# AI Prompt Log - CreativeChronicle

## 1. Float và parent collapse

**Prompt:** Vì sao các phần tử dùng float có thể làm phần tử cha không ôm đủ chiều cao?

**AI:** Float đưa phần tử ra khỏi normal flow theo cách mà phần nội dung không float của parent không còn dùng chiều cao của float để tính layout như bình thường. Vì thế trước đây thường cần clearfix hoặc một kỹ thuật tạo block formatting context như `overflow: hidden`.

## 2. Flexbox cho Author Info

**Prompt:** Tại sao Author Info nên dùng Flexbox thay vì Bootstrap Grid?

**AI:** Author Info chủ yếu là bố cục một chiều, cần avatar, text và nút chia sẻ căn giữa dọc và co giãn theo nội dung. Flexbox trực tiếp cho phép `align-items: center`, `justify-content: space-between`, `gap` và `flex-wrap` với ít markup hơn.

## 3. Grid cho Mosaic Gallery

**Prompt:** Cách dùng CSS Grid để tạo 1 ảnh lớn bên trái chiếm 2 hàng và 2 ảnh nhỏ bên phải là gì?

**AI:** Có thể dùng `grid-template-columns: 2fr 1fr`, hai hàng và đặt ảnh chính `grid-row: span 2`. Hai ảnh còn lại sẽ tự điền vào cột phải theo auto-placement.

## 4. Thêm ảnh mới vào Grid

**Prompt:** Nếu thêm ảnh thứ 4, thứ 5 vào gallery thì Grid có tự tạo hàng mới không?

**AI:** Có. CSS Grid auto-placement sẽ đặt item mới vào ô trống tiếp theo và có thể tạo implicit rows khi cần. Có thể kiểm soát chiều cao hàng mới bằng `grid-auto-rows`.

## 5. Bootstrap breakpoints

**Prompt:** `col-12 col-md-6 col-lg-3` hoạt động như thế nào?

**AI:** Mặc định item chiếm 12/12 cột trên mobile, từ breakpoint md chiếm 6/12 nên được 2 card mỗi hàng, và từ lg chiếm 3/12 nên được 4 card mỗi hàng.

## 6. Bootstrap utility classes

**Prompt:** Những utility nào giúp giảm CSS tự viết trong phần Author và Recommended?

**AI:** Có thể dùng `d-flex`, `align-items-center`, `justify-content-between`, `flex-wrap`, `gap-3`, `mt-3`, `pb-2`, `g-4`, `h-100` và các utility màu/spacing khác. Utility phù hợp giúp HTML ngắn gọn và nhất quán với hệ thống Bootstrap.
