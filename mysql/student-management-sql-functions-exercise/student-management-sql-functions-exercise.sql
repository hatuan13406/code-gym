USE QuanLySinhVien;

-- 1. Hien thi tat ca thong tin mon hoc co Credit lon nhat
SELECT *
FROM Subject
WHERE Credit = (
    SELECT MAX(Credit)
    FROM Subject
);

-- 2. Hien thi thong tin mon hoc co diem thi lon nhat
SELECT DISTINCT
    Sub.SubID,
    Sub.SubName,
    Sub.Credit,
    Sub.Status,
    M.Mark
FROM Subject AS Sub
JOIN Mark AS M
    ON Sub.SubID = M.SubID
WHERE M.Mark = (
    SELECT MAX(Mark)
    FROM Mark
);

-- 3. Hien thi thong tin sinh vien va diem trung binh cua moi sinh vien
-- Sap xep theo diem trung binh giam dan
SELECT
    S.StudentID,
    S.StudentName,
    S.Address,
    S.Phone,
    S.Status,
    S.ClassID,
    AVG(M.Mark) AS AverageMark
FROM Student AS S
JOIN Mark AS M
    ON S.StudentID = M.StudentID
GROUP BY
    S.StudentID,
    S.StudentName,
    S.Address,
    S.Phone,
    S.Status,
    S.ClassID
ORDER BY AverageMark DESC;
