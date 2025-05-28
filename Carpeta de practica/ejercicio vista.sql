-- trabajo
-- Debes de crear una vista la cual integre en forma correcta y entendible para el usuario los siguientes campos
-- detalles de la orden, productos, clientes y empleados

create view Sales.v_detalle_compras as
(
	select 
	o.orderid,
	o.orderdate,
	p.Product,
	p.category,
	COALESCE(c.FirstName, ' ') + ' ' + COALESCE(c.LastName, ' ') Nombre_Cliente,
	c.country Pais_Cliente,
	COALESCE(e.FirstName, ' ') + ' ' + COALESCE(e.LastName, ' ') Nombre_Empleado,
	e.department,
	o.sales,
	o.quantity
	from Sales.Orders o
	LEFT JOIN Sales.Products p
	on p.ProductID = o.ProductID
	LEFT JOIN Sales.Customers c
	on c.CustomerID = o.CustomerID
	LEFT JOIN Sales.Employees e
	on e.EmployeeID = o.SalesPersonID
)

select * from Sales.v_detalle_compras