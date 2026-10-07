USE classicmodels;

-- =========================================================
-- THUC HANH: TRUYEN THAM SO VAO STORED PROCEDURE
-- Cac loai tham so: IN, OUT, INOUT
-- =========================================================

-- Xoa cac procedure neu da ton tai de script co the chay lai
DROP PROCEDURE IF EXISTS getCusById;
DROP PROCEDURE IF EXISTS GetCustomersCountByCity;
DROP PROCEDURE IF EXISTS SetCounter;

-- =========================================================
-- 1. THAM SO IN
-- Tim khach hang theo customerNumber
-- =========================================================
DELIMITER //

CREATE PROCEDURE getCusById(
    IN cusNum INT
)
BEGIN
    SELECT *
    FROM customers
    WHERE customerNumber = cusNum;
END //

DELIMITER ;

-- Goi procedure voi ma khach hang 175
CALL getCusById(175);

-- =========================================================
-- 2. THAM SO OUT
-- Dem so khach hang theo thanh pho va dua ket qua ra ngoai
-- =========================================================
DELIMITER //

CREATE PROCEDURE GetCustomersCountByCity(
    IN in_city VARCHAR(50),
    OUT total INT
)
BEGIN
    SELECT COUNT(customerNumber)
    INTO total
    FROM customers
    WHERE city = in_city;
END //

DELIMITER ;

-- Goi procedure va nhan ket qua qua bien @total
CALL GetCustomersCountByCity('Lyon', @total);

SELECT @total AS TotalCustomers;

-- =========================================================
-- 3. THAM SO INOUT
-- Nhan gia tri counter tu ben ngoai, thay doi trong procedure
-- va tra lai gia tri moi qua chinh bien do
-- =========================================================
DELIMITER //

CREATE PROCEDURE SetCounter(
    INOUT counter INT,
    IN inc INT
)
BEGIN
    SET counter = counter + inc;
END //

DELIMITER ;

-- Khoi tao bien
SET @counter = 1;

-- 1 + 1 = 2
CALL SetCounter(@counter, 1);
SELECT @counter AS CounterAfterFirstCall;

-- 2 + 1 = 3
CALL SetCounter(@counter, 1);
SELECT @counter AS CounterAfterSecondCall;

-- 3 + 5 = 8
CALL SetCounter(@counter, 5);
SELECT @counter AS FinalCounter;

-- =========================================================
-- 4. KIEM TRA CAC PROCEDURE DA TAO
-- =========================================================
SHOW PROCEDURE STATUS
WHERE Db = DATABASE()
  AND Name IN (
      'getCusById',
      'GetCustomersCountByCity',
      'SetCounter'
  );
