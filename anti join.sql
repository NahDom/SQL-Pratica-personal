/* Obtener todos los clientes que no han realizado ningun pedido */

SELECT *
FROM customers c full JOIN orders o
on c.id = o.customer_id
WHERE o.customer_id IS NULL OR  c.id is null

/* Obtener todos los pedidos sin clientes coincidentes */

SELECT * 
FROM orders o LEFT JOIN  customers c
on o.customer_id = c.id
where c.id is null

/* Devuelve todos los compradores con sus ordenes pero solo aquellos que realizaron una orden
realizar sin INNER JOIN */

SELECT * 
FROM customers c left join orders o
on c.id = o.customer_id
where o.customer_id is not null

SELECT c.id, o.customer_id 
FROM customers c, orders o