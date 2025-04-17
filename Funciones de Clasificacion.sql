/* RANK FUNCTIONS */

-- ROW_NUMBER()

-- EJERCICIOS
--
-- calsificar los pedidos basados en sus ventas de mayor a menor

select
	orderid,
	productid,
	sales,
	row_number() over(order by sales desc) [funcion row_number],
	rank() over(order by sales desc) [funcion rank],
	dense_rank() over(order by sales desc) [funcion dense_rank]
from Sales.Orders

-- ================================================================

/* 4 CASOS DE USO PARA ROW_NUMBER() */

-- 1 . TOP N-ANALYSIS
-- util para hallar indicadores de desempeño o KPI

-- Find the top highest sales for each product
-- hallar el mayor valor de venta para cada producto

--como solo necesito 1 por cada ventana recurrimos nuevamente a la confiable subquery
select 
*
from
(
	select 
		OrderID,
		ProductID,
		Sales,
		row_number() over(partition by productid order by sales desc) [TOP N-ANALYSIS]
	from Sales.Orders
)t
where [TOP N-ANALYSIS] = 1  
 
-- 2. BOTTOM N-ANALYSIS

-- encontrar los 2 clientes mas bajos basados en sus ventas totales
select
*
from
(
	select
	-- paso 1 añadir una clausula GROUP BY
		CustomerID,
		sum(Sales) ventas_totales,
		row_number() over(order by sum(sales) asc) lowest_customers
		-- REGLA IMPORTANTE: si usas una funcion de ventana junto con una funcion 
		-- group by, debes de usar solo las columnas que se usan en el group by, que serian aquellas
		-- que son agregadas
	from Sales.Orders
	group by CustomerID
)t
where lowest_customers < 3

-- 3. generar ids unicos
-- ejemplo sencillo
select
	ROW_NUMBER() over(order by OrderID) ID_unicos,
	*
from Sales.OrdersArchive

-- 4. Identificar duplicados

-- identificar filas duplicadas en la tabla OrdersArchive y devolver un resultado limpio sin ningun duplicado
select *
from(
select
	ROW_NUMBER() over(partition by OrderID order by CreationTime desc) rn,
	*
from Sales.OrdersArchive
)t
where rn > 1

/*NITLE Y BUCKETS*/

select
	OrderID,
	Sales,
	NTILE(1) over(order by Sales desc) un_bucket,
	NTILE(2) over(order by Sales  desc) dos_bucket,
	NTILE(3) over(order by Sales desc) tres_bucke,
	NTILE(4) over(order by Sales desc) cuatro_bucket
from sales.orders

/* caso de uso - segmentacion de datos, rol de analista de datos */

-- ejercicio: segmentar todos los pedidos en 3 categorias: altas, medias y bajas ventas
select 
*,
case when buckets = 1 then 'Alto'
	 when buckets = 2 then 'media'
	 when buckets = 3 then 'bajo'
end Categorias
from(
		select
			Orderid,
			sales,
			ntile(3) over(order by sales desc) buckets
		from Sales.Orders
)t

/*cume_dist y percent_rank*/

-- encontrar los productos que caen dentro del 40% de precios mas altos
-- CUME_DIST()
select 
	*,
	--formateo el valor
	concat(porcentaje_40 * 100, '%') cume_dist_perc,
	concat(porcentaje_40_2 * 100, '%') percent_rank_perc
from(
		select
			ProductID,
			Product,
			Category,
			price,
			CUME_DIST() over(order by price desc) porcentaje_40,
			PERCENT_RANK() over(order by price desc) porcentaje_40_2
		from Sales.Products
)t
where porcentaje_40 <= 0.4 and porcentaje_40_2 <= 0.25
-- explicacion de porque pasa lo de la consulta de arriba
select 
	product,
	price,
	category,
	CUME_DIST() over(order by price desc) porcentaje_de_precio,
	percent_rank() over(order by price desc) porcentaje_de_precio
from Sales.Products 
--order by CUME_DIST() over(order by price desc) 