-- muestra la jerarquia de empleados mostrando el nivel
-- de cada empleado dentro de la organizacion
with CTE_jerarquia as(
-- consulta ancla
	select
		EmployeeID,
		FirstName,
		ManagerID,
		Department,
		1 as lvl
	from Sales.employees
	where ManagerID is Null
	UNION ALL
	-- RECURSIVA
	select
		e.EmployeeID,
		e.FirstName,
		e.ManagerID,
		e.Department,
		lvl + 1
		-- en la primera iteracion ancla es 1 y en las
		-- sucesivas sera 1 + la que sigue al gerente
	from Sales.Employees as e
	inner join CTE_jerarquia as cte
		-- es porque NECESITO SOLO AQUELLOS QUE SON COINCIDENTES
		-- basicamente estoy haciendo un self join para obtener 
		-- con la propia tabla para obtener la jerarquia pero con recursividad
	on e.ManagerID = cte.EmployeeID

)


-- consulta principal
select * from CTE_jerarquia


