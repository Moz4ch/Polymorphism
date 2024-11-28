CREATE TABLE Students (
    ID INT PRIMARY KEY,
    Surname VARCHAR(100),
    Subject VARCHAR(100),
    School VARCHAR(100),
    Sum DECIMAL(4, 1)
);

INSERT INTO Students (ID, Surname, Subject, School, Sum) VALUES
(1, 'Иванова', 'Математика', 'Лицей', 98.5),
(2, 'Петров', 'Физика', 'Лицей', 99.0),
(3, 'Сидоров', 'Математика', 'Лицей', 88.0),
(4, 'Полухина', 'Физика', 'Гимназия', 78.0),
(5, 'Матвеева', 'Химия', 'Лицей', 92.0),
(6, 'Касимов', 'Химия', 'Гимназия', 68.0),
(7, 'Нурулин', 'Математика', 'Гимназия', 81.0),
(8, 'Авдеев', 'Физика', 'Лицей', 87.0),
(9, 'Никитина', 'Химия', 'Лицей', 94.0),
(10, 'Барышева', 'Химия', 'Лицей', 88.0);

--1--
CREATE TRIGGER trg_UpdateStudent
ON Students
AFTER UPDATE
AS
BEGIN
    PRINT 'Запись изменена';
END;


--2--
CREATE TRIGGER trg_InsertDeleteStudent
ON Students
AFTER INSERT, DELETE
AS
BEGIN
    PRINT 'Количество строк изменено';
END;

--3--
CREATE TRIGGER trg_AuditStudentChanges
ON Students
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @currentUser NVARCHAR(100);
    DECLARE @currentTime DATETIME;
    
    SET @currentUser = SUSER_NAME(); 
    SET @currentTime = GETDATE();   
    
    PRINT @currentUser + ' изменил таблицу. Время: ' + CONVERT(NVARCHAR, @currentTime, 120);
END;


--4--
CREATE TRIGGER trg_PreventUpdateStudent
ON Students
FOR UPDATE
AS
BEGIN
    PRINT 'Нельзя редактировать данные';
    ROLLBACK TRANSACTION;
END;


--5--
CREATE TABLE Students_YourSurname (
    Surname VARCHAR(100),
    DeletionDate DATETIME
);


--6--
CREATE TRIGGER trg_TrackDeletedStudents
ON Students
AFTER DELETE
AS
BEGIN
    DECLARE @deletedSurname VARCHAR(100);
    SELECT @deletedSurname = Surname FROM deleted;
    
    IF EXISTS (SELECT 1 FROM Students WHERE Surname = @deletedSurname)
    BEGIN
        INSERT INTO Students_YourSurname (Surname, DeletionDate)
        SELECT @deletedSurname, GETDATE();
    END
END;


--7--
DISABLE TRIGGER trg_TrackDeletedStudents ON Students;
ENABLE TRIGGER trg_TrackDeletedStudents ON Students;


--8--
DROP TRIGGER trg_UpdateStudent;
DROP TRIGGER trg_InsertDeleteStudent;
DROP TRIGGER trg_AuditStudentChanges;
DROP TRIGGER trg_PreventUpdateStudent;
DROP TRIGGER trg_TrackDeletedStudents;
