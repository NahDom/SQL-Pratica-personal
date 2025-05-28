-- si quisiera actualizar la vista al menos en T-SQL deberia usar las command lines propias del mismo
-- en postgres es mas facil pero tampoco es como mysql
-- transact sql
if OBJECT_ID ('Sales.v_resumen_mensual','V') is not null
	DROP VIEW Sales.v_resumen_mensual
GO
create view Sales.v_resumen_mensual as
(
	select
	DATETRUNC(month, OrderDate) [ordenes del mes],
	Sum(sales) [ventas totales],
	COUNT(orderID) TotalOrders
	from Sales.Orders
	group by DATETRUNC(month, OrderDate)
)

