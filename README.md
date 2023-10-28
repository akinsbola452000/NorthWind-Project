# NorthWind-Project
This project involves creating SQL tables and loading the tables with data.
The main idea is to replicate the Northwnd database.
Below is the schema/diagram for the tables.
![image](https://github.com/akinsbola452000/NorthWind-Project/assets/20444202/7f5c6daf-4642-4573-b046-45b5980d4ed8)

Steps:
1.	Create the database named ‘Northwnd’
2.	Use the diagram below to design and create the tables 
3.	Load data into the tables
a.	The following tables will be loaded manually with Insert statements (Shippers,Suppliers, and US_states). In the Shippers and Suppliers tables, auto generate the Shippers_id and supplier_id respectively. The values for these tables are provided in the appendix a.
b.	The data for the remaining tables are provided as csv files which should then be loaded into the tables.
c.	Data for Customer_demographics and Customer_demo are missing but the tables should be created.
4.	Perform the following:

Note: There are 3 SQL files attached to this project. One to create the tables, another to load data into the tables, and the last is the solution to the business questions.


Appendix a.


Business Question to be answered: Note please, the sql code to the business questions are stored in the Solution.sql file.
PART ONE (WILDCRADS):

•	Retrieve all suppliers from the 'USA' whose city starts with 'N' or has 'o' in the second letter.
•	Find suppliers whose company name contains 'Liquids' or has 'o' in the third letter.
•	write a code to extract customerid, address and phone  where the phone number has open and close brackets and the address starts with C/
•	Retrieve suppliers whose contact name ends with 'i' or has 'a' in the third letter of their company name.
•	5 Find suppliers whose city starts with 'M'or has 'Land' in their company name.
•	Find suppliers whose company name contains 'Ltd' and the contact name contains 'a'.
•	Find suppliers with NULL fax numbers and whose company name contains 'Delights'.
•	Get suppliers with NOT NULL postal codes and whose city contains 'er'.
•	9 Get suppliers with NOT NULL phone numbers and whose city starts with 'A'.
•	10. Retrieve suppliers with NULL homepage and whose company name contains 'GmbH'.
•	11. Extract Companyname and phone number for all customers whose phone numbers has open and close brackets
•	12 Here's the SQL code to extract customer details where the phone number has more than one dot or the address starts with 'Av':

PART TWO (Logical Operator using Orders Table)

•	For all Orders shipped from USA and shipvia is 1, extract all CustomerID, RequiredDate,ShippedDate,ShipCountry,Freight, and ShipVia from orders for orders where Freight is 100 or more
•	Extract all rows for all orders where the orderdate is after 1996 and Shipvia is not 1, and the freight is between 50 and 100
•	How many orders shipped from USA from an address that starts with 187 were shipped before 1997?
•	How many orders shipped or ordered in 1997, excluding orders shipped from USA, Portugal or Ireland were not shipped via 3?
•	5 How many products are sold in bottles (use products table)


Part Three

•	Question: Retrieve the top 5 customers who have made the most orders. Include customer details and order counts.
•	
	Question: List the employees who have placed the most orders. Include employee details and order counts.
•	Question: Retrieve all products and calculate the average price for each category. Show the category name, product name, and average price.
•	Question: List the top 3 customers who made the highest total purchases. Show customer details and total purchase amount.
•	Calculate the rank of each product by price within its category. Show the product name, price, category, and rank.
•	List the employees and their orders in descending order of the number of orders placed.
•	Retrieve the product names and the number of orders they appear in. Show the most ordered products first.
•	Calculate the dense rank of products by price within their category. Show product name, price, category, and dense rank.
•	Calculate the row number for products within their category, ordered by price. Show product name, price, category, and row number.
•	Create a stored procedure named GetOrderDetails that takes an OrderID as input and returns the details of that order.
•	Create a stored procedure named GetEmployeeOrders that takes an EmployeeID as input and returns all orders placed by that employee.
•	Create a stored procedure named GetHighValueCustomers that returns a list of customers who have made purchases above a specified total purchase amount.
•	Create a stored procedure named GetCategoryRevenue that takes a CategoryID as input and returns the total revenue for all products in that category.
•	Create a stored procedure named GetProductSales that takes a ProductID as input and returns the total sales (revenue) for that product.


