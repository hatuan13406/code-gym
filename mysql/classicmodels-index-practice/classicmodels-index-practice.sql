USE classicmodels;

-- =========================================================
-- THUC HANH: CHI MUC (INDEX) TRONG MYSQL
-- Bang su dung: customers
-- =========================================================

-- 1. Kiem tra ke hoach thuc thi truoc khi tao Index
EXPLAIN
SELECT *
FROM customers
WHERE customerName = 'Land of Toys Inc.';

-- 2. Tao Index cho cot customerName
ALTER TABLE customers
ADD INDEX idx_customerName (customerName);

-- 3. Kiem tra lai ke hoach thuc thi sau khi tao Index
EXPLAIN
SELECT *
FROM customers
WHERE customerName = 'Land of Toys Inc.';

-- Co the xem danh sach Index hien co cua bang customers
SHOW INDEX FROM customers;

-- =========================================================
-- 4. Tao Composite Index cho contactFirstName va contactLastName
-- =========================================================
ALTER TABLE customers
ADD INDEX idx_full_name (contactFirstName, contactLastName);

-- 5. Kiem tra truy van su dung cot dau tien cua Composite Index
EXPLAIN
SELECT *
FROM customers
WHERE contactFirstName = 'Jean'
   OR contactFirstName = 'King';

-- 6. Kiem tra truy van dung ca hai cot trong Composite Index
EXPLAIN
SELECT *
FROM customers
WHERE contactFirstName = 'Jean'
  AND contactLastName = 'King';

-- 7. Xoa Composite Index
ALTER TABLE customers
DROP INDEX idx_full_name;

-- Kiem tra lai danh sach Index sau khi xoa
SHOW INDEX FROM customers;
