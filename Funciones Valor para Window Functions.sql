/* LEAD() & LAG() */
/* CASO DE ESTUDIO - TIME SERIES ANALYSIS */
-- Analiza el rendimiento mes a mes o MoM, hallando el cambio porcentual en las ventas entre entre el mes actual y el siguiente
-- MoM analysis

-- paso 2 necesito ver la variacion mes a mes asi que resto el mes actual con el previo
select
	*,
	VentasActuales - VentasPrevias [cambio mes a mes - MoM],
	-- paso 3 la variacion porcentual, es decir el cambio mes a mes dividido los meses previos y multiplicado por 100
	-- puedo incluso convertirlo a float para mayor precision y usar round para tomar un valor mas exacto
	round(cast((VentasActuales - VentasPrevias) as float)/ VentasPrevias * 100,2) [Cambio porcentual MoM]
from(
select
	-- podria hacer un sum con order by pero eso no me dejaria puente a nada porque las
	-- funciones ventana no pueden anidarse
	-- asi que paso 1 uso group by
	MONTH(orderdate) Mes, -- campo por el cual se va a agrupar
	sum(sales) VentasActuales,
	-- uso la funcion LAG() para los meses previos
	lag(sum(sales)) over(order by MONTH(orderdate)) VentasPrevias
from Sales.Orders
group by MONTH(orderdate)
)t

/* CASO DE ESTUDIO CUSTOMER RETENTION - retencion de clientes */

-- para analizar la lealtad de los clientes clasifique a los clientes 
-- en funcion del promedio de dias entre sus pedidos
--
-- no necesitamos la cantidad de dias sino el periodo de tiempo que existe entre esos dias
-- es decir con LEAD() podemos calcular cuantos dias hay entre el actual y los siguientes o meses o semanas inclusive
--
select
-- en este caso se uso un group by simple para agrupar los promedios AVG segun los clientes
-- luego se los clasifica RANK() en funcion del promedio de dias entre pedidos, justamente 
-- la columna --> DiasHastaProxOrden equivale al resultado de restar la fecha proxima menos la actual
CustomerID,
AVG(DiasHastaProxOrden) DiasPromedio,
RANK() over(order by coalesce(AVG(DiasHastaProxOrden),99999)) Clasificacion_promedio
from(
select
	OrderID,
	CustomerID,
	OrderDate,
	OrderDate PedidoActual,
	-- funcion LEAD() para realizar la busqueda del siguiente pedido 
	LEAD(OrderDate) over(partition by customerid order by orderdate) PedidoSig,
	DATEDIFF(day,OrderDate,LEAD(OrderDate) over(partition by customerid order by orderdate)) DiasHastaProxOrden
 -- DATEDIFF(date,start_date,end_date)
from Sales.Orders
)t
group by CustomerID

/* FIRST_VALUE & LAST_VALUE */

-- hallar el valor mas bajo y mas alto de ventas para cada producto
-- hallar la diferencia entre las ventas actuales y las ventas mas bajas
select
	orderid,
	productid,
	sales,
	FIRST_VALUE(sales) over(partition by productid order by sales) valor_mas_bajo,
	-- usando last_value pero definiendo correctamente el marco
	LAST_VALUE(sales) over(partition by productid order by sales
	rows between current row and unbounded following) Valor_mas_alto,
	-- ==================================================================
	sales - FIRST_VALUE(sales) over(partition by productid order by sales) as Resta_ventas,
	-- ==================================================================
	-- Otra forma mas curiosa y sencilla de hacerlo seria tomar el first_value y viendo que como
	-- funciona dando por defecto de abajo hacia arriba si lo doy vuelta me da lo mismo que last_value...
	FIRST_VALUE(sales) over(partition by productid order by sales desc) valor_mas_alto2,
	-- incluso se puede usar el MAX y MIN
	max(sales) over(partition by productid) Valor_mas_alto3,
	min(sales) over(partition by productid) Valor_mas_bajo2
from Sales.Orders
