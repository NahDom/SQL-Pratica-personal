/*
	Regla: por defecto el motor SQL no permite que se generen indices unicos en tablas con valores duplicados
	por ende se deberian de crear al momento de dise�ar la base de datos y de tener en cuenta que dicha columna solo sera unica
	Pero eso se da en EL DISE�O
	Por ejemplo la base de datos de Productos de SalesDB sabemos que los productos son unicos pero las categorias son variadas
*/


SELECT * FROM sales.Products

create unique nonclustered index idx_Products_prod on sales.Products (Product)

-- por ejemplo la creacion de este indice indicara al motor de SQL server que esa columna sera unica para los valores
-- pruebo con insertar un duplicado que se que dara error
INSERT INTO Sales.Products (ProductID, Product) Values (106, 'Caps')
/*
	Obviamente esto me dara el eror 2601 de sql server:
			'Msg 2601, Level 14, State 1, Line 15 
			Cannot insert duplicate key row in object 'Sales.Products' with unique index 'idx_Products_prod'. 
			The duplicate key value is (Caps).'
*/

-- Filtered Index
-- solo esta permitido para las RowStore idx
/*
	�Pero, Porque?
	"No se puede crear un �ndice filtrado en un �ndice columnstore."
	Razones:
	- Los �ndices columnstore est�n optimizados para el procesamiento por lotes y consultas anal�ticas, 
		lo que significa que escanean grandes cantidades de datos de manera eficiente. 
		En cambio, un �ndice filtrado es m�s �til para cargas de trabajo OLTP, donde se requiere un acceso selectivo a los datos.
	- Los �ndices columnstore ya logran una alta compresi�n y optimizaci�n del almacenamiento, 
	lo que hace que los �ndices filtrados sean redundantes en muchos casos.

*/
-- Por ejemplo solo quiero crear un indice para los clientes que se encuentren en USA

select * from Sales.Customers
where Country = 'USA'

-- en este caso quiero crear un indice para el filtrado solo de los clientes en EEUU
-- como por defecto es un indice que solo afecta a registros es de tipo ROWSTORE
-- y ademas es nonclustered
create nonclustered index idx_customers_country
on sales.customers (Country)
where Country = 'USA'
