CREATE DATABASE IF NOT EXISTS demo;
USE demo;

CREATE TABLE IF NOT EXISTS users (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(120) NOT NULL,
    email VARCHAR(220) NOT NULL,
    country VARCHAR(120)
) ENGINE=InnoDB;

INSERT INTO users(name, email, country)
SELECT 'Minh', 'minh@codegym.vn', 'Viet Nam'
WHERE NOT EXISTS (SELECT 1 FROM users WHERE email = 'minh@codegym.vn');
INSERT INTO users(name, email, country)
SELECT 'Kante', 'kante@che.uk', 'Kenia'
WHERE NOT EXISTS (SELECT 1 FROM users WHERE email = 'kante@che.uk');

-- Stored Procedures for the CallableStatement practice.
-- Run this whole script in MySQL Workbench (including DELIMITER directives).
-- The definitions can be safely reapplied without dropping user data.
DELIMITER $$

DROP PROCEDURE IF EXISTS get_user_by_id $$
CREATE PROCEDURE get_user_by_id(IN user_id INT)
BEGIN
    SELECT users.name, users.email, users.country
    FROM users
    WHERE users.id = user_id;
END $$

DROP PROCEDURE IF EXISTS insert_user $$
CREATE PROCEDURE insert_user(
    IN user_name VARCHAR(120),
    IN user_email VARCHAR(220),
    IN user_country VARCHAR(120)
)
BEGIN
    INSERT INTO users(name, email, country)
    VALUES (user_name, user_email, user_country);
END $$

DELIMITER ;

-- JDBC Transaction practice: user permissions and their join table.
-- InnoDB foreign keys guarantee that invalid permission assignments fail.
CREATE TABLE IF NOT EXISTS permission (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS user_permission (
    user_id INT NOT NULL,
    permission_id INT NOT NULL,
    PRIMARY KEY (user_id, permission_id),
    CONSTRAINT fk_user_permission_user
        FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT fk_user_permission_permission
        FOREIGN KEY (permission_id) REFERENCES permission(id)
) ENGINE=InnoDB;

-- Safe to run more than once: update existing names rather than duplicate ids.
INSERT INTO permission(id, name) VALUES (1, 'add')
    ON DUPLICATE KEY UPDATE name = 'add';
INSERT INTO permission(id, name) VALUES (2, 'edit')
    ON DUPLICATE KEY UPDATE name = 'edit';
INSERT INTO permission(id, name) VALUES (3, 'delete')
    ON DUPLICATE KEY UPDATE name = 'delete';
INSERT INTO permission(id, name) VALUES (4, 'view')
    ON DUPLICATE KEY UPDATE name = 'view';

-- After creating a user with Add and View permissions, verify:
-- SELECT id, name, email FROM users ORDER BY id DESC LIMIT 1;
-- SELECT * FROM user_permission ORDER BY user_id DESC, permission_id;

-- No-transaction / auto-commit practice, isolated from the users tables.
-- Never DROP existing employee data when setting up the example.
-- UserDAO.insertUpdateWithoutTransaction deliberately causes a SQL exception
-- after two successful inserts; with auto-commit enabled, both rows persist.
CREATE TABLE IF NOT EXISTS Employee (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(120) NOT NULL,
    salary DECIMAL(15,2) NOT NULL,
    created_Date DATETIME
) ENGINE=InnoDB;

-- Test: http://localhost:8080/user-management/users?action=test-without-tran
-- Look in Tomcat's console for the deliberately thrown SQLException.
-- To see the most recent two demo rows:
-- SELECT * FROM Employee ORDER BY id DESC LIMIT 2;
-- Warning: repeating the demo adds two MORE rows. To reset the Employee
-- demo table automatically on each run, opt in explicitly by setting
-- ALLOW_EMPLOYEE_DEMO_RESET=true before starting Tomcat.

-- JDBC with Transaction: compare atomic rollback and successful commit.
-- This uses the existing InnoDB Employee table and intentionally does not
-- DROP TABLE Employee, because DROP/CREATE causes implicit commits in MySQL.
--
-- Run both URLs on your local Tomcat after deploying the new WAR:
-- 1. Rollback demo: http://localhost:8080/user-management/users?action=test-use-tran
-- 2. Commit demo:   http://localhost:8080/user-management/users?action=test-use-tran&mode=success
--
-- Run this SQL BEFORE the first demo and AFTER each run to compare row count.
-- SELECT COUNT(*) AS employee_count FROM Employee;
-- SELECT id, name, salary, created_Date FROM Employee ORDER BY id DESC LIMIT 5;
--
-- Expected: the rollback demo adds 0 rows; the commit demo adds 2 rows
-- and sets the NEW Quynh employee's salary to 999.99.
-- IMPORTANT: the existing rows from the earlier no-transaction exercise remain;
-- therefore the table may NOT be empty after a successful rollback.

-- Assignment: Call MySQL Stored Procedures from JDBC.
-- All three procedures are invoked with CallableStatement in UserDAO.java.
-- Make sure this script is run once before opening the users page.
DELIMITER $$

DROP PROCEDURE IF EXISTS get_all_users $$
CREATE PROCEDURE get_all_users()
BEGIN
    SELECT id, name, email, country
    FROM users
    ORDER BY name ASC, id ASC;
END $$

DROP PROCEDURE IF EXISTS update_user $$
CREATE PROCEDURE update_user(
    IN p_user_id INT,
    IN p_name VARCHAR(120),
    IN p_email VARCHAR(220),
    IN p_country VARCHAR(120),
    OUT p_affected_rows INT
)
BEGIN
    UPDATE users
    SET name = p_name, email = p_email, country = p_country
    WHERE id = p_user_id;
    SET p_affected_rows = ROW_COUNT();
END $$

DROP PROCEDURE IF EXISTS delete_user $$
CREATE PROCEDURE delete_user(
    IN p_user_id INT,
    OUT p_deleted_rows INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
    START TRANSACTION;
    DELETE FROM user_permission WHERE user_id = p_user_id;
    DELETE FROM users WHERE id = p_user_id;
    SET p_deleted_rows = ROW_COUNT();
    COMMIT;
END $$

DELIMITER ;

-- The JDBC Transaction practice in user-management-transaction-practice
-- deliberately runs a bad INSERT after successfully inserting a temporary user.
-- It should trigger SQLException 1054 and rollback ALL changes.
--
-- Run after the app displays a unique email in its result page:
-- SELECT * FROM users WHERE email = '<email-displayed-on-result-page>';
-- Expected: 0 rows (the transaction was rolled back).
-- SELECT * FROM user_permission WHERE user_id IN
--   (SELECT id FROM users WHERE email = '<email-displayed-on-result-page>');
-- Expected: 0 rows.
--
-- Confirm tables support rollback (both MUST have ENGINE=InnoDB):
-- SELECT table_name, engine FROM information_schema.tables
-- WHERE table_schema = 'demo' AND table_name IN ('users','user_permission');
-- If your existing 'users' table has a nontransactional engine, convert it
-- only after backing up your own database, before running the training test.
