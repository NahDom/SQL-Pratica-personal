/* STORED PROCEDURES 
	Consejo: en proyectos muy grandes no es recomendable tenerlos
	debido a que el testeo del codigo puede volverse muy complejo con el tiempo
*/

-- encuentre el total de clientes de USA y su puntuacion promedio
-- para reescribirla de forma reiterada la puedo convertir en un SP
CREATE PROCEDURE Clientes_USA AS
BEGIN
	select 
		count(*) total_clientes,
		avg(Score) total_score
	from sales.Customers
	where country = 'USA'
END

exec Clientes_USA -- siempre que lo necesito lo llamo a la
				  -- funcion almacenada

