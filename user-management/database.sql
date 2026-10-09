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
