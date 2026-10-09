CREATE DATABASE IF NOT EXISTS demo;
USE demo;

CREATE TABLE IF NOT EXISTS users (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(120) NOT NULL,
    email VARCHAR(220) NOT NULL,
    country VARCHAR(120)
);

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
