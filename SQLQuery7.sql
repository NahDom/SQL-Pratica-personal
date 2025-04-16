/* Estudio de Nulos en SQL Server */

-- En esta seccion se estudiara todo lo relacionado a los NULL values y a su tratamiento

select 
	OrderID,
	ShipAddress,
	BillAddress,
	isnull(ShipAddress,BillAddress) [Funcion ISNULL - 2 argumentos],
	coalesce(ShipAddress,BillAddress, 'unknown') [Funcion Coalesce - acepta hasta 3 argumentos]
from Sales.Orders;

/*    CASOS DE USO DE MANEJO DE NULOS   */
/* IsNull | Coalesce */
-- Manejar el NULL antes de hacer agregaciones de datos en la BD
-- Supongamos que el negocio (como muchos otros entiende que el NULL es un 0 para el 
-- calculo de las ventas promedio por suponer el año o el mes
-- de dicha forma deberemos de manejar los nulos antes de proceder con cualquier otro analisis muchas veces

-- * en este caso debo hallar el score promedio de los vendedores
select
	CustomerID,
	Score,
	coalesce(Score,0) PuntacionCorregida,
	avg(Score) over() puntuacion_promedio,
	avg(coalesce(Score,0)) over() Puntuacion_Corregida
from Sales.Customers

/* Operaciones Matematicas*/

-- Manejar los valores NULOS antes de realizar operaciones matematicas
-- operaciones de numeros con valores NULOS
-- por ejemplo concatenacion con nulos y operaciones con valores nulos

-- ejercicio
-- Muestra el nombre completo de los vendedores en un solo campo uniendo su nombre y apellido (FirstName LastName)
-- y adhiriendo 10 puntos bonus a cada puntuacion del vendedor (Score)

select 
	CustomerID,
	FirstName,
	COALESCE(FirstName,'') Nombres,
	LastName,
	COALESCE(LastName,'') Apellidos, --con esta consulta de aqui verfico cuales contendrian nulos
	FirstName + ' ' + LastName as [Nombre Completo], -- sin verificar los nulos
	FirstName + ' ' + COALESCE(LastName,'') [Nombre completo -- Sol1], -- forma 1
	COALESCE(FirstName + ' ' + LastName,FirstName) as [Nombre Completo -- Sol2], -- verificando los nulos forma 2
	Score,
	COALESCE(Score,0) + 10  [Agregado de 10 puntos a la puntuacion] -- tratamiento de nulos para la operacion matematica
from Sales.Customers

/* JOINS Y VALORES NULOS */
-- Manejar los valores nulos antes de realizar JOINS entre tablas de la BD

/*  CASO DE USO  */
-- manejar los nulos antes de ordenar los datos

-- ejemplo
-- ordenar las puntuaciones de los vendedores de mas bajo a mas alto
-- con los nulos apareciendo al final

-- metodo 1 -- definir un valor estatico para ordenar
select
	CustomerID,
	Score,
	-- manejo perezoso 
	-- reemplazar los valores nulos por un valor MUY ALTO
	coalesce(Score,999999) [Puntuacion Corregida]
from sales.Customers
-- group by CustomerID recuerda que solo puede usarse si hay una funcion de agregado
order by coalesce(Score,999999)

-- metodo 2 "Mas profesional" usando el CASE

select
	CustomerID,
	Score
   /*CASE 
     WHEN Score IS NULL THEN 1
	 ELSE 0
	END Booleano */ --> ira en la clausula order by
from sales.Customers
order by CASE WHEN Score IS NULL THEN 1 ELSE 0 END,Score
-- RESULTA SER!, que puede ordenarse por varias condiciones
-- por ejemplo en el caso de abajo lo que hace el motor SQL es que
-- va a ordenar los datos por la condicion booleana y los empuja al final
-- y una vez que esos valores estan ordenados, SQL va a ordenar los datos por la puntuacion 

/* NULL IF*/

-- Compara dos expesiones y devuelve:
-- NULO, si ambas son iguales
-- De otra forma devuelve el primer valor si no son iguales
-- sintax
--		NULLIF(valor1,valor2)
-- ejemplo
--	    NULLIF(ShipAddress, 'unknown')
--		NULLIF(ShipAddress, BillAdress)

select
 OrderID,
 ShipAddress,
 BillAddress,
 NULLIF(ShipAddress,BillAddress)
 from Sales.Orders

 /*CASO ESPECIAL: division por cero*/
 -- basicamente prevenir el error de dividir por cero
 -- Encontrar
 -- Encontrar el precio de venta para cada pedido dividiendo las entas por la cantidad
 -- dividir sales por quantity
 -- precio = ventas / cantidad
 -- en este caso si la cantidad es 0 no puede dividirse por la venta ya que eso no existe,
 -- de igual forma lo reemplazo por el NULL antes que haya un 0 y de indeterminado
 
 select
	OrderID,
	Sales,
	Quantity,
	Sales / nullif(Quantity,0) Precio
from Sales.Orders

/*IS NULL VS IS NOT NULL*/
-- IS NULL devuelve TRUE si el valor es nulo o null en caso contrario FALSO
-- y IS NOT NULL devuelve TRUE si no es NULL y si es NULL devuelve FALSO
-- se usa en la clausula WHERE 

/* CASO DE USO -- FILTRADO DE DATOS */
/* buscar por informacion faltante o la busqueda de valores nulos*/

--ejemplo
-- identificar a los vendedores que no tienen puntuacion

select 
	CustomerID ID,
	FirstName [Nombre del vendedor],
	Score
from Sales.Customers
where Score IS NULL

-- listar todos los clientes que tengan puntuacion

select 
	CustomerID ID,
	FirstName [Nombre del vendedor],
	Score
from Sales.Customers
where Score IS NOT NULL

/*caso de uso -- anti joins*/
/* LEFT ANTI JOIN | RIGHT ANTI JOIN */
-- Nos ayudan a encontrar las filas no coincidentes entre dos tablas

-- ejemplo
-- listar todos los pedidos de clientes que no tengan ningun pedido

select
	c.*,
	o.OrderID
from Sales.Customers c 
	 LEFT JOIN Sales.Orders o 
	 on c.CustomerID = o.CustomerID
	 where o.CustomerID is null

	 /*	 Null vs Empty Strings vs Blank Spaces	*/
select 
	CustomerID,
	FirstName,
	LastName,
	len(FirstName) tamaño_nombre,
	len(LastName) tamaño_apellido,
	FirstName + coalesce(LastName,'') NombreCompleto_1,
	DATALENGTH(FirstName + coalesce(LastName,'')) [Nombre completo sin espacio],
	FirstName + ' ' + coalesce(LastName,'') NombreCompleto_2,
	DATALENGTH(FirstName + ' ' + coalesce(LastName,'')) [Nombre completo sumado el espacio]
from Sales.Customers

-- en todos los casos sume un espacio en blanco para el nombre o lo quite para ver la variacion del tamaño