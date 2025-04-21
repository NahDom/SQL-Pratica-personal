
 /*Por ejemplo cuantos pedidos tenemos en un mes o un año*/
select 
	datetrunc(year,CreationTime)
	,count(*)
from
	Sales.Orders
group by datetrunc(year,CreationTime)