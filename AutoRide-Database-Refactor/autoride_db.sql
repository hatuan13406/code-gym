-- =========================================================
-- AUTORIDE - TAI CAU TRUC CO SO DU LIEU
-- File: autoride_db.sql
-- =========================================================

DROP DATABASE IF EXISTS autoride_db;
CREATE DATABASE autoride_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE autoride_db;

-- =========================================================
-- 1. LEGACY DATABASE
-- =========================================================

CREATE TABLE Cars (
    car_id INT AUTO_INCREMENT PRIMARY KEY,
    model_name VARCHAR(100) NOT NULL,
    license_plate VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE Rentals (
    rental_id INT AUTO_INCREMENT PRIMARY KEY,
    car_id INT NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    rent_date DATETIME NOT NULL,
    return_date DATETIME NULL,
    status VARCHAR(50) DEFAULT 'BOOKED',

    CONSTRAINT FK_Rentals_Car
        FOREIGN KEY (car_id)
        REFERENCES Cars(car_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- =========================================================
-- 2. NANG CAP BANG RENTALS
-- =========================================================

ALTER TABLE Rentals
    MODIFY COLUMN status ENUM(
        'BOOKED',
        'ACTIVE',
        'COMPLETED',
        'CANCELLED'
    ) NOT NULL DEFAULT 'BOOKED',
    ADD COLUMN security_deposit DECIMAL(12,2) NOT NULL DEFAULT 0 AFTER status,
    ADD COLUMN late_fee DECIMAL(12,2) NOT NULL DEFAULT 0 AFTER security_deposit,
    ADD COLUMN damage_fee DECIMAL(12,2) NOT NULL DEFAULT 0 AFTER late_fee;

ALTER TABLE Rentals
    ADD CONSTRAINT CHK_Rentals_SecurityDeposit
        CHECK (security_deposit >= 0),
    ADD CONSTRAINT CHK_Rentals_LateFee
        CHECK (late_fee >= 0),
    ADD CONSTRAINT CHK_Rentals_DamageFee
        CHECK (damage_fee >= 0),
    ADD CONSTRAINT CHK_Rentals_TotalFee
        CHECK (late_fee + damage_fee <= security_deposit);

-- =========================================================
-- 3. BANG INSPECTIONS
-- Mot hop dong co the co nhieu lan kiem tra theo vong doi.
-- =========================================================

CREATE TABLE Inspections (
    inspection_id INT AUTO_INCREMENT PRIMARY KEY,
    rental_id INT NOT NULL,
    inspection_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    damage_description TEXT NULL,
    inspector_name VARCHAR(100) NOT NULL,

    CONSTRAINT FK_Inspections_Rental
        FOREIGN KEY (rental_id)
        REFERENCES Rentals(rental_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- =========================================================
-- 4. TRIGGER BAO VE NGHIEP VU
-- Khong cho phep lap bien ban kiem tra khi hop dong van BOOKED
-- hoac da CANCELLED.
-- =========================================================

DELIMITER $$

CREATE TRIGGER TRG_Inspections_BeforeInsert
BEFORE INSERT ON Inspections
FOR EACH ROW
BEGIN
    DECLARE rental_status VARCHAR(20);

    SELECT status
    INTO rental_status
    FROM Rentals
    WHERE rental_id = NEW.rental_id;

    IF rental_status IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Hop dong thue xe khong ton tai.';
    END IF;

    IF rental_status IN ('BOOKED', 'CANCELLED') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Chi duoc kiem tra xe khi hop dong dang ACTIVE hoac da COMPLETED.';
    END IF;
END$$

DELIMITER ;

-- =========================================================
-- 5. DU LIEU MAU
-- =========================================================

INSERT INTO Cars (model_name, license_plate) VALUES
('Toyota Vios 2025', '20A-123.45'),
('Honda City 2025', '20A-678.90');

-- =========================================================
-- 6. KICH BAN NGHIEP VU
-- Nguyen Van A thue xe, coc 10.000.000 VND, trang thai ACTIVE.
-- Tra xe va phat hien vo den pha trai.
-- damage_fee = 2.000.000 VND, late_fee = 0.
-- =========================================================

INSERT INTO Rentals (
    car_id,
    customer_name,
    rent_date,
    status,
    security_deposit
)
VALUES (
    1,
    'Nguyen Van A',
    '2026-10-07 08:00:00',
    'ACTIVE',
    10000000.00
);

SET @rental_id = LAST_INSERT_ID();

INSERT INTO Inspections (
    rental_id,
    inspection_date,
    damage_description,
    inspector_name
)
VALUES (
    @rental_id,
    '2026-10-09 16:00:00',
    'Vo den pha trai',
    'Tran Minh Khoa'
);

UPDATE Rentals
SET
    return_date = '2026-10-09 16:00:00',
    status = 'COMPLETED',
    late_fee = 0.00,
    damage_fee = 2000000.00
WHERE rental_id = @rental_id;

-- =========================================================
-- 7. TRUY VAN KIEM THU
-- =========================================================

-- So tien thuc te can hoan lai:
-- security_deposit - late_fee - damage_fee
SELECT
    rental_id,
    customer_name,
    status,
    security_deposit,
    late_fee,
    damage_fee,
    security_deposit
        - COALESCE(late_fee, 0)
        - COALESCE(damage_fee, 0) AS refund_amount
FROM Rentals
WHERE rental_id = @rental_id;

-- Xem hop dong kem bien ban kiem tra
SELECT
    r.rental_id,
    r.customer_name,
    c.model_name,
    c.license_plate,
    r.status,
    i.inspection_date,
    i.damage_description,
    i.inspector_name,
    r.security_deposit,
    r.late_fee,
    r.damage_fee,
    r.security_deposit
        - COALESCE(r.late_fee, 0)
        - COALESCE(r.damage_fee, 0) AS refund_amount
FROM Rentals r
JOIN Cars c ON c.car_id = r.car_id
LEFT JOIN Inspections i ON i.rental_id = r.rental_id
WHERE r.rental_id = @rental_id;

-- =========================================================
-- 8. VI DU KIEM THU TRIGGER
-- Neu bo comment doan duoi, MySQL phai tu choi Inspections
-- cho hop dong BOOKED.
-- =========================================================

-- INSERT INTO Rentals (
--     car_id, customer_name, rent_date, status, security_deposit
-- )
-- VALUES (
--     2, 'Khach Thu', '2026-10-12 08:00:00', 'BOOKED', 5000000.00
-- );
--
-- SET @booked_rental = LAST_INSERT_ID();
--
-- INSERT INTO Inspections (
--     rental_id, damage_description, inspector_name
-- )
-- VALUES (
--     @booked_rental, 'Khong hop le', 'Tester'
-- );
