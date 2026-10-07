-- =========================================================
-- THUC HANH: TRIGGER TRONG MYSQL
-- =========================================================

CREATE DATABASE IF NOT EXISTS company;
USE company;

-- Xoa bang cu de script co the chay lai
DROP TABLE IF EXISTS employees;

-- =========================================================
-- 1. TAO BANG employees
-- =========================================================
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2) NOT NULL
);

-- =========================================================
-- 2. TAO TRIGGER update_department
-- Trigger chay truoc khi INSERT vao employees.
-- Phong ban duoc gan tu dong dua tren muc luong.
-- =========================================================
DELIMITER //

CREATE TRIGGER update_department
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary >= 5000 THEN
        SET NEW.department = 'Management';
    ELSEIF NEW.salary >= 3000 THEN
        SET NEW.department = 'Sales';
    ELSE
        SET NEW.department = 'Support';
    END IF;
END //

DELIMITER ;

-- =========================================================
-- 3. DEMO SU DUNG TRIGGER
-- Gia tri department truyen vao ban dau la 'A',
-- nhung trigger se tu dong thay doi theo salary.
-- =========================================================
INSERT INTO employees (name, department, salary)
VALUES
    ('John Doe', 'A', 3500),
    ('Jane Smith', 'A', 2000),
    ('David Johnson', 'A', 6000);

-- =========================================================
-- 4. KIEM TRA KET QUA
-- Mong doi:
-- John Doe      -> Sales
-- Jane Smith    -> Support
-- David Johnson -> Management
-- =========================================================
SELECT
    id,
    name,
    department,
    salary
FROM employees
ORDER BY id;

-- Xem trigger da duoc tao trong database company
SHOW TRIGGERS;
