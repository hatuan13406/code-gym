USE QuanLyBanHang;

-- =========================================================
-- 1. THEM DU LIEU VAO 4 BANG
-- =========================================================

-- Customer
INSERT INTO Customer (cID, cName, cAge) VALUES
(1, 'Minh Quan', 10),
(2, 'Ngoc Oanh', 20),
(3, 'Hong Ha', 50);

-- Order
INSERT INTO `Order` (oID, cID, oDate, oTotalPrice) VALUES
(1, 1, '2006-03-21', NULL),
(2, 2, '2006-03-23', NULL),
(3, 1, '2006-03-16', NULL);

-- Product
INSERT INTO Product (pID, pName, pPrice) VALUES
(1, 'May Giat', 3),
(2, 'Tu Lanh', 5),
(3, 'Dieu Hoa', 7),
(4, 'Quat', 1),
(5, 'Bep Dien', 2);

-- OrderDetail
INSERT INTO OrderDetail (oID, pID, odQTY) VALUES
(1, 1, 3),
(1, 3, 7),
(1, 4, 2),
(2, 1, 1),
(3, 1, 8),
(2, 5, 4),
(2, 3, 3);

-- =========================================================
-- 2. HIEN THI oID, oDate, oPrice CUA TAT CA HOA DON
-- oTotalPrice duoc dat bi danh la oPrice de dung ten dau ra cua de bai
-- =========================================================
SELECT
    oID,
    oDate,
    oTotalPrice AS oPrice
FROM `Order`;

-- =========================================================
-- 3. DANH SACH KHACH HANG DA MUA HANG
-- VA SAN PHAM DUOC MUA BOI CAC KHACH HANG
-- =========================================================
SELECT DISTINCT
    c.cID,
    c.cName,
    p.pID,
    p.pName
FROM Customer AS c
JOIN `Order` AS o
    ON c.cID = o.cID
JOIN OrderDetail AS od
    ON o.oID = od.oID
JOIN Product AS p
    ON od.pID = p.pID
ORDER BY
    c.cID,
    p.pID;

-- =========================================================
-- 4. TEN NHUNG KHACH HANG KHONG MUA BAT KY SAN PHAM NAO
-- Dung LEFT JOIN + IS NULL de tim khach hang khong co chi tiet mua hang
-- =========================================================
SELECT
    c.cName
FROM Customer AS c
LEFT JOIN `Order` AS o
    ON c.cID = o.cID
LEFT JOIN OrderDetail AS od
    ON o.oID = od.oID
WHERE od.oID IS NULL;

-- =========================================================
-- 5. MA HOA DON, NGAY BAN VA GIA TIEN CUA TUNG HOA DON
-- Gia hoa don = SUM(odQTY * pPrice)
-- =========================================================
SELECT
    o.oID,
    o.oDate,
    SUM(od.odQTY * p.pPrice) AS oPrice
FROM `Order` AS o
JOIN OrderDetail AS od
    ON o.oID = od.oID
JOIN Product AS p
    ON od.pID = p.pID
GROUP BY
    o.oID,
    o.oDate
ORDER BY o.oID;
