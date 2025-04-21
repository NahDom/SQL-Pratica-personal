select 
	 OrderID
	,OrderDate
	,ShipDate
	,CreationTime /* formato fecha y hora de creacion del registro */
	--datename examples
	,DATENAME(MONTH,CreationTime) Mes_creacion
	,DATENAME(WEEKDAY,CreationTime) dia_creacion
	--datetrunc examples
	,DATETRUNC(DAY,CreationTime) Anioo_truncado
	,year(OrderDate) OrderYear
	,month(OrderDate) OrderMonth
	,day(OrderDate) OrderDay
	,DATEPART(month,OrderDate)
	,DATEPART(year, CreationTime)
from Sales.Orders 