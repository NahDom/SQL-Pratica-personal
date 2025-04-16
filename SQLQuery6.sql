use SalesDB;
select 
	format(OrderDate, 'MMM yy') [Mes de Pedidos],
	count(*) [Total Pedidos]
from Sales.Orders
group by format(OrderDate, 'MMM yy');

select
CreationTime,
CONVERT(date, CreationTime) [Datetime a Date],
CONVERT(varchar,CreationTime,32) [USA formato: 32],
CONVERT(varchar,CreationTime,34) [EUR formato: 34]
FROM Sales.Orders;

/*DATEADD DATEDIFF ISDATE*/

select
	OrderID,
	OrderDate,
	DATEADD(day,10,OrderDate) [10 dias despues],
	DATEADD(day,-10,OrderDate) [10 dias antes],
	DATEADD(year,2,OrderDate) [Dos años despues],
	DATEADD(month,-4,OrderDate) [cuatro meses antes],
	DATEADD(year,-2,OrderDate) [Dos años antes],
	DATEADD(month,-2,OrderDate) [dos meses antes]
	from Sales.Orders;

	/* DATEDIFF() */
	/*edad actual de los empleados de la empresa*/
select
	EmployeeID,
	BirthDate [año de nacimiento de los empleados],
	DATEDIFF(year,BirthDate,GETDATE()) [Edad actual de los empleados]
from Sales.Employees
 /* tiempo medio de dias entre pedido y compras*/
select
 -- siempre la agrupacion es a partir de la primer columna de la consulta
 -- nunca puede hacerse por la segunda, de otra forma no tendria sentido 
 -- no tendria de donde comenzar realmente a agrupar y siempre deben colocarse todas
 -- las columnas en el group by hasta la agregacion para que tenga sentido, o al menos
 -- intentar que tenga sentido el agruparlas por algun criterio coherente
	month(OrderDate)[Mes de compra],
	month(ShipDate)[Mes de compra],
	AVG(DATEDIFF(DAY,OrderDate, ShipDate)) [Tiempo hasta la compra]
	-- en este caso es el mismo mes y varios dias de diferencia pero el 
	-- resultado es lo suficientemente convaleciente para dar buen reporting
from Sales.Orders
group by month(OrderDate),month(ShipDate);

-- EJEMPLO REAL
/* Time gap analysis
	encontrar el numero medio de dias entre cada orden y la orden previa*/

select 
	OrderID,
	OrderDate [Fecha Actual del Pedido],
	-- Funcion de ventana LAG()
	-- Permite acceder a un valor anterior del registro
	LAG(OrderDate) OVER(Order by OrderDate) [Fecha Previa del Pedido],
	DATEDIFF(day,LAG(OrderDate) OVER(Order by OrderDate),OrderDate) [Dias entre pedidos]
from Sales.Orders;

/* ISDATE() */

select
	--cast(OrderDate as date) OrderDate,
	OrderDate [Fecha de Pedidos],
	ISDATE(OrderDate) [Es correcto?],
		CASE 
			WHEN ISDATE(OrderDate) = 1 THEN CAST(OrderDate as DATE)
			ELSE  '9999-01-01'
		END [Nueva fecha de pedido]
from
	(
		select '2025-08-20' as OrderDate UNION
		select '2025-08-21' UNION
		select '2025-08-23' UNION
		select '2025-08'
	)t
WHERE ISDATE(OrderDate) = 0
/*La version de Baara falla por alguna razon y creo que tiene que ver con la regionalidad
  justamente por tener la maquina configurada en otra region no me reconocer el formato de USA*/
-- hay otra solucion si y es usando una funcion de ventana llamada TRY_CONVERT() que me ayuda a manejar 
--fechas de una forma mucho mas flexible para valores que podrian no ser validos, evitando el error de la regionalidad

-- version con TRY_CONVERT()
-- SI!, LA REGIONALIDAD AFECTA A SQL SERVER
select
	--cast(OrderDate as date) OrderDate,
	OrderDate [Fecha de Pedidos],
	CASE  WHEN TRY_CONVERT(date, OrderDate) IS NOT NULL THEN 1
	else 0
	end as [Es correcto?],
	CASE 
	--REEMPLAZO ISDATE() POR TRY_CONVERT()
		WHEN TRY_CONVERT(DATE, OrderDate) is not null 
		THEN TRY_CONVERT(date, OrderDate)
		ELSE  '9999-01-01'
	END [Nueva fecha de pedido]
from
	(
		select '2025-08-20' as OrderDate UNION
		select '2025-08-21' UNION
		select '2025-08-23' UNION
		select '2025-08'
	)t
--WHERE TRY_CONVERT(date,OrderDate) is null;

/* Extracting characters from Strings */

select
	left('Maria',2) izquierda,
	right('Maria',2) derecha,
	len('maria') tamaño,
	substring('maria',3,5) sub_cadena,
	Substring(TRIM('Maria es una buena estudiante'),2, len('Maria es una buena estudiante')) [tamaño de la palabra]

/*ABS y ROUND*/
select
	round(4.56, 7),
	abs(-20.54)










