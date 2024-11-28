CREATE TABLE Department (
    Code VARCHAR(10),
    Department VARCHAR(255),
    Faculty VARCHAR(10)
);

INSERT INTO Department (Code, Department, Faculty)
VALUES
    ('вм', 'Высшая математика', 'Фен'),
    ('ис', 'Информационные системы', 'Фит'),
    ('мм', 'Математическое моделирование', 'Фм'),
    ('оф', 'Общая физика', 'Фен'),
    ('пи', 'Прикладная информатика', 'Фит'),
    ('эф', 'Экспериментальная физика', 'Фм');
