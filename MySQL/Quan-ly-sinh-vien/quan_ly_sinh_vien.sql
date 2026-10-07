-- Bài tập: Xây dựng cơ sở dữ liệu quản lý sinh viên

-- Sử dụng cơ sở dữ liệu đã tạo ở bài trước
USE `student-management`;

-- Tạo bảng Class
CREATE TABLE Class (
    id INT,
    name VARCHAR(200)
);

-- Tạo bảng Teacher
CREATE TABLE Teacher (
    id INT,
    name VARCHAR(200),
    age INT,
    country VARCHAR(50)
);

-- Kiểm tra kết quả
SHOW TABLES;
DESCRIBE Class;
DESCRIBE Teacher;
