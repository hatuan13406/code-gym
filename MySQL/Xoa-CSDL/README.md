# Thực hành: Xóa CSDL trên MySQL Workbench

## Mục tiêu
- Luyện tập thao tác xóa cơ sở dữ liệu trong MySQL.
- Biết cách xóa CSDL bằng MySQL Workbench và bằng câu lệnh SQL.

## Cách 1: Xóa bằng MySQL Workbench
1. Mở MySQL Workbench và đăng nhập.
2. Tại **SCHEMAS**, chọn `my_database`.
3. Chuột phải → **Drop Schema...**.
4. Chọn **Drop Now**.
5. Kiểm tra lại danh sách SCHEMAS.

## Cách 2: Xóa bằng câu lệnh SQL

```sql
DROP DATABASE IF EXISTS `my_database`;
SHOW DATABASES;
```

## Kết quả
Nếu `my_database` không còn xuất hiện trong danh sách, việc xóa đã thành công.

## Lưu ý
Khi xóa CSDL, toàn bộ bảng và dữ liệu bên trong sẽ bị xóa. Cần kiểm tra kỹ tên CSDL và sao lưu dữ liệu quan trọng trước khi thực hiện.
