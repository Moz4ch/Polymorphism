CREATE TABLE Faculty (
    Short VARCHAR(10),
    Department VARCHAR(255)
);

-- Вставка данных
INSERT INTO Faculty (Short, Department)
VALUES
    ('Фен', 'Естественные науки'),
    ('Гн', 'Гуманитарные науки'),
    ('Фит', 'Информационные технологии'),
    ('Фм', 'Физико-математический');
