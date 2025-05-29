/*
	TRIGGERS EN SQL
*/
-- por ejemplo
-- para el caso del estudio creo una tabla de lgs o registros de los empleados

Create table sales.EmployeeLogs (
	LogID INT IDENTITY(1,1) Primary key, -- identity es similar al auto_increment en MySQL
	EmployeeID INT,
	LogMessage VARCHAR(255),
	LogDate DATE
)