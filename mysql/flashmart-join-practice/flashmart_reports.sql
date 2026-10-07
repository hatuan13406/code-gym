-- =========================================================
-- THUC HANH: FLASHMART - INNER JOIN, LEFT JOIN VA ANTI-JOIN
-- =========================================================

CREATE DATABASE IF NOT EXISTS flashmart_db;
USE flashmart_db;

-- Xoa bang theo thu tu de script co the chay lai nhieu lan
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customers;

-- 1. Tao bang
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    CONSTRAINT fk_orders_customer
        FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    CONSTRAINT fk_orders_product
        FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Index ho tro cac phep JOIN tren bang Orders
CREATE INDEX idx_orders_customer_id ON Orders(customer_id);
CREATE INDEX idx_orders_product_id ON Orders(product_id);

-- 2. Du lieu mau
INSERT INTO Customers (customer_id, name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie');

INSERT INTO Products (product_id, product_name) VALUES
(101, 'Laptop'),
(102, 'Mouse'),
(103, 'Keyboard');

INSERT INTO Orders (order_id, customer_id, product_id) VALUES
(1001, 1, 101),
(1002, 1, 102),
(1003, 2, 101);

-- =========================================================
-- BAO CAO 1: MARKETING
-- Lay tat ca khach hang va so don hang cua tung nguoi.
-- LEFT JOIN giu lai ca khach hang chua tung mua hang.
-- COUNT(o.order_id) bo qua NULL nen Charlie co total_orders = 0.
-- Ket qua mong doi:
-- Alice   2
-- Bob     1
-- Charlie 0
-- =========================================================
SELECT
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS total_orders
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.name
ORDER BY c.customer_id;

-- =========================================================
-- BAO CAO 2: KHO VAN
-- Anti-Join: tim san pham chua tung xuat hien trong Orders.
-- LEFT JOIN giu tat ca Products; cac san pham khong co giao dich
-- se co cot ben Orders la NULL.
-- Ket qua mong doi:
-- 103 | Keyboard
-- =========================================================
SELECT
    p.product_id,
    p.product_name
FROM Products AS p
LEFT JOIN Orders AS o
    ON p.product_id = o.product_id
WHERE o.order_id IS NULL
ORDER BY p.product_id;
