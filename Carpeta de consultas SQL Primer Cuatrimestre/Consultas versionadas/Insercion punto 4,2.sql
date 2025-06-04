INSERT INTO emp (eid, enombre, edad, salario) VALUES
(101, 'Mario Pérez', 45, 60000),
(102, 'Lucía Martínez', 34, 48000),
(103, 'Carlos Sánchez', 40, 51000),
(104, 'Valeria Jiménez', 29, 42000),
(105, 'Andrés Díaz', 37, 54000),
(106, 'Camila Torres', 32, 46000),
(107, 'Sebastián Ruiz', 38, 53000),
(108, 'Martina Gutiérrez', 36, 52000),
(109, 'Fernando Herrera', 41, 57000),
(110, 'Natalia Romero', 30, 47000);

INSERT INTO dept (did, dnombre, ciudad) VALUES
(1, 'Recursos Humanos', 'Buenos Aires'),
(2, 'Finanzas', 'Córdoba'),
(3, 'IT', 'Rosario'),
(4, 'Marketing', 'Mendoza'),
(5, 'Operaciones', 'Salta');

INSERT INTO works (eid, did, desde) VALUES
(101, 1, '2015-03-01'),
(102, 2, '2018-07-15'),
(103, 3, '2017-01-10'),
(104, 4, '2019-06-21'),
(105, 5, '2016-02-13'),
(106, 3, '2020-09-01'),
(107, 1, '2013-11-30'),
(108, 2, '2014-04-18'),
(109, 4, '2016-12-05'),
(110, 5, '2021-01-20');
