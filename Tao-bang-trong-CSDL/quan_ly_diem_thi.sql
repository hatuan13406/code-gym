-- Thực hành: Tạo bảng trong CSDL
-- CSDL: QuanLyDiemThi

CREATE DATABASE QuanLyDiemThi;

USE QuanLyDiemThi;

-- Bảng học sinh
CREATE TABLE HocSinh (
    MaHS VARCHAR(20) PRIMARY KEY,
    TenHS VARCHAR(50),
    NgaySinh DATETIME,
    Lop VARCHAR(20),
    GT VARCHAR(20)
);

-- Bảng giáo viên
CREATE TABLE GiaoVien (
    MaGV VARCHAR(20) PRIMARY KEY,
    TenGV VARCHAR(50),
    SDT VARCHAR(10)
);

-- Bảng môn học
CREATE TABLE MonHoc (
    MaMH VARCHAR(50) PRIMARY KEY,
    TenMH VARCHAR(50),
    MaGV VARCHAR(20),
    CONSTRAINT FK_MonHoc_GiaoVien
        FOREIGN KEY (MaGV) REFERENCES GiaoVien(MaGV)
);

-- Bảng điểm: bảng trung gian cho quan hệ nhiều - nhiều
-- giữa HocSinh và MonHoc
CREATE TABLE BangDiem (
    MaHS VARCHAR(20),
    MaMH VARCHAR(50),
    DiemThi INT,
    NgayKT DATETIME,
    PRIMARY KEY (MaHS, MaMH),
    CONSTRAINT FK_BangDiem_HocSinh
        FOREIGN KEY (MaHS) REFERENCES HocSinh(MaHS),
    CONSTRAINT FK_BangDiem_MonHoc
        FOREIGN KEY (MaMH) REFERENCES MonHoc(MaMH)
);

-- Kiểm tra các bảng đã tạo
SHOW TABLES;

DESCRIBE HocSinh;
DESCRIBE GiaoVien;
DESCRIBE MonHoc;
DESCRIBE BangDiem;
