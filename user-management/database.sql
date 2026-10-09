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
