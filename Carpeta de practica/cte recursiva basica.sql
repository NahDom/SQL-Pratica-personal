/* CTEs recursivos */

-- generar una secuencia de numeros desde el 1 al 20

with generador as(
	-- consulta ancla
	select 1 numero
	union all
	-- consulta recursiva
	select numero +1 from generador
	where numero < 100
	-- sale por 20 ya que el numero de iteracion es de 0 a 21
) 
select * from generador
option (maxrecursion 101)