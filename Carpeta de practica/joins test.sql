select c.id, c.first_name, o.order_id, o.sales 
from customers c inner join orders o
on c.id = o.customer_id

select * from customers
select * from orders

/* hallar todos los compradores que tengan pedidos 
incluidos aquellos que no tengan pedidos*/

select c.id,c.first_name, o.order_id, o.sales
FROM customers c LEFT JOIN  orders o
on c.id = o.customer_id

/*obtener todos los clientes que tengan pedidos incluidos 
aquellos pedidos que no tengan clientes coincidentes*/

select c.id,c.first_name, o.order_id, o.sales
FROM customers c RIGHT JOIN  orders o
on c.id = o.customer_id

select *
FROM customers  c, orders o



select c.id,c.first_name, o.order_id, o.sales
FROM customers c FULL JOIN  orders o
on c.id = o.customer_id


/* Obtener todos los clientes que no han realizado ningun pedido */

SELECT c.id, c.first_name, o.order_id, o.sales
FROM customers c LEFT JOIN orders o 
on c.id = o.customer__id

/* SELF JOIN */
--existe un caso particular que no muchas veces se da en las consultas de BD pero si que existe y si se da que es el self join
-- o prodcuto cruzado de la tabla consigo misma para lograr el resultado de la consulta sin hacer muchas subconsultas complejas