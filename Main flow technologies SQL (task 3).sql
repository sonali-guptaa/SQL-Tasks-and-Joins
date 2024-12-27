-- Joins in SQL
-- Joins in SQL are used to combine rows from two or more tables based on a related column between them. 
-- They allow querying and retrieving data from multiple tables in a single statement by specifying conditions for matching rows.

create database main_task3;
use main_task3;

-- Defining table structures
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,       -- Unique identifier for each customer
    CustomerName VARCHAR(100),        -- Name of the customer
    ContactNumber VARCHAR(15)         -- Contact number of the customer
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,          -- Unique identifier for each order
    CustomerID INT,                   -- Foreign key referencing the Customers table
    OrderDate DATE,                   -- Date when the order was placed
    TotalAmount DECIMAL(10, 2),       -- Total amount of the order
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,        -- Unique identifier for each product
    ProductName VARCHAR(100),         -- Name of the product
    Price DECIMAL(10, 2)              -- Price of the product
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,    -- Unique identifier for each order detail
    OrderID INT,                      -- Foreign key referencing the Orders table
    ProductID INT,                    -- Foreign key referencing the Products table
    Quantity INT,                     -- Quantity of the product ordered
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Inserting values into these tables
-- Insert into Customers table
INSERT INTO Customers (CustomerID, CustomerName, ContactNumber)
VALUES
(1, 'John Doe', '1234567890'),
(2, 'Jane Smith', '0987654321');

-- Insert into Orders table
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES
(1, 1, '2024-12-01', 250.50),
(2, 2, '2024-12-02', 150.00);

-- Insert into Products table
INSERT INTO Products (ProductID, ProductName, Price)
VALUES
(1, 'Laptop', 800.00),
(2, 'Mouse', 25.50),
(3, 'Keyboard', 45.00);

-- Insert into OrderDetails table
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity)
VALUES
(1, 1, 1, 1), -- 1 Laptop in Order 1
(2, 2, 2, 2), -- 2 Mice in Order 2
(3, 2, 3, 1); -- 1 Keyboard in Order 2

-- Joins
-- INNER JOIN: Combines rows from two tables where there is a match in both tables.
-- INNER JOIN: Combines rows from Customers and Orders where CustomerID matches in both tables
SELECT 
    Customers.CustomerID, 
    Customers.CustomerName, 
    Orders.OrderID, 
    Orders.OrderDate 
FROM 
    Customers
INNER JOIN 
    Orders ON Customers.CustomerID = Orders.CustomerID;

-- LEFT (OUTER) JOIN: Returns all rows from the left table and matched rows from the right table. Non-matching rows in the right table are returned as NULL.
-- LEFT (OUTER) JOIN: Retrieves all rows from Customers and matched rows from Orders
SELECT 
    Customers.CustomerID, 
    Customers.CustomerName, 
    Orders.OrderID, 
    Orders.OrderDate 
FROM 
    Customers
LEFT JOIN 
    Orders ON Customers.CustomerID = Orders.CustomerID;
    
-- RIGHT (OUTER) JOIN: Returns all rows from the right table and matched rows from the left table. Non-matching rows in the left table are returned as NULL.
-- RIGHT (OUTER) JOIN: Retrieves all rows from Orders and matched rows from Customers
SELECT 
    Customers.CustomerID, 
    Customers.CustomerName, 
    Orders.OrderID, 
    Orders.OrderDate 
FROM 
    Customers
RIGHT JOIN 
    Orders ON Customers.CustomerID = Orders.CustomerID;
    
-- FULL (OUTER) JOIN: Returns all rows when there is a match in either table. Non-matching rows are returned as NULL for the missing side.
-- FULL (OUTER) JOIN: Retrieves all rows from both Customers and Orders, with NULLs for unmatched rows but as it is not directly supported in mysql so we will be using union to perform full outer join.
SELECT 
    Customers.CustomerID, 
    Customers.CustomerName, 
    Orders.OrderID, 
    Orders.OrderDate 
FROM 
    Customers
LEFT JOIN 
    Orders ON Customers.CustomerID = Orders.CustomerID
UNION
SELECT 
    Customers.CustomerID, 
    Customers.CustomerName, 
    Orders.OrderID, 
    Orders.OrderDate 
FROM Customers RIGHT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;
    
-- CROSS JOIN: Returns the Cartesian product of two tables, i.e., all possible combinations of rows from both tables.
-- CROSS JOIN: Creates a Cartesian product of Customers and Products
SELECT 
    Customers.CustomerName, 
    Products.ProductName 
FROM 
    Customers
CROSS JOIN 
    Products;