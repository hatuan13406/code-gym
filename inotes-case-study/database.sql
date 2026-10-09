-- iNotes database schema. Execute in MySQL Workbench or MySQL command-line.
CREATE DATABASE IF NOT EXISTS inotes_db
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE inotes_db;

CREATE TABLE IF NOT EXISTS note_type (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS notes (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT,
    type_id INT NOT NULL,
    CONSTRAINT fk_notes_note_type
        FOREIGN KEY (type_id) REFERENCES note_type(id)
) ENGINE=InnoDB;

-- Seed three categories, matching the file-based strategy.
-- Updating in place makes the script safe to rerun.
INSERT INTO note_type (id, name, description) VALUES
  (1, 'Cá nhân', 'Ghi chú cá nhân'),
  (2, 'Công việc', 'Công việc và lịch trình'),
  (3, 'Học tập', 'Kiến thức và bài học')
ON DUPLICATE KEY UPDATE
  name = VALUES(name),
  description = VALUES(description);

-- Optional queries for checking notes:
-- SELECT n.id, n.title, n.content, t.name AS type_name
-- FROM notes n JOIN note_type t ON n.type_id = t.id ORDER BY n.id DESC;
