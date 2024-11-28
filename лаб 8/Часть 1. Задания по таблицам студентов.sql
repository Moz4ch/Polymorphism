--1--
CREATE VIEW vw_TeacherDetails AS
SELECT 
    Professor_Name,     
    e.Position,                       
    p.Rank,                         
    p.Degree,                     
    COUNT(ex.Code) AS ExamCount         
FROM 
    Prof p
JOIN 
    Employee e ON p.Tab_Number = e.Tab_Number  
LEFT JOIN 
    Exam ex ON e.Tab_Number = ex.Tab_Number 
GROUP BY 
    Professor_Name, e.Position, p.Rank, p.Degree;
	
SELECT * FROM vw_TeacherDetails;

--2--
WITH AvgSalary AS (
    SELECT 
        d.Faculty, 
        AVG(e.Salary) AS Avg_Faculty_Salary
    FROM 
        Employee e
    JOIN 
        Department d ON e.Code = d.Code 
    GROUP BY 
        d.Faculty
)
SELECT 
    e.Tab_Number,
    e.Professor_Name,
    e.Salary,
    d.Faculty
FROM 
    Employee e
JOIN 
    Department d ON e.Code = d.Code 
JOIN 
    AvgSalary a ON d.Faculty = a.Faculty
WHERE 
    e.Salary < a.Avg_Faculty_Salary;


--3--
CREATE TABLE #WeeklyExamStats (
    WeekNumber INT,
    ExamCount INT,
    StudentCount INT
);

INSERT INTO #WeeklyExamStats (WeekNumber, ExamCount, StudentCount)
SELECT 
    DATEPART(week, exam.Date) AS WeekNumber,
    COUNT(DISTINCT exam.Code) AS ExamCount,
    COUNT(DISTINCT exam.Reg_Number) AS StudentCount
FROM 
    Exam exam
GROUP BY 
    DATEPART(week, exam.Date);

SELECT * FROM #WeeklyExamStats;

DROP TABLE #WeeklyExamStats;


--4--
DROP VIEW IF EXISTS vw_TeacherDetails;

