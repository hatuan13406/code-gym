# AI Prompt Log - QuickFeed Index Optimization

## 1. Cardinality là gì?

**Prompt:** Cardinality trong Index là gì và tại sao cột Boolean thường là ứng cử viên kém cho B-Tree Index?

**AI trả lời:** Cardinality phản ánh mức độ phân biệt của dữ liệu. Cột có nhiều giá trị khác nhau thường giúp Index lọc mạnh hơn. Boolean chỉ có 2 giá trị nên nếu một giá trị chiếm phần lớn bảng, Optimizer có thể thấy quét bảng rẻ hơn việc đi qua Index rồi quay lại đọc nhiều row.

## 2. Vì sao Index trên TEXT có thể tốn tài nguyên?

**Prompt:** Index B-Tree trên cột TEXT dài gây ảnh hưởng gì tới RAM, Disk và thao tác ghi?

**AI trả lời:** Index phải lưu khóa và con trỏ tới row nên khóa càng lớn thì Index càng chiếm nhiều page trên Disk và Buffer Pool. Khi INSERT/UPDATE/DELETE, MySQL cũng phải cập nhật cấu trúc Index, làm tăng I/O và chi phí bảo trì cây.

## 3. Tại sao MySQL có thể bỏ qua idx_is_visible?

**Prompt:** Nếu 99% bài viết có is_visible = 1, vì sao MySQL có thể chọn Full Table Scan thay vì idx_is_visible?

**AI trả lời:** Vì điều kiện lọc không đủ chọn lọc. Nếu gần như toàn bộ row thỏa mãn điều kiện, dùng Index có thể phát sinh thêm bước tra cứu row mà không giảm đáng kể số dữ liệu phải đọc.

## 4. InnoDB lưu Data Pages và Index Pages như thế nào?

**Prompt:** Hãy giải thích sự khác nhau giữa Data Pages và Index Pages trong InnoDB.

**AI trả lời:** InnoDB tổ chức dữ liệu theo page. Clustered index của Primary Key chứa toàn bộ row và chính là cấu trúc dữ liệu chính. Mỗi secondary index có các page B-Tree riêng, lưu khóa phụ kèm Primary Key để định vị row. Vì vậy nhiều secondary index đồng nghĩa nhiều page bổ sung trên Disk và Buffer Pool.

## 5. Read/Write trade-off

**Prompt:** Tại sao thêm Index có thể tăng tốc SELECT nhưng làm chậm INSERT?

**AI trả lời:** SELECT có thể dùng Index để giảm số row cần đọc. Ngược lại, mỗi INSERT phải ghi thêm entry vào tất cả Index liên quan, có thể gây page split, tăng redo/undo log và nhiều I/O hơn.

## 6. Index Seek và Index Scan

**Prompt:** Index Seek khác Index Scan như thế nào?

**AI trả lời:** Seek đi trực tiếp tới vùng khóa cần thiết trong cây, còn Scan đọc nhiều hoặc toàn bộ entry của Index. Seek có lợi khi điều kiện chọn lọc tốt, còn Scan có thể hợp lý nếu phải đọc phần lớn dữ liệu.

## 7. Tìm kiếm văn bản trong content

**Prompt:** Nếu cần tìm kiếm từ khóa trong cột content kiểu TEXT, nên dùng gì thay cho B-Tree prefix index?

**AI trả lời:** MySQL hỗ trợ FULLTEXT Index cho tìm kiếm từ khóa trong văn bản. FULLTEXT được thiết kế cho truy vấn tìm kiếm nội dung hơn là B-Tree prefix index thông thường.
