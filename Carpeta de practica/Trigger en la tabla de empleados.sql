CREATE TRIGGER trg_AfterInsertEmployee ON Sales.Employees
AFTER INSERT
-- Luego de realizar una insercion de datos
AS
BEGIN 
	insert into Sales.EmployeeLogs (EmployeeID, LogMessage, LogDate)
	select
		EmployeeID,
		'Nuevo Empleado Adherido a la BD =' + CAST(EmployeeID AS VARCHAR),
		GETDATE()
	from inserted
END