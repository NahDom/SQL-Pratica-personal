/* Usando la base de datos salesdb devolver una
lista de todos los pedidos junto con los detalles relacionados de
los clientes, productos y detalles de los empleados*/
/* OrderID, customer name, product name, sales, price
sales person name el vendedor*/

SELECT 
	o.OrderID,
	c.FirstName as NombreCliente,
	p.Product as ProductName,
	a.Sales,
	p.Price,
	e.FirstName as NombreEmpleado
FROM Sales.Orders o
LEFT JOIN Sales.Customers c
ON o.CustomerID = c.CustomerID
LEFT JOIN Sales.OrdersArchive a
ON o.OrderID = a.OrderID
LEFT JOIN Sales.Products p
ON o.ProductID = p.ProductID
LEFT JOIN Sales.Employees e
ON o.SalesPersonID = e.EmployeeID


