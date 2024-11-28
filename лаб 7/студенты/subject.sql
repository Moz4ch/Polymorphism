CREATE TABLE Subject (
    Code INT,        
    Volume INT,       
    Subject NVARCHAR(255),
    Owner VARCHAR(10)      
);

INSERT INTO Subject (Code, Volume, Subject, Owner)
VALUES
    (101, 320, '����������', '��'),
    (102, 160, '�����������', '��'),
    (103, 160, '������', '��'),
    (202, 120, '���� ������', '��'),
    (204, 160, '�����������', '��'),
    (205, 80, '����������������', '��'),
    (209, 80, '�������������', '��');
