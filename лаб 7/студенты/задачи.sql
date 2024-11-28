--1--
DECLARE @FacultyCode NVARCHAR(10) = 'фит'; 

SELECT 
    s.Reg_Number,                  
    s.Name AS Student_Name,       
    sp.Number AS Speciality_Code,  
    sp.Course AS Speciality_Name  
FROM 
    Student s
JOIN 
    Speciality sp ON s.Number = sp.Number
JOIN 
    Department d ON sp.Code = d.Code
JOIN 
    Faculty f ON d.Faculty = f.Short    
WHERE 
    UPPER(f.Short) = UPPER(@FacultyCode);



--2--
DECLARE @ExamDate DATE = '2015-06-05'; 

SELECT 
    s.Reg_Number,
    s.Name 
FROM 
    Student s
LEFT JOIN 
    Exam e ON s.Reg_Number = e.Reg_Number AND e.Date = @ExamDate
WHERE 
    e.Reg_Number IS NULL; 


--3--
DECLARE @StartDate DATE = '2015-06-01'; 
DECLARE @EndDate DATE = '2015-06-10';    

SELECT 
    sub.Subject AS Discipline,            
    e.Professor_Name,                      
    e.Position AS Position,
    ex.Date AS Exam_Date,                   
    ex.Location AS Exam_Location             
FROM 
    Exam ex
JOIN 
    Subject sub ON ex.Code = sub.Code       
JOIN 
    Employee e ON ex.Tab_Number = e.Tab_Number  
WHERE 
    ex.Date BETWEEN @StartDate AND @EndDate 
ORDER BY 
    ex.Date; 

--4--
DECLARE @MinAverageMark INT = 4; 

SELECT 
    s.Reg_Number,                       
    s.Name AS Student_Name,                
    COUNT(ex.Mark) AS Exams_Count,        
    AVG(ex.Mark) AS Average_Mark          
FROM 
    Student s
JOIN 
    Exam ex ON s.Reg_Number = ex.Reg_Number 
GROUP BY 
    s.Reg_Number, s.Name                
HAVING 
    AVG(ex.Mark) >= @MinAverageMark;     

--5--
DECLARE @ExamLocation NVARCHAR(10) = 'т505';  

SELECT 
    s.Reg_Number,                          
    s.Name AS Student_Name,                  
    ex.Date AS Exam_Date,                   
    ex.Location AS Exam_Location           
FROM 
    Student s
JOIN 
    Exam ex ON s.Reg_Number = ex.Reg_Number    
WHERE 
    ex.Location = @ExamLocation;             
