use NORTHWND
--PART One (Wildcards)
select * from Customers

--1. Retrieve all suppliers from the 'USA' whose city starts with 'N' or has 'o' in the second letter.

SELECT * FROM Suppliers
WHERE Country = 'USA'
  OR City LIKE 'N_o%';

--2. Find suppliers whose company name contains 'Liquids' or has 'o' in the third letter.
SELECT * FROM Suppliers
WHERE CompanyName LIKE '%__o%'
  OR CompanyName LIKE '%Liquids%';

--3. write a code to extract customerid, address and phone  where the phone number has open and close brackets and the address starts with C/
SELECT CustomerID, Address, Phone
FROM Customers
WHERE Phone LIKE '%(%' AND Phone LIKE '%)%'
  AND Address LIKE 'C/%';

--4. Retrieve suppliers whose contact name ends with 'i' or has 'a' in the third letter of their company name.
SELECT * FROM Suppliers
WHERE ContactName LIKE '%i'
  or CompanyName LIKE '__a%';

--5 Find suppliers whose city starts with 'M'or has 'Land' in their company name.

SELECT * FROM Suppliers
WHERE City LIKE 'M%'
or CompanyName LIKE '%Land%';


-- 6. Find suppliers whose company name contains 'Ltd' and the contact name contains 'a'.
SELECT * FROM Suppliers
WHERE CompanyName LIKE '%Ltd%'
  AND ContactName LIKE '%a%';

--7. Find suppliers with NULL fax numbers and whose company name contains 'Delights'.
SELECT * FROM Suppliers
WHERE Fax IS NULL
  AND CompanyName LIKE '%Delights%';

--8. Get suppliers with NOT NULL postal codes and whose city contains 'er'.
SELECT * FROM Suppliers
WHERE PostalCode IS NOT NULL
  AND City LIKE '%er%';

--9 Get suppliers with NOT NULL phone numbers and whose city starts with 'A'.
SELECT * FROM Suppliers
WHERE Phone IS NOT NULL
  AND City LIKE 'A%';

--10. Retrieve suppliers with NULL homepage and whose company name contains 'GmbH'.
SELECT * FROM Suppliers
WHERE HomePage IS NULL
  AND CompanyName LIKE '%GmbH%';

 
 --11. Extract Companyname and phone number for all customers whose phone numbers has open and close brackets
  SELECT CompanyName,Phone
FROM Suppliers
WHERE Phone LIKE '%(%' AND Phone LIKE '%)%';

--12 Here's the SQL code to extract customer details where the phone number has more than one dot or the address starts with 'Av':
SELECT CustomerID, Address, PostalCode, Phone
FROM Customers
WHERE Phone LIKE '%.%.%' OR Address LIKE 'Av%';


--PART TWO
select * from Orders

--1 For all Orders shipped from USA and shipvia is 1, extract all CustomerID, RequiredDate,ShippedDate,ShipCountry,Freight, and ShipVia from orders for orders where Freight is 100 or more
SELECT CustomerID, RequiredDate,ShippedDate,ShipCountry,Freight,ShipVia
from Orders
where Freight>=100 and ShipVia = 1 and ShipCountry='USA'

--2. Extract all rows for all orders where the orderdate is after 1996 and Shipvia is not 1, and the freight is between 50 and 100
SELECT * from orders
where OrderDate >'1996-12-31' and ShipRegion is not null and ShipVia>1
and Freight between 50 and 100

--3. How many orders shipped from USA from an address that starts with 187 were shipped before 1997?

Select * from orders
where ShipCountry ='USA' and ShippedDate > '1997-01-01' and ShipAddress LIKE '187%'

--4 How many orders shipped or ordered in 1997, excluding orders shipped from USA, Portugal or Ireland were not shipped via 3 ?
select * from orders
where (ShippedDate between '1997-01-01' and '1997-12-31') OR (OrderDate between '1997-01-01' and '1997-12-31')
AND ShipVia != 3 and ShipCountry NOT in ('USA','Ireland','Portugal')

--5 How many products are sold in bottles (use products table)
select * from Products
where QuantityPerUnit like '%bottle%'

--PART THREE

--1. Question: Retrieve the top 5 customers who have made the most orders. Include customer details and order counts.

SELECT top 5 c.CustomerID, c.ContactName, COUNT(o.OrderID) AS OrderCount
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.ContactName
ORDER BY OrderCount DESC

--2. Question: List the employees who have placed the most orders. Include employee details and order counts.

SELECT e.EmployeeID, e.FirstName, e.LastName, COUNT(o.OrderID) AS OrderCount
FROM Employees e
LEFT JOIN Orders o ON e.EmployeeID = o.EmployeeID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY OrderCount DESC;

--3. Question: Retrieve all products and calculate the average price for each category. Show the category name, product name, and average price.
SELECT c.CategoryName, p.ProductName, AVG(p.UnitPrice) AS AveragePrice
FROM Categories c
INNER JOIN Products p ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryName, p.ProductName;

--4. Question: List the top 3 customers who made the highest total purchases. Show customer details and total purchase amount.
SELECT top 3 c.CustomerID, c.ContactName, SUM(od.UnitPrice * od.Quantity) AS TotalPurchase
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
INNER JOIN Order_Details od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.ContactName
ORDER BY TotalPurchase DESC

--5.  Calculate the rank of each product by price within its category. Show the product name, price, category, and rank.

SELECT p.ProductName, p.UnitPrice, c.CategoryName,
    RANK() OVER (PARTITION BY c.CategoryID ORDER BY p.UnitPrice) AS PriceRank
FROM Products p
INNER JOIN Categories c ON p.CategoryID = c.CategoryID;

--6. List the employees and their orders in descending order of the number of orders placed.
SELECT e.EmployeeID, e.FirstName, e.LastName, COUNT(o.OrderID) AS OrderCount
FROM Employees e
LEFT JOIN Orders o ON e.EmployeeID = o.EmployeeID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY OrderCount DESC;

--7.  Retrieve the product names and the number of orders they appear in. Show the most ordered products first.
SELECT p.ProductName, COUNT(od.OrderID) AS OrderCount
FROM Products p
LEFT JOIN Order_Details od ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY OrderCount DESC;

--8 Calculate the dense rank of products by price within their category. Show product name, price, category, and dense rank.
SELECT p.ProductName, p.UnitPrice, c.CategoryName,
    DENSE_RANK() OVER (PARTITION BY c.CategoryID ORDER BY p.UnitPrice) AS PriceDenseRank
FROM Products p
INNER JOIN Categories c ON p.CategoryID = c.CategoryID;

--9 Calculate the row number for products within their category, ordered by price. Show product name, price, category, and row number.

SELECT p.ProductName, p.UnitPrice, c.CategoryName,
   ROW_NUMBER() OVER (PARTITION BY c.CategoryID ORDER BY p.UnitPrice) AS PriceRowNumber
FROM Products p
INNER JOIN Categories c ON p.CategoryID = c.CategoryID;

--10:  Create a stored procedure named GetOrderDetails that takes an OrderID as input and returns the details of that order.
CREATE PROCEDURE GetOrderDetails
@OrderID INT
AS
BEGIN
    SELECT * FROM Orders
    WHERE OrderID = @OrderID;
    SELECT * FROM OrderDetails
    WHERE OrderID = @OrderID;
END;

--11. Create a stored procedure named GetEmployeeOrders that takes an EmployeeID as input and returns all orders placed by that employee.
CREATE PROCEDURE GetEmployeeOrders
@EmployeeID INT
AS
BEGIN
    SELECT * FROM Orders
    WHERE EmployeeID = @EmployeeID;
END;

--12. Create a stored procedure named GetHighValueCustomers that returns a list of customers who have made purchases above a specified total purchase amount.
CREATE PROCEDURE GetHighValueCustomers
@TotalPurchase DECIMAL(10, 2)
AS
BEGIN
    SELECT c.CustomerID, c.ContactName
    FROM Customers c
    INNER JOIN (
        SELECT CustomerID, SUM(UnitPrice * Quantity) AS TotalPurchase
        FROM OrderDetails
        GROUP BY CustomerID
    ) t ON c.CustomerID = t.CustomerID
    WHERE TotalPurchase > @TotalPurchase;
END;

--13.  Create a stored procedure named GetCategoryRevenue that takes a CategoryID as input and returns the total revenue for all products in that category.
CREATE PROCEDURE GetCategoryRevenue
@CategoryID INT
AS
BEGIN
    SELECT SUM(od.UnitPrice * od.Quantity) AS CategoryRevenue
    FROM OrderDetails od
    INNER JOIN Products p ON od.ProductID = p.ProductID
    WHERE p.CategoryID = @CategoryID;
END;

--14  Create a stored procedure named GetProductSales that takes a ProductID as input and returns the total sales (revenue) for that product.
CREATE PROCEDURE GetProductSales
@ProductID INT
AS
BEGIN
    SELECT SUM(UnitPrice * Quantity) AS TotalSales
    FROM OrderDetails
    WHERE ProductID = @ProductID;
END;

