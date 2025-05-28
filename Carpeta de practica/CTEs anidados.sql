/* CTEs anidados */

-- paso 1 encontrar el total de compras/ ventas por clientes
-- paso 2 encontrar la ultima fecha de pedido por cliente
-- paso 2 clasificar los clientes en funcion de las ventas totales por cliente


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
	-- paso 3 -- CTE Que necesita de otro para poder operar
,
CTE_ranking as
   (
	select 
		customerID,
		[ventas totales],
		rank() over(order by [ventas totales] desc) as clasificacion_clientes
	from CTE_total_sales
   )
,
		-- paso 4 segmentar clientes basados en sus ventas totales
		-- como la segmentacion necesita que los clasifiquemos bajo 
		-- alguna condicion del negocio, usare el CASE WHEN
CTE4_customer as (
	select
	customerid,
	[ventas totales],
	case when [ventas totales] > 100 then 'Alto'
		 when [ventas totales] > 80 then 'Medio'
		 else 'Bajo'
	end as Clasificacion
	from CTE_total_sales
)


-- CONSULTA PRINCIPAL

select
	crank.clasificacion_clientes,
	c4.Clasificacion,
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
	 left join CTE_ranking crank
	 on crank.CustomerID = c.CustomerID
	 left join CTE4_customer c4
	 on c4.CustomerID = c.CustomerID 
order by clasificacion_clientes
