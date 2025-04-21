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
c.*,
t.tot_pedido
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
		
-- SUBCONSULTAS EN EL WHERE

-- Encontrar los productos que tengan un precio mayor que el promedio de todos los productos

select 
*
from Sales.Products
where price > (select avg(price) from Sales.Products)

-- recuerda que solo debe devolver un escalar mas no una tabla, asi que un calculo sobre valores es valido 
-- mientras devuelva un solo valor

-- SUBCONSULTAS CON OPERADOR IN EN EL WHERE
-- el operador IN verifica que el valor coincida con algun valor de una lista

-- show the details of orders made by costumers in Germany
-- mostrar los detalles de pedidos hechos por clientes en alemania

select
*
from Sales.Orders
where CustomerID IN (select CustomerID from Sales.Customers where Country like '%Germany%')

-- mostrar los detalles de los que NO estan en alemania

select
*
from Sales.Orders
where CustomerID NOT IN (select CustomerID from Sales.Customers where Country like '%Germany%')

-- SUBCONSULTAS CON ANY | ALL

-- encontrar los empleados femeninos los cuales sus salarios sean mas grandes que los de empleados masculinos

select EmployeeID,FirstName,Salary from Sales.Employees
where Gender like '%F%' and (Salary > ANY (select Salary from Sales.Employees where Gender like '%M%'))

-- encontrar los empleados femeninos los cuales sus salarios sean mas grandes que los de todos los empleados masculinos

select EmployeeID,FirstName,Salary from Sales.Employees
where Gender like '%F%' and (Salary > ALL (select Salary from Sales.Employees where Gender like '%M%'))

-- SUBCONSULTAS CORRELACIONADAS Y NO CORRELACIONADAS

-- ya estudiado, teoria de ramakrishnan 3ra edicion para mas informacion pero nunca esta demas saberlo
-- ejemplo sencillo

-- mostrar todos los detalles de clientes y encontrar el total de ordenes para cada cliente
-- 
-- en este caso se necesita un escalar POR CADA VALOR de la tabla clientes
-- y el exists no tendria sentido porqe es usado para verificar existencias o coincidencias
-- mucho menos tendria sentido en el from porque no hay forma de correlacionarlas

select 
*, (select count(*) from Sales.Orders o where o.CustomerID = c.CustomerID) total_por_pedido
from sales.Customers c

 -- SUBCONSULTA CON EXISTS

 -- en este git me pasare haciendo decenas de docs con muchos haciendo esto asi que, si lees esto
 -- que tengas un lindo dia

 -- 