CREATE DATABASE BD_SQL_2025; -- base de datos aislada para hacer los ejercicios
USE BD_SQL_2025;
/* Comandos DDL para las tablas de la guia SQL */

-- ===================================
-- ESQUEMA 1: PROVEEDORES
-- ===================================

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

-- ===================================
-- ESQUEMA 2: AEROLÍNEAS
-- ===================================

CREATE TABLE Empleados (
    eid INT,
    ename VARCHAR(50),
    salary INT,
    PRIMARY KEY (eid)
);

CREATE TABLE Avion (
    aid INT,
    aname VARCHAR(50),
    cruisingrange INT,
    PRIMARY KEY (aid)
);

CREATE TABLE Vuelos (
    flno INT,
    from_city VARCHAR(50),
    to_city VARCHAR(50),
    distance INT,
    departs TIME,
    arrives TIME,
    PRIMARY KEY (flno)
);

CREATE TABLE Certificados (
    eid INT,
    aid INT,
    FOREIGN KEY (eid) REFERENCES Empleados(eid),
    FOREIGN KEY (aid) REFERENCES Avion(aid),
    PRIMARY KEY (eid, aid)
);


-- ===================================
-- ESQUEMA 3: UNIVERSIDAD
-- ===================================

CREATE TABLE Faculty (
    fid INT,
    fname VARCHAR(50),
    deptid INT,
    PRIMARY KEY (fid)
);

CREATE TABLE Student (
    snum INT,
    sname VARCHAR(50),
    major VARCHAR(50),
    level VARCHAR(20),
    age INT,
    PRIMARY KEY (snum)
);

CREATE TABLE Class (
    name VARCHAR(50),
    meets_at VARCHAR(50),
    room VARCHAR(20),
    fid INT,
    FOREIGN KEY (fid) REFERENCES Faculty(fid),
    PRIMARY KEY (name)
);

CREATE TABLE Inscripto (
    snum INT,
    cname VARCHAR(50),
    FOREIGN KEY (snum) REFERENCES Student(snum),
    FOREIGN KEY (cname) REFERENCES Class(name),
    PRIMARY KEY (snum, cname)
);


-- ===================================
-- ESQUEMA 4: EMPRESA
-- ===================================

CREATE TABLE Emp (
    eid INT,
    ename VARCHAR(50),
    age INT,
    salary DECIMAL(10, 2),
    PRIMARY KEY (eid)
);

CREATE TABLE Dept (
    did INT,
    dname VARCHAR(50),
    budget DECIMAL(12, 2),
    managerid INT,
    FOREIGN KEY (managerid) REFERENCES Emp(eid),
    PRIMARY KEY (did)
);

CREATE TABLE Works (
    eid INT,
    did INT,
    pct_time INT,
    FOREIGN KEY (eid) REFERENCES Emp(eid),
    FOREIGN KEY (did) REFERENCES Dept(did),
    PRIMARY KEY (eid, did)
);
