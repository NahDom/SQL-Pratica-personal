--  Anaizar el rendimiento de ventas a lo largo del tiempo

	SELECT 
	-- extraigo el a�o
	YEAR(order_date) AS ordenes_por_anio,
	-- puedo agrupar tanto por a�o o la fecha del tipo que necesito o por el campo de totalizador
	SUM(sales_amount) as ventas_totales,
	COUNT(DISTINCT customer_key) as total_compradores,
	SUM(quantity) as total_cantidades
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY YEAR(order_date)
	ORDER BY YEAR(order_date)