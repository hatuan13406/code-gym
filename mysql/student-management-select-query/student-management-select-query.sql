USE QuanLySinhVien;

-- 1. Hien thi danh sach tat ca hoc vien
SELECT *
FROM Student;

-- 2. Hien thi danh sach hoc vien dang theo hoc
SELECT *
FROM Student
WHERE Status = TRUE;

-- 3. Hien thi danh sach mon hoc co thoi gian hoc nho hon 10 gio
SELECT *
FROM Subject
WHERE Credit < 10;

-- 4. Hien thi danh sach hoc vien lop A1
SELECT S.StudentId, S.StudentName, C.ClassName
FROM Student S
JOIN Class C ON S.ClassId = C.ClassID
WHERE C.ClassName = 'A1';

-- 5. Hien thi diem mon CF cua cac hoc vien
SELECT S.StudentId, S.StudentName, Sub.SubName, M.Mark
FROM Student S
JOIN Mark M ON S.StudentId = M.StudentId
JOIN Subject Sub ON M.SubId = Sub.SubId
WHERE Sub.SubName = 'CF';
