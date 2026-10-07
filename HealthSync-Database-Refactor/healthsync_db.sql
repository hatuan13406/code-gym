-- =========================================================
-- HEALTHSYNC - TAI CAU TRUC CO SO DU LIEU
-- File: healthsync_db.sql
-- =========================================================

DROP DATABASE IF EXISTS healthsync_db;
CREATE DATABASE healthsync_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE healthsync_db;

-- =========================================================
-- 1. LEGACY SCHEMA
-- =========================================================

CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL
);

CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    specialty VARCHAR(50)
);

CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,

    CONSTRAINT FK_Appointments_Patient
        FOREIGN KEY (patient_id)
        REFERENCES Patients(patient_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT FK_Appointments_Doctor
        FOREIGN KEY (doctor_id)
        REFERENCES Doctors(doctor_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- =========================================================
-- 2. SUA BANG APPOINTMENTS DE KHOP NGHIEP VU
-- =========================================================

ALTER TABLE Appointments
    DROP COLUMN is_active,
    ADD COLUMN status ENUM(
        'PENDING',
        'CONFIRMED',
        'CHECKED_IN',
        'COMPLETED',
        'CANCELLED'
    ) NOT NULL DEFAULT 'PENDING' AFTER appointment_date,
    ADD COLUMN deposit_amount DECIMAL(12,2) NOT NULL DEFAULT 0 AFTER status,
    ADD COLUMN penalty_fee DECIMAL(12,2) NOT NULL DEFAULT 0 AFTER deposit_amount,
    ADD COLUMN cancel_reason VARCHAR(255) NULL AFTER penalty_fee;

ALTER TABLE Appointments
    ADD CONSTRAINT CHK_Appointments_Deposit
        CHECK (deposit_amount >= 0),
    ADD CONSTRAINT CHK_Appointments_Penalty
        CHECK (penalty_fee >= 0 AND penalty_fee <= deposit_amount),
    ADD CONSTRAINT CHK_Appointments_CancelReason
        CHECK (
            status <> 'CANCELLED'
            OR cancel_reason IS NOT NULL
        ),
    ADD CONSTRAINT CHK_Appointments_PenaltyStatus
        CHECK (
            status = 'CANCELLED'
            OR penalty_fee = 0
        );

-- =========================================================
-- 3. BANG DON THUOC
-- Quan he 1-1: mot lich hen toi da co mot don thuoc.
-- =========================================================

CREATE TABLE Prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL UNIQUE,
    medication_details TEXT NOT NULL,
    issued_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT FK_Prescriptions_Appointment
        FOREIGN KEY (appointment_id)
        REFERENCES Appointments(appointment_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- =========================================================
-- 4. TRIGGER BAO VE NGHIEP VU
-- Chi cho phep ke don khi lich hen da COMPLETED.
-- =========================================================

DELIMITER $$

CREATE TRIGGER TRG_Prescriptions_BeforeInsert
BEFORE INSERT ON Prescriptions
FOR EACH ROW
BEGIN
    DECLARE appointment_status VARCHAR(20);

    SELECT status
    INTO appointment_status
    FROM Appointments
    WHERE appointment_id = NEW.appointment_id;

    IF appointment_status IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lich hen khong ton tai.';
    END IF;

    IF appointment_status <> 'COMPLETED' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Chi duoc ke don thuoc khi lich hen da COMPLETED.';
    END IF;
END$$

CREATE TRIGGER TRG_Prescriptions_BeforeUpdate
BEFORE UPDATE ON Prescriptions
FOR EACH ROW
BEGIN
    DECLARE appointment_status VARCHAR(20);

    SELECT status
    INTO appointment_status
    FROM Appointments
    WHERE appointment_id = NEW.appointment_id;

    IF appointment_status IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lich hen khong ton tai.';
    END IF;

    IF appointment_status <> 'COMPLETED' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Khong the gan don thuoc cho lich hen chua COMPLETED.';
    END IF;
END$$

DELIMITER ;

-- =========================================================
-- 5. DU LIEU MAU
-- =========================================================

INSERT INTO Patients (full_name, phone) VALUES
('Nguyen Van An', '0901000001'),
('Tran Thi Binh', '0901000002');

INSERT INTO Doctors (full_name, specialty) VALUES
('BS. Le Minh Khoa', 'Noi tong quat'),
('BS. Pham Thu Ha', 'Tim mach');

-- =========================================================
-- 6. KICH BAN 1 - KHAM THANH CONG
-- PENDING -> CONFIRMED -> CHECKED_IN -> COMPLETED
-- Coc: 500.000 dong
-- =========================================================

INSERT INTO Appointments (
    patient_id,
    doctor_id,
    appointment_date,
    status,
    deposit_amount
)
VALUES (
    1,
    1,
    '2026-10-10 09:00:00',
    'PENDING',
    500000.00
);

SET @appointment_success = LAST_INSERT_ID();

UPDATE Appointments
SET status = 'CONFIRMED'
WHERE appointment_id = @appointment_success;

UPDATE Appointments
SET status = 'CHECKED_IN'
WHERE appointment_id = @appointment_success;

UPDATE Appointments
SET status = 'COMPLETED'
WHERE appointment_id = @appointment_success;

INSERT INTO Prescriptions (
    appointment_id,
    medication_details,
    issued_date
)
VALUES (
    @appointment_success,
    'Paracetamol 500mg: 1 vien/lần, 2 lan/ngay sau an; uong trong 3 ngay.',
    '2026-10-10 10:00:00'
);

-- =========================================================
-- 7. KICH BAN 2 - HUY LICH VA PHAT TIEN COC
-- CONFIRMED -> CANCELLED
-- Coc: 300.000 dong
-- Phat: 150.000 dong
-- =========================================================

INSERT INTO Appointments (
    patient_id,
    doctor_id,
    appointment_date,
    status,
    deposit_amount
)
VALUES (
    2,
    2,
    '2026-10-11 14:00:00',
    'CONFIRMED',
    300000.00
);

SET @appointment_cancelled = LAST_INSERT_ID();

UPDATE Appointments
SET
    status = 'CANCELLED',
    cancel_reason = 'Ban viec dot xuat',
    penalty_fee = 150000.00
WHERE appointment_id = @appointment_cancelled;

-- =========================================================
-- 8. TRUY VAN KIEM THU
-- =========================================================

-- Kiem tra toan bo lich hen, tien coc va tien phat
SELECT
    a.appointment_id,
    p.full_name AS patient_name,
    d.full_name AS doctor_name,
    a.appointment_date,
    a.status,
    a.deposit_amount,
    a.penalty_fee,
    a.cancel_reason,
    (a.deposit_amount - a.penalty_fee) AS refundable_amount
FROM Appointments a
JOIN Patients p ON p.patient_id = a.patient_id
JOIN Doctors d ON d.doctor_id = a.doctor_id
ORDER BY a.appointment_id;

-- Danh sach lich hen da hoan tat va chi tiet don thuoc
SELECT
    a.appointment_id,
    p.full_name AS patient_name,
    d.full_name AS doctor_name,
    a.status,
    pr.prescription_id,
    pr.medication_details,
    pr.issued_date
FROM Appointments a
JOIN Patients p ON p.patient_id = a.patient_id
JOIN Doctors d ON d.doctor_id = a.doctor_id
JOIN Prescriptions pr ON pr.appointment_id = a.appointment_id
WHERE a.status = 'COMPLETED'
ORDER BY pr.issued_date;

-- Doi soat cac lich bi huy va khoan tien phat
SELECT
    a.appointment_id,
    p.full_name AS patient_name,
    a.deposit_amount,
    a.penalty_fee,
    a.cancel_reason,
    (a.deposit_amount - a.penalty_fee) AS refundable_amount
FROM Appointments a
JOIN Patients p ON p.patient_id = a.patient_id
WHERE a.status = 'CANCELLED';

-- =========================================================
-- 9. VI DU KIEM THU TRIGGER
-- Neu bo comment lenh duoi, MySQL phai tu choi neu lich hen chua COMPLETED.
-- =========================================================

-- INSERT INTO Prescriptions (appointment_id, medication_details)
-- VALUES (@appointment_cancelled, 'Thuoc thu nghiem');
