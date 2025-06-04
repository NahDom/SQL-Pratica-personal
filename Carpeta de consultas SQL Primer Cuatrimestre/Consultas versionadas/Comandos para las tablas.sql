CREATE DATABASE BD_SQL_2025; -- base de datos aislada para hacer los ejercicios
USE BD_SQL_2025;
/* Comandos DDL para las tablas de la guia SQL */

--PUNTO 1

CREATE TABLE Proveedores(
	sid INTEGER Primary KEY,
    sname VARCHAR(150),
    addres VARCHAR(150)
);
CREATE TABLE Partes(
    pid INTEGER PRIMARY KEY, 
    pname VARCHAR(120), 
    color VARCHAR(120)
); 
CREATE TABLE Catalogo(
    sid INTEGER, 
    pid INTEGER, 
    cost DECIMAL(10,2) NOT NULL,
    PRIMARY KEY(sid, pid),
    FOREIGN KEY (sid) REFERENCES Proveedores (sid),
    FOREIGN KEY (pid) REFERENCES Partes (pid)
);

-- PUNTO 2