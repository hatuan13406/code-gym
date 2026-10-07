-- =========================================================
-- BAI TAP: PAYFLOW - TOI UU TRUY VAN BANG EXPLAIN VA INDEX
-- =========================================================

CREATE DATABASE IF NOT EXISTS payflow_db;
USE payflow_db;

DROP TABLE IF EXISTS Transactions;

CREATE TABLE Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    amount DECIMAL(15,2),
    transaction_type VARCHAR(20),
    created_at DATETIME
);

-- =========================================================
-- 1. TRUY VAN CU - NON-SARGABLE
-- YEAR() va MONTH() boc quanh created_at khien MySQL
-- khong the tim kiem theo khoang tren B-Tree cua created_at.
-- Khi bang chua co index phu hop, EXPLAIN thuong cho type = ALL.
-- =========================================================
EXPLAIN
SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'DEPOSIT'
  AND YEAR(created_at) = 2026
  AND MONTH(created_at) = 6;

-- =========================================================
-- 2. TAO COMPOSITE INDEX
-- transaction_type dung dieu kien bang (=)
-- created_at dung dieu kien range (>= va <)
-- =========================================================
CREATE INDEX idx_type_date
ON Transactions (transaction_type, created_at);

-- =========================================================
-- 3. TRUY VAN MOI - SARGABLE
-- Khong dung YEAR() / MONTH().
-- Loc truc tiep tren gia tri created_at bang khoang thoi gian.
-- Khoang nua mo [2026-06-01, 2026-07-01) tranh loi gio/phut/giay.
-- =========================================================
EXPLAIN
SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'DEPOSIT'
  AND created_at >= '2026-06-01 00:00:00'
  AND created_at <  '2026-07-01 00:00:00';

-- =========================================================
-- 4. CHAY TRUY VAN TOI UU THAT SU
-- =========================================================
SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'DEPOSIT'
  AND created_at >= '2026-06-01 00:00:00'
  AND created_at <  '2026-07-01 00:00:00';

-- =========================================================
-- 5. TUY CHON: XEM THOI GIAN THUC THI TREN MYSQL HO TRO PROFILING
-- Luu y: SET profiling da bi deprecate o mot so phien ban MySQL moi.
-- Co the dung EXPLAIN ANALYZE tren MySQL 8.0.18+ de xem runtime.
-- =========================================================
EXPLAIN ANALYZE
SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'DEPOSIT'
  AND created_at >= '2026-06-01 00:00:00'
  AND created_at <  '2026-07-01 00:00:00';
