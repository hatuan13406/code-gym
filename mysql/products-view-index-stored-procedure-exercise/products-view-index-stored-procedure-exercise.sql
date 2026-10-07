-- =========================================================
-- BAI TAP: VIEW, INDEX, STORED PROCEDURE TRONG MYSQL
-- =========================================================

CREATE DATABASE IF NOT EXISTS product_management_demo;
USE product_management_demo;

-- Xoa cac doi tuong cu neu da ton tai de script co the chay lai
DROP VIEW IF EXISTS product_view;
DROP PROCEDURE IF EXISTS getAllProducts;
DROP PROCEDURE IF EXISTS addProduct;
DROP PROCEDURE IF EXISTS updateProductById;
DROP PROCEDURE IF EXISTS deleteProductById;
DROP TABLE IF EXISTS Products;

-- =========================================================
-- BUOC 1 + 2: TAO BANG PRODUCTS VA DU LIEU MAU
-- =========================================================
CREATE TABLE Products (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    productCode VARCHAR(50) NOT NULL,
    productName VARCHAR(100) NOT NULL,
    productPrice DECIMAL(12,2) NOT NULL,
    productAmount INT NOT NULL,
    productDescription VARCHAR(255),
    productStatus VARCHAR(30) NOT NULL
);

INSERT INTO Products
    (productCode, productName, productPrice, productAmount, productDescription, productStatus)
VALUES
    ('P001', 'Laptop Dell', 15000000, 10, 'Laptop van phong', 'Available'),
    ('P002', 'Logitech Mouse', 350000, 50, 'Chuot khong day', 'Available'),
    ('P003', 'Mechanical Keyboard', 1200000, 25, 'Ban phim co', 'Available'),
    ('P004', 'Samsung Monitor', 4500000, 15, 'Man hinh 24 inch', 'Available'),
    ('P005', 'USB-C Hub', 800000, 30, 'Hub ket noi USB-C', 'Out of stock');

-- =========================================================
-- BUOC 3: INDEX VA EXPLAIN
-- =========================================================

-- EXPLAIN TRUOC KHI TAO INDEX
EXPLAIN
SELECT *
FROM Products
WHERE productCode = 'P003';

EXPLAIN
SELECT *
FROM Products
WHERE productName = 'Laptop Dell'
  AND productPrice = 15000000;

-- Tao Unique Index tren productCode
CREATE UNIQUE INDEX idx_productCode
ON Products(productCode);

-- Tao Composite Index tren productName va productPrice
CREATE INDEX idx_productName_productPrice
ON Products(productName, productPrice);

-- EXPLAIN SAU KHI TAO INDEX
EXPLAIN
SELECT *
FROM Products
WHERE productCode = 'P003';

EXPLAIN
SELECT *
FROM Products
WHERE productName = 'Laptop Dell'
  AND productPrice = 15000000;

-- Kiem tra cac Index da tao
SHOW INDEX FROM Products;

-- =========================================================
-- BUOC 4: VIEW
-- =========================================================

-- Tao view
CREATE VIEW product_view AS
SELECT
    productCode,
    productName,
    productPrice,
    productStatus
FROM Products;

-- Xem du lieu tu view
SELECT *
FROM product_view;

-- Sua doi view
CREATE OR REPLACE VIEW product_view AS
SELECT
    productCode,
    productName,
    productPrice,
    productAmount,
    productStatus
FROM Products
WHERE productStatus = 'Available';

-- Xem lai view sau khi sua
SELECT *
FROM product_view;

-- Xoa view
DROP VIEW product_view;

-- =========================================================
-- BUOC 5: STORED PROCEDURE
-- =========================================================

-- 1. Lay tat ca san pham
DELIMITER //

CREATE PROCEDURE getAllProducts()
BEGIN
    SELECT *
    FROM Products;
END //

DELIMITER ;

-- 2. Them mot san pham moi
DELIMITER //

CREATE PROCEDURE addProduct(
    IN p_productCode VARCHAR(50),
    IN p_productName VARCHAR(100),
    IN p_productPrice DECIMAL(12,2),
    IN p_productAmount INT,
    IN p_productDescription VARCHAR(255),
    IN p_productStatus VARCHAR(30)
)
BEGIN
    INSERT INTO Products
        (productCode, productName, productPrice, productAmount, productDescription, productStatus)
    VALUES
        (p_productCode, p_productName, p_productPrice, p_productAmount, p_productDescription, p_productStatus);
END //

DELIMITER ;

-- 3. Sua thong tin san pham theo Id
DELIMITER //

CREATE PROCEDURE updateProductById(
    IN p_Id INT,
    IN p_productCode VARCHAR(50),
    IN p_productName VARCHAR(100),
    IN p_productPrice DECIMAL(12,2),
    IN p_productAmount INT,
    IN p_productDescription VARCHAR(255),
    IN p_productStatus VARCHAR(30)
)
BEGIN
    UPDATE Products
    SET
        productCode = p_productCode,
        productName = p_productName,
        productPrice = p_productPrice,
        productAmount = p_productAmount,
        productDescription = p_productDescription,
        productStatus = p_productStatus
    WHERE Id = p_Id;
END //

DELIMITER ;

-- 4. Xoa san pham theo Id
DELIMITER //

CREATE PROCEDURE deleteProductById(
    IN p_Id INT
)
BEGIN
    DELETE FROM Products
    WHERE Id = p_Id;
END //

DELIMITER ;

-- =========================================================
-- KIEM THU STORED PROCEDURE
-- =========================================================

CALL getAllProducts();

CALL addProduct(
    'P006',
    'Webcam HD',
    950000,
    20,
    'Webcam hoc va hop truc tuyen',
    'Available'
);

CALL updateProductById(
    6,
    'P006',
    'Webcam Full HD',
    1100000,
    18,
    'Webcam Full HD 1080p',
    'Available'
);

CALL deleteProductById(6);

-- Kiem tra ket qua cuoi cung
CALL getAllProducts();

SHOW PROCEDURE STATUS
WHERE Db = DATABASE()
  AND Name IN (
      'getAllProducts',
      'addProduct',
      'updateProductById',
      'deleteProductById'
  );
