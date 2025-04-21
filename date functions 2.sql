/* Cuantos pedidos se realizaron cada a�o */
select
	 year(OrderDate) anioo_Pedidos
    ,COUNT(*) Numero_de_pedidos
from Sales.Orders
group by year(OrderDate);

/* cuantos pedidos se realizaron cada mes del a�o */
select
	 datename(month,OrderDate) mes_Pedidos
    ,COUNT(*) Numero_de_pedidos
from Sales.Orders
group by  datename(month,OrderDate);

/* Muestra todos los pedidos que se realizaron durante el mes de febrero */
select 
	*
	--count(*) cantidad_de_ordenes_realizadas
from Sales.Orders
where MONTH(OrderDate) = 2;

/*FORMAT EXAMPLES*/

select
 OrderID,
 CreationTime,
 FORMAT(CreationTime,'dd') dd,
 FORMAT(CreationTime,'ddd') dd,
 FORMAT(CreationTime,'MMMM') mm,
 FORMAT(CreationTime,'yyyy') YY
from Sales.Orders;

/*Muestra el campo Creation time con el siguiente formato
Day Lun Ene Q1 2025 12:31:56 PM	*/
select
	 OrderID,
	 CreationTime,
	 'Dia ' + FORMAT(CreationTime,'ddd MMM') + ' Q' +
	 DATENAME(QUARTER, CreationTime) + ' ' + 
	 FORMAT(CreationTime,'yyyy hh:mm:ss tt') as Formato_Solicitado
 from Sales.Orders;

 SELECT CONVERT(VARCHAR, GETDATE(), 100) AS HoraConAMPM;