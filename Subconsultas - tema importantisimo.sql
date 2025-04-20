/* IMPORTANTE - SUBCONSULTAS */

-- SUBCONSULTAS EN EL FROM

-- find the products that have a price higher than the average price of all products
-- encontrar los productos que tengan un precio mayor que el promedio de todos los productos
select
*
from(
	--subconsulta
	select
		Product,
		Price,
		AVG(price) over() media_de_precio
	from sales.Products
)t
Where Price > media_de_precio

-- rank customers based on their total amount of sales
-- clasificar a los clientes segun su total de ventas
select
	*,
	rank() over(order by total_quantity desc) clasificacion
from(
	select
		CustomerID,
		sum(sales) total_quantity
	from sales.Orders
	group by CustomerID
)t

-- SUBCONSULTAS EN EL SELECT

-- show the products ids, products names, prices and the total of number of orders
-- muestra el id de productos, los nombres, precios y el total del numero de pedidos

-- en este caso me evito hacer el JOIN con la tabla de productos por medio de la subconsulta
-- siempre y cuando COINCIDAN las columnas en la subconsulta y la principal

-- numero total de pedidos con la columna o con (*)
select
count(*)
from Sales.Orders

-- query mayor con la subconsulta en el select

select
	productid,
	product,
	price,
	(select
		count(*)
	from Sales.Orders) numero_total_de_pedidos
from Sales.Products
 
-- experimento --> no hace lo que supuse aunque lo hace en forma corrida, no es escalar y muestra por extencion
-- usa join pero no hace lo que espere, pequeña muestra de que NO HACER
select
	p.productid,
	p.product,
	count(*) over() total_pedidos
from Sales.Products p join Sales.Orders o on p.ProductID = o.ProductID

-- SUBCONSULTAS EN EL JOIN

-- mostrar todos los detalles de clientes y encontrar el total de pedidos para cada cliente

-- primer forma (intento mio)

select
* 
from sales.customers c 
 left join (	
		select 
			CustomerID, 
			COUNT(*) /*over(partition by customerid)*/ tot_pedido
			-- observacion es que si bien funciona lo sigo mostrando en formato de window function
			-- comento la funcion ventana
		from sales.Orders
		group by CustomerID
		)t on c.CustomerID = t.CustomerID
		-- la unica forma seria...bueno, la clasica que en vez de una ventana sea una tabla sencilla
		-- de resultado que se una a la mas grande por medio del join y correlacionado con la clave
		
		
 


