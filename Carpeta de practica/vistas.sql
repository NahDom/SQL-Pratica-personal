/* Views */

-- find the running total of sales for each month
-- encontrar el total acumulado de ventas para cada mes
-- el total acumulado se hacia por medio de las window functions en este caso de la funcion SUM(column) OVER() Name


-- creamos un CTE
with CTE_Running_total as(
	select
	DATETRUNC(month, OrderDate) [ordenes del mes],
	Sum(sales) [ventas totales],
	COUNT(orderID) TotalOrders,
	SUM(quantity) totalquantities
	from Sales.Orders
	group by DATETRUNC(month, OrderDate)
)

select 
	[ordenes del mes],
	[ventas totales],
	Sum([ventas totales]) over(order by [ordenes del mes]) as TotalAcumulado
from CTE_Running_total

-- como tal este cte tiene persistencia de los datos, pero el cte es fijo, no podra realizarse algun cambio ya que su
-- persistencia permanece al contrario de una vista que por medio de obtener la tabla puede operar sobre ella, sin afectar
-- la tabla de la base de datos, pero la vista es una consulta ya previamente generada sobre la BD