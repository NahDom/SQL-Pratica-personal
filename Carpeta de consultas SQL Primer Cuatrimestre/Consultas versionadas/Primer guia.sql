/* Varias formas de resolucion*/

/*
1. Encuentre los snombres de Proveedores que provean alguna parte roja. 
2. Encuentre los sids de Proveedores que provean alguna red o parte verde. 
3. Encuentre los sids de Proveedores que provean alguna parte roja o vivan en 
“221 Packer Street”. 
4. Encuentre los sids de Proveedores que provean alguna parte roja Y alguna 
parte verde. 
5. Encuentre los sids de Proveedores que provean cada parte. 
6. Encuentre los sids de Proveedores que provean cada parte roja. 
7. Encuentre los sids de Proveedores que provean cada parte verde o roja. 
8. Encuentre los sids de Proveedores que provean cada parte roja o provean 
cada parte verde. 
9. Encuentre los pares de sids tal que los Proveedores con el primer sid cueste 
mas por alguna parte que los proveedor del segundo sid. 
10. Encuentre los pids de partes provista por al menos dos proveedores diferentes. 
11. Encuentre los pids de las aprtes mas caras provistas por el proveedor llamado 
Yosemite Sham. 
12. Encuentre los pids de partes provistas por cada proveedor a menos que $200. 
(Si algún proveedor no provee las partes o cuesta igual o más de $200, las 
partes no deberán ser listadas.) 
*/


-- 1

SELECT p.sname 
FROM proveedores p, partes par, catalogo c
WHERE p.sid = c.sid and c.pid = par.pid and par.color LIKE '%rojo%';

-- otros metodos

-- inner join on

SELECT p.sname 
FROM  catalogo c INNER JOIN proveedores p
			     ON p.sid = c.sid 
				 INNER JOIN partes par
				 ON c.pid = par.pid 
WHERE  par.color LIKE '%rojo%';

-- NATURAL JOIN
SELECT p.sname 
FROM  catalogo c NATURAL JOIN proveedores p
				 NATURAL JOIN partes par
WHERE  par.color LIKE '%rojo%';

-- CLAUSULA IN 

SELECT p.sname 
FROM  proveedores p
WHERE p.sid IN (
				SELECT c.sid
                FROM catalogo c, partes par 
                WHERE c.pid = par.pid AND par.color LIKE '%rojo%'
				)
ORDER BY p.sname DESC;

-- 2. Encuentre los sids de Proveedores que provean alguna red o parte verde. 
-- esta consulta es...tramposa

SELECT p.sid
FROM proveedores p, partes par, catalogo c
WHERE par.color LIKE '%rojo%' OR par.color LIKE '%verde%'
ORDER BY p.sid;

-- ====================================================
SELECT p.sid 
FROM  catalogo c INNER JOIN proveedores p
			     ON p.sid = c.sid 
				 INNER JOIN partes par
				 ON c.pid = par.pid 
WHERE  par.color LIKE '%rojo%' OR par.color LIKE '%verde%'
ORDER BY p.sid;
--
SELECT p.sid
FROM proveedores p, partes par, catalogo c
WHERE p.sid = c.sid and c.pid = par.pid and (par.color LIKE '%rojo%' OR par.color LIKE '%verde%')
ORDER BY p.sid;

-- USANDO LA UNION

SELECT p.sid AS alias_de_la_primer_consulta
FROM proveedores p, partes par, catalogo c
WHERE p.sid = c.sid and c.pid = par.pid and par.color LIKE '%rojo%' 
UNION
SELECT p2.sid
FROM proveedores p2, partes par2, catalogo c2
WHERE p2.sid = c2.sid and c2.pid = par2.pid and par2.color LIKE '%verde%'
ORDER BY alias_de_la_primer_consulta;

-- 3. Encuentre los sids de Proveedores que provean alguna parte roja o vivan en “221 Packer Street”. 

SELECT p.sid, p.addres
FROM proveedores p, partes par, catalogo c
WHERE p.sid = c.sid and c.pid = par.pid and (par.color LIKE '%rojo%' OR p.addres ='221 Packer Street')
ORDER BY p.sid;
 
 -- usando un natural join
SELECT p.sid, p.addres 
FROM  catalogo c NATURAL JOIN proveedores p
				 NATURAL JOIN partes par
WHERE  par.color LIKE '%rojo%' OR p.addres ='221 Packer Street'
ORDER BY p.sid;

-- inner join
 SELECT p.sid, p.addres 
FROM  catalogo c INNER JOIN proveedores p ON c.sid = p.sid
				 INNER JOIN partes par ON c.pid = par.pid
WHERE  par.color LIKE '%rojo%' OR p.addres ='221 Packer Street'
ORDER BY p.sid;

-- 4. Encuentre los sids de Proveedores que provean alguna parte roja and alguna parte verde. 
-- la siguiente consulta devolvera vacio porque no tiene con quien comparar
SELECT p.sid
FROM proveedores p, partes par1, partes par2, catalogo c1, catalogo c2
WHERE   p.sid = c1.sid 
	AND p.sid = c2.sid 
	AND par1.pid = c1.pid
	AND par2.pid = c2.pid  
    AND par1.color LIKE '%rojo%' 
    AND par2.color LIKE '%verde%'
ORDER BY p.sid;

-- notan algo?, la tabla de proveedores, ya que si lo ven bien solo necesitamos el sid y el sid ya esta en catalogo 
-- aunque no esta demas es otra forma de analizar los ejercicios
SELECT c1.sid
FROM partes par1, partes par2, catalogo c1, catalogo c2
WHERE   
	c1.sid = c2.sid 
	AND par1.pid = c1.pid
	AND par2.pid = c2.pid  
    AND par1.color LIKE '%rojo%' 
    AND par2.color LIKE '%verde%'
ORDER BY c1.sid;

-- usando una interseccion 
SELECT p.sid AS alias_de_la_primer_consulta
FROM proveedores p, partes par, catalogo c
WHERE p.sid = c.sid and c.pid = par.pid and par.color LIKE '%rojo%'
INTERSECT
SELECT p2.sid
FROM proveedores p2, partes par2, catalogo c2
WHERE p2.sid = c2.sid and c2.pid = par2.pid and par2.color LIKE '%verde%'
ORDER BY alias_de_la_primer_consulta;

-- ultimaS formas usando una interseccion Y joins 
SELECT p.sid AS alias_de_la_primer_consulta
FROM proveedores p NATURAL JOIN partes par NATURAL JOIN catalogo c
WHERE par.color LIKE '%rojo%'
INTERSECT
SELECT p2.sid
FROM proveedores p2 NATURAL JOIN partes par2 NATURAL JOIN catalogo c2
WHERE par2.color LIKE '%verde%'
ORDER BY alias_de_la_primer_consulta;

-- ultimaS formas usando una interseccion Y joins 
SELECT p.sid AS alias_de_la_primer_consulta
FROM catalogo c INNER JOIN partes par ON par.pid = c.pid
				INNER JOIN proveedores p ON p.sid = c.sid
WHERE par.color LIKE '%rojo%'
INTERSECT
SELECT p2.sid
FROM catalogo c2 INNER JOIN partes par2 ON par2.pid = c2.pid
				INNER JOIN proveedores p2 ON p2.sid = c2.sid
WHERE par2.color LIKE '%verde%'
ORDER BY alias_de_la_primer_consulta;
--
-- Ahora, ¿que pasaria si la planteo por medio de saber si existe algun empleado con ese sid que ha vendido alguna parte 
-- roja y verde?
-- Si lo piensan bien no tendriamos muchas formas de correlacionar, las claves desde la tabla proveedores
-- pero si de catalogo a partes y de ahi tenemos el SID de los proveedores RELACIONADOS a los catalogos
SELECT c.sid
FROM catalogo C NATURAL JOIN partes par
-- Que esta pasando aqui?, por medio de la primer consulta yo necesito ver cuales son de color rojo
-- Y por medio del EXISTS voy a verificar si EXISTE alguna coincidencia con el VERDE 
WHERE par.color LIKE '%rojo%' AND EXISTS (
										 SELECT 1 FROM catalogo C1 NATURAL JOIN partes p2
                                         WHERE p2.color LIKE '%verde%' AND c1.sid = c.sid)
													-- es aqui donde hacemos la correlacion
ORDER BY c.sid;

/* LA DIVISION...
	5. Encuentre los sids de Proveedores que provean cada parte. 
	6. Encuentre los sids de Proveedores que provean cada parte roja. 
	7. Encuentre los sids de Proveedores que provean cada parte verde o roja. 
	8. Encuentre los sids de Proveedores que provean cada parte roja o provean 
	cada parte verde.
*/
/*
 La clave a veces viene de la interpretacion de la consigna, en la susodicha tenemos los proveedores que dan cada parte
 la cuestion aqui serian, al menos para la situacion planteada
 Un proveedor p provee todas las partes si no existe ninguna parte par que no esté en el catálogo de p osea de proveedores.
 entonces siguiendo la logica que veniamos viendo en la catedra tendriamos 2 situaciones de resolucion
*/

-- Con EXCEPT
SELECT p.sid 
FROM proveedores p
WHERE NOT EXISTS (
				 SELECT par.pid FROM partes par
                 EXCEPT
                 SELECT c.pid FROM catalogo c
                 WHERE c.sid = p.sid
                 );
                 
-- Pero para estar mas seguros haremos con WHERE NOT EXISTS 
-- el cual funcionaria de la siguiente manera: 

SELECT p.sid 
FROM proveedores p
WHERE NOT EXISTS (
				  SELECT 1 FROM partes par
				  WHERE NOT EXISTS (
									SELECT 1 FROM catalogo c
									WHERE c.pid = par.pid AND c.sid = p.sid
				 )
				 );
/*
	¿Cual es la logica detras de la anterior consulta?
    
    - La subconsulta interna busca partes que no estén asociadas al proveedor actual.
	- La subconsulta externa excluye proveedores que tienen alguna parte faltante.
	- El resultado: solo proveedores que tienen todas las partes.

-- para el escenario con los datos que proveimos no todos los proveedores tienen relación con todas las partes, por ende el resultado sera vacio
*/

-- ¿Como sabemos si lo siguiente es cierto? 
-- Bueno las partes relacionadas a proveedores estan en el catalogo, podriamos contar cuantas coincidencias tendra cada
-- proveedor en la tabla y ordenarlo a la salida

SELECT sid, COUNT(DISTINCT(pid)) cantidad_de_partes_por_proveedor
FROM catalogo
GROUP BY sid
ORDER BY sid,cantidad_de_partes_por_proveedor;

-- PUNTO 6
SELECT p.sid 
FROM proveedores p
WHERE NOT EXISTS (
				  SELECT 1 FROM partes par
                  WHERE par.color LIKE '%rojo%' AND NOT EXISTS (
									SELECT 1 FROM catalogo c
									WHERE c.pid = par.pid AND c.sid = p.sid
				 )
				 );
                 
SELECT sid, COUNT(DISTINCT(c.pid)) cantidad_de_partes_por_proveedor
FROM catalogo c LEFT JOIN partes par ON c.pid = par.pid 
-- realizo left join para buscar coincidencia de claves de pid para obtener el color de cada pid
WHERE par.color LIKE '%verde%'
GROUP BY sid
ORDER BY sid;
