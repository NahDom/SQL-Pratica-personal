-- Connect to the default database (typically postgres)
\c postgres

-- Drop the SalesDB database if it exists and then create it.
DROP DATABASE IF EXISTS "SalesDB";
CREATE DATABASE "SalesDB";

-- Connect to the newly created database.
\c "SalesDB"

-- Drop the Sales schema if it exists (CASCADE drops dependent objects) and create a new one.
DROP SCHEMA IF EXISTS "Sales" CASCADE;
CREATE SCHEMA "Sales";

-- ======================================================
-- Table: Customers
-- ======================================================
CREATE TABLE "Sales".Customers (
    CustomerID INT NOT NULL,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Country VARCHAR(50),
    Score INT,
    CONSTRAINT pk_customers PRIMARY KEY (CustomerID)
);

INSERT INTO "Sales".Customers (CustomerID, FirstName, LastName, Country, Score) VALUES
    (1, 'Jossef', 'Goldberg', 'Germany', 350),
    (2, 'Kevin', 'Brown', 'USA', 900),
    (3, 'Mary', NULL, 'USA', 750),
    (4, 'Mark', 'Schwarz', 'Germany', 500),
    (5, 'Anna', 'Adams', 'USA', NULL);

-- ======================================================
-- Table: Employees
-- ======================================================
CREATE TABLE "Sales".Employees (
    EmployeeID INT NOT NULL,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    BirthDate DATE,
    Gender CHAR(1),
    Salary INT,
    ManagerID INT,
    CONSTRAINT pk_employees PRIMARY KEY (EmployeeID)
);

INSERT INTO "Sales".Employees (EmployeeID, FirstName, LastName, Department, BirthDate, Gender, Salary, ManagerID) VALUES
    (1, 'Frank', 'Lee', 'Marketing', '1988-12-05', 'M', 55000, NULL),
    (2, 'Kevin', 'Brown', 'Marketing', '1972-11-25', 'M', 65000, 1),
    (3, 'Mary', NULL, 'Sales', '1986-01-05', 'F', 75000, 1),
    (4, 'Michael', 'Ray', 'Sales', '1977-02-10', 'M', 90000, 2),
    (5, 'Carol', 'Baker', 'Sales', '1982-02-11', 'F', 55000, 3);

-- ======================================================
-- Table: Products
-- ======================================================
CREATE TABLE "Sales".Products (
    ProductID INT NOT NULL,
    Product VARCHAR(50),
    Category VARCHAR(50),
    Price INT,
    CONSTRAINT pk_products PRIMARY KEY (ProductID)
);

INSERT INTO "Sales".Products (ProductID, Product, Category, Price) VALUES
    (101, 'Bottle', 'Accessories', 10),
    (102, 'Tire', 'Accessories', 15),
    (103, 'Socks', 'Clothing', 20),
    (104, 'Caps', 'Clothing', 25),
    (105, 'Gloves', 'Clothing', 30);

-- ======================================================
-- Table: Orders
-- ======================================================
CREATE TABLE "Sales".Orders (
    OrderID INT NOT NULL,
    ProductID INT,
    CustomerID INT,
    SalesPersonID INT,
    OrderDate DATE,
    ShipDate DATE,
    OrderStatus VARCHAR(50),
    ShipAddr
