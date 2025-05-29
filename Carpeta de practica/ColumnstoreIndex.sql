/* Indices agrupados y no agrupados */

--Create a clustered index on DBCustomers

CREATE CLUSTERED COLUMNSTORE INDEX IDX_DBCustomers_CS ON Sales.DBCustomers

-- maximo un clustered index por tabla
DROP INDEX IDX_DBCustomers_CS ON Sales.DBCustomers
-- non clustered, dara error ya que independientemente de si es agrupado o no agrupado solo puede crearse uno por tabla
-- y queda en nosotros decidir de que tipo sera si es uno o si es otro
-- Azure sql te permite crear varios no agrupados pero eso es por el funcionamiento en la nube de la base de datos

CREATE NONCLUSTERED COLUMNSTORE INDEX IDX_DBCustomers_CS_FirstName ON Sales.DBCustomers (FirstName)
