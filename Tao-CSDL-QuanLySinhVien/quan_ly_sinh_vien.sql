-- Thực hành: Tạo CSDL quản lý sinh viên

CREATE DATABASE QuanLySinhVien;

USE QuanLySinhVien;

-- Bảng Class
CREATE TABLE Class (
    ClassID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ClassName VARCHAR(60) NOT NULL,
    StartDate DATETIME NOT NULL,
    Status BIT
);

-- Bảng Student
CREATE TABLE Student (
    StudentID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    StudentName VARCHAR(30) NOT NULL,
    Address VARCHAR(50),
    Phone VARCHAR(20),
    Status BIT,
    ClassID INT NOT NULL,
    CONSTRAINT FK_Student_Class
        FOREIGN KEY (ClassID) REFERENCES Class(ClassID)
);

-- Bảng Subject
CREATE TABLE Subject (
    SubID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SubName VARCHAR(30) NOT NULL,
    Credit TINYINT NOT NULL DEFAULT 1,
    Status BIT DEFAULT 1,
    CONSTRAINT CHK_Subject_Credit CHECK (Credit >= 1)
);

-- Bảng Mark
CREATE TABLE Mark (
    MarkID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SubID INT NOT NULL,
    StudentID INT NOT NULL,
    Mark FLOAT DEFAULT 0,
    ExamTimes TINYINT DEFAULT 1,
    CONSTRAINT UQ_Mark_Subject_Student UNIQUE (SubID, StudentID),
    CONSTRAINT CHK_Mark_Score CHECK (Mark BETWEEN 0 AND 100),
    CONSTRAINT FK_Mark_Subject
        FOREIGN KEY (SubID) REFERENCES Subject(SubID),
    CONSTRAINT FK_Mark_Student
        FOREIGN KEY (StudentID) REFERENCES Student(StudentID)
);

-- Kiểm tra kết quả
SHOW TABLES;

DESCRIBE Class;
DESCRIBE Student;
DESCRIBE Subject;
DESCRIBE Mark;
