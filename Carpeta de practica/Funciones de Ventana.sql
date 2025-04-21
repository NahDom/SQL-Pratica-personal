/* Window Functions o funciones ventana */
-- cuando solo agrupar por algo los datos no es suficiente
use SalesDB;
--nota
-- el resultado de la granularidad: el numero de filas en la salida es definido por la dimension

-- Hallar el total de ventas para todos los productos (sin particiones seria este caso)
-- Hallar el total de ventas para CADA producto (aqui si hay particiones)
-- adicionalmente proveer detalles como ID pedido y la fecha del pedido
-- hallar el total de ventas para cada combinacion de productos y estado de pedido

select 
	OrderID,
	OrderDate,
	ProductID,
	OrderStatus,
	sales,--mayor nivel de granularidad aqui tenemos los datos de ventas de productos
	SUM(Sales) Over() VentasTotales, -- en este caso tenemos el mayor nivel de agregacion con las ventas totales 
	-- de todos los pedidos
	SUM(Sales) Over(Partition by ProductID) VentasTotalesXProducto, --este es un caso intermedio
	--ya que nos permite agrupar cada venta de producto en ventanas
	-- como observacion es de ver que la tabla 
	-- se particiona en 4 ventanas divididas en cada producto
	SUM(Sales) Over(Partition by ProductID, OrderStatus) TotalCombinado
from Sales.Orders


/*Order by*/
--clasifica cada orden basada en sus ventas desde la mas alta a la mas baja
select
OrderID,
ProductID,
Sales,
OrderDate,
sum(sales) over() as tot, --son lo mismo
SUM(Sales) over(order by OrderDate rows between unbounded preceding and unbounded following) as meses
from Sales.Orders

select
OrderID,
ProductID,
Sales,
OrderStatus,
SUM(Sales) over(partition by OrderStatus
order by OrderDate rows 2 preceding) as meses
-- solo funcona con preceding
from Sales.Orders

-- clasificar a los clientes (RANK) basados en su total de ventas

select
CustomerID,
sum(Sales) totalsales,
rank() over(order by sum(sales) desc) rank_customers
from Sales.Orders
group by CustomerID

--comentario de prueba