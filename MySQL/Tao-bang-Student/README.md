# Thực hành: Tạo bảng trên MySQL Workbench

## 1. Mục tiêu

- Luyện tập thao tác tạo cơ sở dữ liệu bằng câu lệnh SQL trên MySQL Workbench.
- Luyện tập thao tác tạo bảng trong cơ sở dữ liệu.
- Biết cách chọn cơ sở dữ liệu để làm việc bằng câu lệnh `USE`.

## 2. Yêu cầu bài thực hành

- Tạo một cơ sở dữ liệu mới có tên `demo`.
- Tạo bảng `Student` gồm các trường:
  - `id`
  - `name`
  - `age`
  - `country`

## 3. Câu lệnh SQL

```sql
CREATE DATABASE demo;

USE demo;

CREATE TABLE Student (
    id INT,
    name VARCHAR(200),
    age INT,
    country VARCHAR(50)
);
```

## 4. Các bước thực hiện

1. Mở MySQL Workbench và đăng nhập vào MySQL Server.
2. Mở một cửa sổ truy vấn mới bằng **New Query Tab**.
3. Nhập câu lệnh tạo cơ sở dữ liệu:

```sql
CREATE DATABASE demo;
```

4. Chọn cơ sở dữ liệu `demo` để làm việc:

```sql
USE demo;
```

5. Tạo bảng `Student`:

```sql
CREATE TABLE Student (
    id INT,
    name VARCHAR(200),
    age INT,
    country VARCHAR(50)
);
```

6. Thực thi từng câu lệnh bằng nút **Execute** trên MySQL Workbench.

## 5. Kiểm tra kết quả

Có thể kiểm tra cơ sở dữ liệu đã được tạo bằng:

```sql
SHOW DATABASES;
```

Kiểm tra bảng trong cơ sở dữ liệu `demo`:

```sql
SHOW TABLES;
```

Kiểm tra cấu trúc bảng `Student`:

```sql
DESCRIBE Student;
```

## 6. Kết quả

Sau khi thực hiện thành công:

- Cơ sở dữ liệu `demo` được tạo.
- Bảng `Student` được tạo trong cơ sở dữ liệu `demo`.
- Bảng có 4 trường: `id`, `name`, `age`, `country`.

## 7. Kết luận

Qua bài thực hành, em đã biết cách tạo cơ sở dữ liệu, chọn cơ sở dữ liệu để sử dụng và tạo bảng bằng câu lệnh SQL trên MySQL Workbench.
