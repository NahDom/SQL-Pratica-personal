INSERT INTO avion (aid, aname, cruisingrange) VALUES
(17, 'Cessna 172', 6727),
(18, 'Beechcraft Baron', 6786),
(19, 'Douglas DC-10', 1570),
(20, 'McDonnell Douglas MD-80', 8385),
(21, 'Fokker 100', 3410),
(22, 'Bombardier CRJ200', 7550),
(23, 'Boeing 737 MAX', 2481),
(24, 'Airbus A380', 8654),
(25, 'ATR 72', 8004),
(26, 'Learjet 75', 2718),
(27, 'Comac C919', 3317),
(28, 'Concorde', 5020),
(29, 'Antonov An-225', 7465),
(30, 'Dassault Falcon 7X', 4731),
(31, 'Gulfstream G650', 7903);

INSERT INTO empleados (eid, ename, salary) VALUES
(600000000, 'Oscar Hall', 51995),
(600000001, 'Natalie Lewis', 186609),
(600000002, 'Victor Rivera', 40095),
(600000003, 'Andrea Clark', 173734),
(600000004, 'Jason Lee', 247098),
(600000005, 'Emily Walker', 77388),
(600000006, 'Daniel Scott', 147012),
(600000007, 'Hannah Green', 90210),
(600000008, 'Jose Allen', 158693),
(600000009, 'Amy King', 222914);

INSERT INTO vuelos (flno, from, to, distance, departs, arrives) VALUES
(2000, 'Denver', 'Seattle', 570, '15:25:21', '18:14:21'),
(2001, 'Seattle', 'Orlando', 913, '15:09:41', '20:00:41'),
(2002, 'Houston', 'Seattle', 1470, '06:17:34', '07:21:34'),
(2003, 'Seattle', 'Denver', 1906, '17:04:30', '18:29:30'),
(2004, 'Miami', 'Atlanta', 1160, '15:06:05', '19:42:05'),
(2005, 'Orlando', 'Phoenix', 1670, '09:44:12', '12:30:12'),
(2006, 'Atlanta', 'San Francisco', 2402, '08:00:00', '11:35:00'),
(2007, 'Phoenix', 'Houston', 1289, '10:14:45', '14:45:45'),
(2008, 'San Francisco', 'Miami', 2134, '13:00:00', '18:00:00'),
(2009, 'Orlando', 'Seattle', 2401, '07:25:00', '10:55:00'),
(2010, 'Denver', 'Houston', 879, '11:33:00', '13:55:00'),
(2011, 'San Francisco', 'Atlanta', 2440, '12:15:00', '15:35:00'),
(2012, 'Seattle', 'Phoenix', 1304, '16:45:00', '18:50:00'),
(2013, 'Miami', 'San Francisco', 2600, '06:10:00', '11:40:00'),
(2014, 'Phoenix', 'Denver', 1344, '14:30:00', '16:10:00'),
(2015, 'Houston', 'Orlando', 1020, '10:45:00', '13:30:00'),
(2016, 'Orlando', 'Denver', 1715, '08:30:00', '11:55:00'),
(2017, 'Atlanta', 'Seattle', 2200, '09:10:00', '12:45:00'),
(2018, 'Miami', 'Houston', 963, '11:00:00', '13:25:00'),
(2019, 'Phoenix', 'Miami', 1920, '07:40:00', '10:55:00');

INSERT INTO certificados (eid, aid) VALUES
(600000000, 12), (600000000, 27), (600000000, 16), (600000000, 6),
(600000001, 9),  (600000001, 24), (600000001, 17), (600000001, 5),
(600000002, 3),  (600000002, 10), (600000002, 18), (600000002, 26),
(600000003, 1),  (600000003, 6),  (600000003, 12), (600000003, 21),
(600000004, 8),  (600000004, 25), (600000004, 20), (600000004, 11);
