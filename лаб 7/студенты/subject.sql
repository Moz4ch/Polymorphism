CREATE TABLE Subject (
    Code INT,        
    Volume INT,       
    Subject NVARCHAR(255),
    Owner VARCHAR(10)      
);

INSERT INTO Subject (Code, Volume, Subject, Owner)
VALUES
    (101, 320, 'Математика', 'вм'),
    (102, 160, 'Информатика', 'пи'),
    (103, 160, 'Физика', 'оф'),
    (202, 120, 'Базы данных', 'ис'),
    (204, 160, 'Электроника', 'эф'),
    (205, 80, 'Программирование', 'пи'),
    (209, 80, 'Моделирование', 'мм');
