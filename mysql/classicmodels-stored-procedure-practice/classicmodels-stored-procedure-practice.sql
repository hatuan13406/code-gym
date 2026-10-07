USE classicmodels;

-- =========================================================
-- THUC HANH: STORED PROCEDURE TRONG MYSQL
-- Bang su dung: customers
-- =========================================================

-- Xoa procedure neu da ton tai de co the chay lai script
DROP PROCEDURE IF EXISTS findAllCustomers;

-- =========================================================
-- 1. Tao Stored Procedure dau tien
-- Procedure tra ve tat ca khach hang
-- =========================================================
DELIMITER //

CREATE PROCEDURE findAllCustomers()
BEGIN
    SELECT *
    FROM customers;
END //

DELIMITER ;

-- Goi Stored Procedure
CALL findAllCustomers();

-- =========================================================
-- 2. Sua Stored Procedure
-- MySQL khong sua truc tiep phan than procedure,
-- vi vay xoa procedure cu va tao lai.
-- =========================================================
DELIMITER //

DROP PROCEDURE IF EXISTS findAllCustomers//

CREATE PROCEDURE findAllCustomers()
BEGIN
    SELECT *
    FROM customers
    WHERE customerNumber = 175;
END //

DELIMITER ;

-- Goi lai procedure sau khi tao moi
CALL findAllCustomers();

-- Xem thong tin procedure trong database hien tai
SHOW PROCEDURE STATUS
WHERE Db = DATABASE()
  AND Name = 'findAllCustomers';
