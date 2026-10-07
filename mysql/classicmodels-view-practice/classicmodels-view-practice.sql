USE classicmodels;

-- =========================================================
-- THUC HANH: VIEW TRONG MYSQL
-- Bang su dung: customers
-- =========================================================

-- Xoa view neu da ton tai de script co the chay lai
DROP VIEW IF EXISTS customer_views;

-- =========================================================
-- 1. TAO VIEW customer_views
-- Lay customerNumber, customerName, phone tu bang customers
-- =========================================================
CREATE VIEW customer_views AS
SELECT
    customerNumber,
    customerName,
    phone
FROM customers;

-- Xem du lieu tu view
SELECT *
FROM customer_views;

-- =========================================================
-- 2. CAP NHAT VIEW BANG CREATE OR REPLACE VIEW
-- Lay them contactFirstName, contactLastName
-- va chi hien thi khach hang o Nantes
-- =========================================================
CREATE OR REPLACE VIEW customer_views AS
SELECT
    customerNumber,
    customerName,
    contactFirstName,
    contactLastName,
    phone
FROM customers
WHERE city = 'Nantes';

-- Xem lai du lieu sau khi cap nhat view
SELECT *
FROM customer_views;

-- =========================================================
-- 3. XOA VIEW
-- =========================================================
DROP VIEW customer_views;

-- Kiem tra danh sach view trong database hien tai
SHOW FULL TABLES
WHERE Table_type = 'VIEW';
