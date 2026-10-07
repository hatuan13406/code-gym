-- Thực hành: Tạo bảng trên MySQL Workbench

-- Tạo cơ sở dữ liệu
CREATE DATABASE demo;

-- Chọn cơ sở dữ liệu để sử dụng
USE demo;

-- Tạo bảng Student
CREATE TABLE Student (
    id INT,
    name VARCHAR(200),
    age INT,
    country VARCHAR(50)
);

-- Kiểm tra kết quả
SHOW TABLES;
DESCRIBE Student;
