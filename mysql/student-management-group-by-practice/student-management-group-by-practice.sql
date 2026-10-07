USE QuanLySinhVien;

-- 1. Hien thi so luong sinh vien o tung noi
SELECT
    Address,
    COUNT(StudentID) AS `So luong hoc vien`
FROM Student
GROUP BY Address;

-- 2. Tinh diem trung binh cac mon hoc cua moi hoc vien
SELECT
    S.StudentID,
    S.StudentName,
    AVG(M.Mark) AS AverageMark
FROM Student AS S
JOIN Mark AS M
    ON S.StudentID = M.StudentID
GROUP BY
    S.StudentID,
    S.StudentName;

-- 3. Hien thi nhung hoc vien co diem trung binh cac mon hoc lon hon 15
SELECT
    S.StudentID,
    S.StudentName,
    AVG(M.Mark) AS AverageMark
FROM Student AS S
JOIN Mark AS M
    ON S.StudentID = M.StudentID
GROUP BY
    S.StudentID,
    S.StudentName
HAVING AVG(M.Mark) > 15;

-- 4. Hien thi thong tin hoc vien co diem trung binh lon nhat
SELECT
    S.StudentID,
    S.StudentName,
    AVG(M.Mark) AS AverageMark
FROM Student AS S
JOIN Mark AS M
    ON S.StudentID = M.StudentID
GROUP BY
    S.StudentID,
    S.StudentName
HAVING AVG(M.Mark) >= ALL (
    SELECT AVG(M2.Mark)
    FROM Mark AS M2
    GROUP BY M2.StudentID
);
