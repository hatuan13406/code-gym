-- Bài tập: Xây dựng cơ sở dữ liệu quản lý bán hàng

CREATE DATABASE QuanLyBanHang;

USE QuanLyBanHang;

-- Bảng Customer lưu thông tin khách hàng
CREATE TABLE Customer (
    cID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cName VARCHAR(100) NOT NULL,
    cAge INT
);

-- Bảng Product lưu thông tin sản phẩm
CREATE TABLE Product (
    pID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    pName VARCHAR(100) NOT NULL,
    pPrice DECIMAL(12,2) NOT NULL CHECK (pPrice >= 0)
);

-- Bảng Order lưu thông tin hóa đơn
CREATE TABLE `Order` (
    oID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cID INT NOT NULL,
    oDate DATETIME NOT NULL,
    oTotalPrice DECIMAL(12,2) DEFAULT 0 CHECK (oTotalPrice >= 0),

    CONSTRAINT FK_Order_Customer
        FOREIGN KEY (cID)
        REFERENCES Customer(cID)
);

-- Bảng OrderDetail lưu chi tiết các sản phẩm trong từng hóa đơn
CREATE TABLE OrderDetail (
    oID INT NOT NULL,
    pID INT NOT NULL,
    odQTY INT NOT NULL CHECK (odQTY > 0),

    PRIMARY KEY (oID, pID),

    CONSTRAINT FK_OrderDetail_Order
        FOREIGN KEY (oID)
        REFERENCES `Order`(oID),

    CONSTRAINT FK_OrderDetail_Product
        FOREIGN KEY (pID)
        REFERENCES Product(pID)
);

-- Kiểm tra các bảng đã tạo
SHOW TABLES;

DESCRIBE Customer;
DESCRIBE Product;
DESCRIBE `Order`;
DESCRIBE OrderDetail;
