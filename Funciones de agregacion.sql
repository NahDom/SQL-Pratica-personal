/*COUNT*/

select 
	OrderID,
	ProductID,
	OrderDate,
	CustomerID,	
	count(*) over() TotalDePedido,
	count(*) over(partition by CustomerID) OrdenesPorCliente
from sales.Orders

--encontrar el total de clientes y mostrar todos los detalles de los clientes

select 
 *,
 COUNT(*) over() totalclientes,
 COUNT(Score) over() totalclientes,
 COUNT(Country) over() tot_paises
 from sales.Customers

 -- ahora si quiero verificar de donde es que salen esas
 -- claves repetidas
 select 
 *
 from(
	 select
		 orderid,
		 count(*) over(partition by orderid) chequeodepk -- compruebo la PK,
		 --productid,
		--count(ProductID) over(partition by productid) filas_repetidas
	 from Sales.OrdersArchive
 )t
 where chequeodepk > 1

select
	orderid,
	orderdate,
	ProductID,
	sum(sales) over() [ventas totales],
	sum(sales) over(partition by productid) [ventas totales por cada producto]
from Sales.Orders

/*SUM */

-- encuentre el porcentaje de distribucion de las ventas de cada producto a las ventas totales
-- procetaje de contribucion = ((sales)/(sum(...) over(...))) * 100
select 
	OrderID,
	ProductID,
	Sales,
	sum(sales) over() ventas_totales,
	round(cast(Sales as float)/sum(sales) over()* 100,2) porcentaje_de_contribucion
from Sales.Orders

/* AVG() */
-- realiza el promedio de los valores dentro de cada ventana
-- ejemplo
-- encontrar la media de ventas para cada producto
-- avg(sales) over(partition by product)

-- ejercicio: encontrar el promedio de ventas a lo largo de todos los pedidos
-- y el promedio de ventas por cada producto
-- adicionalmente proveer detalles como el order id y el order date

select
	orderid,
	orderdate,
	ProductID,
	Sales,
	avg(sales) over() [promedio de ventas general],
	avg(sales) over(partition by ProductID) [promedio por cada producto]
from Sales.Orders

-- hallar el promedio de puntos de los clientes
-- adcionalmente proveer detalles como el customerid y el lastname del cliente

select 
	CustomerID,
	coalesce(LastName,'n/a') apellido,
	score,
	AVG(coalesce(score,0)) over() [promedio de puntos]
from Sales.Customers

-- hallar todos los pedidos donde las ventas son mayores que el promedio de ventas a lo largo de todos los pedidos
select
	OrderID,
	ProductID,
	avg(sales) over() total_general
from Sales.Orders
where Sales > avg(sales) over()
-- esto es imposible que ocurra porque solo pueden estar en las select y group by
-- una funcion de ventana JAMAS puede ser usada con una clausula WHERE
-- no queda otra que aplicar la confiable SUBCONSULTA
select
* 
from(
	select
		OrderID,
		ProductID,
		sales,
		avg(sales) over() total_general
	from Sales.Orders
	)t
where sales > total_general

/*Funciones de MIN y MAX */

-- encontrar el valor mas alto y bajo a lo largo de todos los pedidos
-- y el mas alto y bajo para cada producto

select
	OrderID,
	ProductID,
	sales,
	max(sales) over() maximo_ventas,
	min(Sales) over() minimo_ventas,
	max(sales) over(partition by productid) max_product,
	min(sales) over(partition by productid) min_product
FROM Sales.Orders

-- muestra los empleados que tengan los mayores salarios
-- otra vez si solo se haria por agregaciones normales siempre darian el maximo de cada uno
-- con la funcion ventana me daria el grupo completo
-- de forma tal que con la sub query puedo traerlo y compararlo con el mas alto de la tabla mas_alto
select 
*
from
(
	select 
	*,
	max(salary) over() mas_alto
	FROM Sales.Employees
)t
where Salary = mas_alto

-- calcular la desviacion de cada venta con el monto maximo y minimo de cada venta

select
	OrderID,
	ProductID,
	sales,
	max(sales) over() maximo_ventas,
	min(Sales) over() minimo_ventas,
	sales - min(Sales) over() desviacion_minima,
	max(sales) over() - sales desviacion_maxima
FROM Sales.Orders