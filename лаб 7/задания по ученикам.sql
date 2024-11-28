--1--
SELECT MAX(Sum) - MIN(Sum) AS score_difference
FROM Students;

--2--
SELECT 
    (SELECT AVG(Sum) FROM Students WHERE School = 'Лицей') - 
    (SELECT AVG(Sum) FROM Students WHERE School = 'Гимназия') AS score_difference;


--3--
SELECT 
    CASE 
        WHEN COUNT(*) % 2 = 0 THEN 'Четное количество строк'
        ELSE 'Нечетное количество строк'
    END AS row_parity
FROM Students;


--4--
SELECT ID, Surname, Subject, School, Sum
FROM Students
WHERE Sum BETWEEN 80 AND 90;

