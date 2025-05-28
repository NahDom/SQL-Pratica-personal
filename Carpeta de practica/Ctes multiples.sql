/*Multiples CTEs*/

-- paso 1 encontrar el total de compras/ ventas por clientes
-- paso 2 encontrar la ultima fecha de pedido por cliente

-- paso 1
with CTE_total_sales as
(
	select 
		CustomerID, 
		SUM(sales) [ventas totales] 
	from Sales.Orders
	group by CustomerID
)
,
-- paso 2
	CTE_last_orderdate as(
	select 
		CustomerID,
		max(OrderDate) as last_order
	from Sales.Orders
	group by CustomerID
	)
-- CONSULTA PRINCIPAL

select
	c.CustomerID,
	c.FirstName,
	c.LastName,
	cte.[ventas totales],
	cte2.last_order 
from sales.Customers c 
     left join CTE_total_sales cte
	 on cte.CustomerID = c.CustomerID
	 right join CTE_last_orderdate cte2 
	 on cte2.CustomerID = cte.CustomerID