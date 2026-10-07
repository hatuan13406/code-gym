-- =========================================================
-- THUC HANH: QUICKFEED - TOI UU HOA INDEX
-- =========================================================

CREATE DATABASE IF NOT EXISTS quickfeed_db;
USE quickfeed_db;

-- Legacy table (chi tao neu chua ton tai)
CREATE TABLE IF NOT EXISTS Posts (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    content TEXT,
    post_type VARCHAR(10),
    is_visible BOOLEAN DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- =========================================================
-- 1. KIEM TRA CAC INDEX HIEN CO
-- =========================================================
SHOW INDEX FROM Posts;

-- =========================================================
-- 2. DO DUNG LUONG TRUOC KHI TOI UU
-- =========================================================
SHOW TABLE STATUS LIKE 'Posts';

SELECT
    TABLE_SCHEMA,
    TABLE_NAME,
    ROUND(DATA_LENGTH / 1024 / 1024, 2) AS Data_MB,
    ROUND(INDEX_LENGTH / 1024 / 1024, 2) AS Index_MB,
    ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) AS Total_MB
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'quickfeed_db'
  AND TABLE_NAME = 'Posts';

-- =========================================================
-- 3. DROP 3 INDEX DU THUA
-- idx_content     : prefix B-Tree tren TEXT ton dung luong lon
-- idx_post_type   : cardinality thap, chi khoang 3 gia tri
-- idx_is_visible  : cardinality rat thap, chi 0/1
-- =========================================================
ALTER TABLE Posts
    DROP INDEX idx_content,
    DROP INDEX idx_post_type,
    DROP INDEX idx_is_visible;

-- =========================================================
-- 4. GIU LAI CAC INDEX CO GIA TRI
-- idx_user_id     : phuc vu truy van bai viet theo user
-- idx_created_at  : phuc vu sap xep/loc theo thoi gian
-- =========================================================
SHOW INDEX FROM Posts;

-- =========================================================
-- 5. DO LAI DUNG LUONG SAU KHI TOI UU
-- =========================================================
SHOW TABLE STATUS LIKE 'Posts';

SELECT
    TABLE_SCHEMA,
    TABLE_NAME,
    ROUND(DATA_LENGTH / 1024 / 1024, 2) AS Data_MB,
    ROUND(INDEX_LENGTH / 1024 / 1024, 2) AS Index_MB,
    ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) AS Total_MB
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'quickfeed_db'
  AND TABLE_NAME = 'Posts';

-- =========================================================
-- 6. TUY CHON: neu can tim kiem tu khoa trong content
-- co the dung FULLTEXT thay vi B-Tree prefix index thong thuong.
-- Chi chay neu bai tap/phan ban MySQL cua ban cho phep:
-- CREATE FULLTEXT INDEX ft_content ON Posts(content);
-- =========================================================
