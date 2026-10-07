-- =========================================================
-- BAI TAP: SMARTFACTORY - CAN BANG READ / WRITE / STORAGE
-- =========================================================

CREATE DATABASE IF NOT EXISTS smartfactory_db;
USE smartfactory_db;

-- Tao lai bang demo de script co the chay doc lap.
-- Tren he thong that, KHONG drop bang dang co du lieu.
DROP TABLE IF EXISTS SensorLogs;

CREATE TABLE SensorLogs (
    log_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    sensor_id INT NOT NULL,
    recorded_at DATETIME NOT NULL,
    temperature DECIMAL(5,2),
    humidity DECIMAL(5,2),
    status VARCHAR(20)
);

-- =========================================================
-- 1. LEGACY FAT COVERING INDEX
-- =========================================================
CREATE INDEX idx_fat_covering
ON SensorLogs(sensor_id, recorded_at, temperature, humidity, status);

-- Kiem tra Index hien co
SHOW INDEX FROM SensorLogs;

-- Do dung luong truoc khi toi uu
SHOW TABLE STATUS LIKE 'SensorLogs';

SELECT
    TABLE_SCHEMA,
    TABLE_NAME,
    ROUND(DATA_LENGTH / 1024 / 1024, 2) AS Data_MB,
    ROUND(INDEX_LENGTH / 1024 / 1024, 2) AS Index_MB,
    ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) AS Total_MB
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'smartfactory_db'
  AND TABLE_NAME = 'SensorLogs';

-- EXPLAIN voi Covering Index
EXPLAIN
SELECT
    temperature,
    humidity,
    status
FROM SensorLogs
WHERE sensor_id = 105
  AND recorded_at >= '2026-06-20 00:00:00';

-- =========================================================
-- 2. LOAI BO FAT INDEX
-- =========================================================
ALTER TABLE SensorLogs
DROP INDEX idx_fat_covering;

-- =========================================================
-- 3. TAO LEAN INDEX CHI GOM CAC COT PHUC VU TIM KIEM
-- =========================================================
CREATE INDEX idx_lean_search
ON SensorLogs(sensor_id, recorded_at);

-- =========================================================
-- 4. KIEM TRA LAI EXECUTION PLAN
-- =========================================================
EXPLAIN
SELECT
    temperature,
    humidity,
    status
FROM SensorLogs
WHERE sensor_id = 105
  AND recorded_at >= '2026-06-20 00:00:00';

-- Ky vong:
-- key   : idx_lean_search
-- type  : range hoac ref, tuy du lieu va thong ke cua Optimizer
-- Extra : khong con "Using index" theo nghia Covering Index.
--         Co the thay "Using index condition" neu MySQL dung ICP.

-- =========================================================
-- 5. DO LAI DUNG LUONG SAU KHI TOI UU
-- =========================================================
SHOW INDEX FROM SensorLogs;

SHOW TABLE STATUS LIKE 'SensorLogs';

SELECT
    TABLE_SCHEMA,
    TABLE_NAME,
    ROUND(DATA_LENGTH / 1024 / 1024, 2) AS Data_MB,
    ROUND(INDEX_LENGTH / 1024 / 1024, 2) AS Index_MB,
    ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) AS Total_MB
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'smartfactory_db'
  AND TABLE_NAME = 'SensorLogs';

-- =========================================================
-- GHI CHU KHI CHAY TREN DU LIEU LON
-- So sanh Index_MB truoc va sau de tinh muc tiet kiem thuc te:
-- Saving_MB = Index_MB_before - Index_MB_after
-- Saving_%  = Saving_MB / Index_MB_before * 100
-- =========================================================
