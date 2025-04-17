-- La paginación divide los resultados de la consulta en conjuntos de registros más pequeños y más manejables. 
-- La paginación de resultados en SQL es más útil cuando se negocia con grandes conjuntos de datos. 
-- Porque los usuarios pueden ver y navegar por los resultados de forma gradual. 
-- Por lo tanto, usamos la cláusula 'LIMIT' y la cláusula 'OFFSET' para la paginación en SQL

-- ejemplo

select
*
from
(
    SELECT 
        id_emp,
		nombre nombre_emp,
        sum(salary) total_salario,
        -- su usas una agregacion debes usarla en la ventana
        rank() over(order by sum(salary) desc) salario_mas_alto
    from employee
    GROUP BY id_emp,nombre
) t
where salario_mas_alto = 1

-- paginacion 

-- usando LIMIT(), Pero NO EXISTE EN SQL SERVER solo de MySQL y es limit row_number offset row_number
-- tenemos otra variante llamada offset row_number fetch 
-- prefiero row_number
-- generalmente se usan con tablas de tipo temporal, por ejemplo usando with table as (consulta)
-- en este caso quiero los primeros 5 empleados de la tabla de 10 empleados

-- resolucion por medio de una subconsulta y row_number() para extraer la lista de empleados
select *
from(
select 
	row_number() over(order by salary desc) fila_test,
	id_emp,
	nombre,
	salary
from employee
)t
where fila_test between 1 and 5

-- ajusto la consulta para hacerlo sin subquery que seria usando una tabla temporal

with paginado as(
	select 
		row_number() over(order by salary desc) fila_test,
		id_emp,
		nombre,
		salary
	from employee
)
select * from paginado where fila_test between 1 and 5