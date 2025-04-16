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