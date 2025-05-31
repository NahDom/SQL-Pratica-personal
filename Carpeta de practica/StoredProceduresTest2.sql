-- pero y si necesito de alemania? y de EEUU?
-- podria crear un SP que contenga el parametro del pais que se encuentra en la columna
-- regla primordial al igual que los triggers solo pueden tener su propio batch de consulta
-- debido a que son codigo que debe ejecutarse
-- DROP PROCEDURE IF EXISTS Clientes_USA;
ALTER PROCEDURE Clientes_USA @Country NVARCHAR(50) = 'USA'
-- paso 1 definir los parametros con su tipo de dato
AS

BEGIN
	BEGIN TRY
		DECLARE @total_clientes INT, @total_score FLOAT;
		    -- ========================================
			-- Paso 1: preparando y limpiando datos
			-- Por ejemplo en esta BD tengo la condicion de VERIFICAR la existencia de NULLS
			-- dentro de los puntajes
			-- una forma muy basica es en la tabla objetivo verificar por medio de un select 1 if null
			-- SELECT 1 FROM Sales.Customers where score is null and Country = 'USA'
			-- Esto en practica profesional es absurdo ya que hace verificacion en batch, registro a registro
			-- y consume demasiados recursos solo para eso
			--=========================================
			IF EXISTS(SELECT 1 FROM Sales.Customers where score is null and Country = @Country)
			BEGIN
				print 'Actualizo nulos a 0'
				Update Sales.Customers
				SET score = 0
				where score is null and country = @Country
			END

			ELSE
			BEGIN
				print'No hay nulos encontrados'
			END
			-- ========================================
			-- paso 2.Generamiento de reportes
			select 
			-- AQUI!, yo defino cual sera el valor de la variable
			-- casi que como un pseudocodigo
			-- @Variable = Linea_Consulta
				 @total_clientes = count(*),
				@total_score = avg(Score)
			from sales.Customers 
			where country = @Country;

			-- Gracias a T-SQL puedo usar built in functions 
			-- ademas debo de cuidar como voy a mostrarlos ya que no es lo mismo
			-- mostrar solo un valor numerico a mezclarlo con un string
			Print 'Total de clientes de ' + @Country + ':' + CAST(@total_clientes AS NVARCHAR);
			Print 'Puntaje Medio de ' + @Country + ':' + CAST(@total_score AS NVARCHAR);

			-- ###  Sintaxis de CAST(Variable AS Valor)

			--puedo añadir multiples consultas dentro de los SP por medio del ;
			-- obviamente indicando el principio y final de cada consulta
			-- pero obviamente debo adaptar cada consulta con las variables y/o p parametros 
			-- definidos para el Store Procedure

			-- ahora bien yo puedo definir variables que me pueden ayudara dinamizar aun mas todo
			-- de manera que no siempre saldran varias resultados si no un resultado en forma dinamica
			-- un reporte mas automatizado
			-- ==============================================
			-- calculo del numero total de clientes y el promedio de punaje para un pais en especifico
			select 
				count(orderid) total_ordenes,
				sum(sales) total_ventas
			from sales.Orders o 
			left join sales.Customers c
			on o.CustomerID = o.CustomerID
			where country = @Country
	END TRY
	BEGIN CATCH
		-- =================
		-- Manejo de errores
		-- =================
		PRINT('Un error a ocurrido!.');
		PRINT('Mensaje de error: ' + ERROR_MESSAGE());
		PRINT('Numero del error: ' + CAST(ERROR_NUMBER() AS NVARCHAR));
		PRINT('Linea del error: ' + CAST(ERROR_LINE() AS NVARCHAR));
		PRINT('Error de procedimiento: ' + ERROR_PROCEDURE());
	END CATCH
END
GO

EXEC Clientes_USA;
EXEC Clientes_USA @Country = 'Germany';

/* MANEJO DE ERRORES 
	sintaxis
	BEGIN TRY
		sentencias sql que pueden estar causando el error
	END TRY

	Ahora para manejarlos

	BEGIN CATCH
		sentencias sql que tratan el error
	END CATCH
*/