CREATE TABLE Students (
    ID INT PRIMARY KEY,
    Surname VARCHAR(100),
    Subject VARCHAR(100),
    School VARCHAR(100),
    Sum DECIMAL(4, 1)
);

INSERT INTO Students (ID, Surname, Subject, School, Sum) VALUES
(1, '�������', '����������', '�����', 98.5),
(2, '������', '������', '�����', 99.0),
(3, '�������', '����������', '�����', 88.0),
(4, '��������', '������', '��������', 78.0),
(5, '��������', '�����', '�����', 92.0),
(6, '�������', '�����', '��������', 68.0),
(7, '�������', '����������', '��������', 81.0),
(8, '������', '������', '�����', 87.0),
(9, '��������', '�����', '�����', 94.0),
(10, '��������', '�����', '�����', 88.0);

--1--
CREATE TRIGGER trg_UpdateStudent
ON Students
AFTER UPDATE
AS
BEGIN
    PRINT '������ ��������';
END;


--2--
CREATE TRIGGER trg_InsertDeleteStudent
ON Students
AFTER INSERT, DELETE
AS
BEGIN
    PRINT '���������� ����� ��������';
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
    
    PRINT @currentUser + ' ������� �������. �����: ' + CONVERT(NVARCHAR, @currentTime, 120);
END;


--4--
CREATE TRIGGER trg_PreventUpdateStudent
ON Students
FOR UPDATE
AS
BEGIN
    PRINT '������ ������������� ������';
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
