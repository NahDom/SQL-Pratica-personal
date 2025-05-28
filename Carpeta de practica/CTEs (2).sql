/* Common Table Expressions -- CTEs */
-- lo primero es una independiente una cte que se ejecuta sin depender
-- de la consulta principal y puede ser usada en cualquier parte del codigo
-- para recuperar informacion de la tabla
-- find the total sales per customer
-- paso 1

with CTE_total_sales as
(
	select 
		CustomerID, 
		SUM(sales) [ventas totales] 
	from Sales.Orders
	group by CustomerID
)

-- CONSULTA PRINCIPAL

select
	c.CustomerID,
	c.FirstName,
	c.LastName,
	cte.[ventas totales]
from sales.Customers c left join CTE_total_sales cte
on cte.CustomerID = c.CustomerID 
-- con right join solo me dan aquellos clientes que salen en
-- el cte, pero con left salen todos


-- ACLARACION IMPORTANTE: como es una CTE independiente de la logica de la 
-- query original se debe de ejecutar todo al mismo tiempo para que funcione la query principal
-- mas alla de que la cte es independiente la principal no funciona sin el resultado en cache de la cte
