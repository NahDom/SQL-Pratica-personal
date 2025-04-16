/* Sentencia CASE WHEN */

-- Clasificar las ventas por alto, medio o bajo

select 
	OrderID,
	Sales Ventas,
	case 
		when Sales > 50 then 'Alto'
		when Sales > 20 then 'Medio'
		else 'Bajo'
	end [Categoria de Ventas]
from Sales.Orders
order by Sales desc



/* Casos de uso - Transformacion de datos*/
-- Uno de los propositos principales es el de derivar nueva informacion
-- Crear nuevas columnas basadas en los datos existentes

-- Ordenando de bajo a alto

select
	Categoria,
	SUM(Ventas) [Ventas Totales]
	-- Cuando llamo a la subconsulta en una agregacion debo de llamar 
	-- a la columna RENOMBRADA para poder hacer correctamente 
	-- el agrupamiento
from(
	select 
		OrderID,
		-- Sales renombrada debe ser llamada en el nivel mas alto
		-- de la consulta
		Sales Ventas,
		case 
			when Sales > 50 then 'Alto'
			when Sales > 20 then 'Medio'
			else 'Bajo'
		end Categoria
	from Sales.Orders
)t
Group by Categoria
order by [Ventas Totales] DESC

/* caso de uso 2 -- mapear valores*/
-- Recuperar detallas del empleado con el genero mostrado como texto completo

select
	EmployeeID,
	Gender,
	FirstName,
	LastName,
	FirstName +' '+ Coalesce(LastName, '') [Nombre completo],
	case 
		when Gender = 'M' then 'Hombre'
		when Gender = 'F' then 'Mujer'
		else 'No Information'
	end Genero
from Sales.Employees

-- Recuperar detalles de clientes con el codigo de pais abreviado
--full format
select 
	CustomerID,
	FirstName,
	Country,
case
	when Country = 'USA' then 'US'
	when Country = 'Germany' then 'DE'
	end PaisesAbreviados,
case Country
-- quick formatcase Country
	when 'USA' then 'US'
	when 'Germany' then 'DE'
	end PaisesAbreviados2
from Sales.Customers

/*Manejar Nulls*/
-- A veces los valores nulls pueden conducir a resultados inexactos
-- lo cual puede inevitablemente conllevar a una pesima practica en la toma de decisiones del negocio

-- encontrar los valores promedio de los puntajes de los
-- clientes y tratar aquellos que aparezca con valor NULL como Cero (0)
-- adicionalmente proveer detalles como el CustomerID y el Apellido del cliente

select 
	CustomerID,
	LastName,
	Score as puntaje,
	avg(Score) OVER() [media de puntaje sin corregir], 
	-- esta es la media de puntaje normal del Score sin quitar el NULL
	-- ============================
	case
		when Score IS NULL then 0
		else Score
	end Puntaje_Corregido,
	-- ============================
	-- el de abajo es el PROMEDIO avg() de la columna
	-- Puntaje Corregido
	avg(
		case
			when Score IS NULL then 0
			else Score
		end
		) OVER() PuntuacionTotalCorregida
	-- =============================
from Sales.Customers
--=======================
--  acotacion de prueba
-- confirmo que los null si se suman al promedio 
-- y si, dan inconsistencias que si repercuten en el resultado final
select 
CustomerID, 
AVG(Score) Over() puntaje
from Sales.Customers
--========================
/*caso de uso 4 -- Agregaciones condicionales*/
-- Aplica funciones de agregación solo en subconjuntos de datos que cumplan ciertas condiciones
-- especial para analisis profundos

-- ejemplos

-- caso particular: Cuantas veces cada cliente ha realizado un pedido con ventas
-- mayores a 30

select 
CustomerID,
--paso 1 crear una condicion booleana (0,1) para marcar las filas que deban cumplir la condicion
--paso 2 contabilizar las filas que cumplan la condicion
--recordatorio: El CASE WHEN puede ser llamado en CUALQUIER parte de la consulta
-- inclusive las agregaciones
SUM(case
	when Sales > 30 then 1
	else 0
end) [Ordenes por cliente],
count(*) [Total de ordenes por cliente]
from Sales.Orders
Group by CustomerID


/*Funciones de agregado*/

select 
	CustomerID,
	count(*) total_ordenes,
	sum(sales) total_sales,
	avg(sales) avg_sales,
	max(sales) max_sale,
	min(sales) min_sales
from Sales.Orders
group by CustomerID


