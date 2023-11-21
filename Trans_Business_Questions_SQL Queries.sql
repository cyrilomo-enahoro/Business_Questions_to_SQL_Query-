use Masteryhive

--1. List all suppliers in the UK. 
SELECT *
FROM dbo.Supplier S
WHERE Country = 'UK'; 

--2. List the first name, last name, and city for all customers. Concatenate the first and last name separated by a space and a comma as a single column.
SELECT (C.FirstName +' , '+ C.LastName) AS Customer_Name, C.City 
FROM dbo.Customer C;

--3. List all customers in Sweden
SELECT (C.FirstName +' , '+ C.LastName) AS Customer_Name, C.City, C.Country
FROM dbo.Customer C
WHERE C.Country = 'Sweden';

SELECT *
FROM dbo.Customer C
WHERE Country = 'Sweden';

--4. List all suppliers in alphabetical order
SELECT* 
FROM dbo.Supplier S
ORDER BY S.CompanyName;

--5. List all suppliers with their products.

SELECT p.SupplierId, s.CompanyName, p.ProductName
FROM dbo.Supplier s
LEFT JOIN dbo.Product p ON s.Id = p.supplierId;

--6. List all orders with customers information

SELECT O.Id, O.OrderNumber,O.CustomerId, C.FirstName, C.LastName, C.City, C.Country, C.Phone
FROM dbo.[Order] O 
JOIN dbo.Customer C ON O.CustomerId = C.Id;

--7. List all orders with product name, quantity, and price, sorted by order number

SELECT O.Id as Order_ID, O.OrderNumber, P.ProductName, OI.Quantity, OI.UnitPrice
FROM dbo.[Order] O 
JOIN dbo.OrderItem OI ON O.Id = OI.OrderId
JOIN dbo.Product P ON P.Id = OI.ProductId
ORDER BY O.OrderNumber;

--8. Using a case statement, list all the availability of products. When 0 then not available, else available

SELECT P.ProductName, CASE WHEN IsDiscontinued = 0 THEN 'Not_Available' ELSE 'Available' END As Product_availability
FROM dbo.Product P
ORDER BY Product_availability;


--9. Using case statement, list all the suppliers and the language they speak. The language they speak should be their country E.g if UK, then English

SELECT S.CompanyName, S.Country,  CASE
WHEN Country IN ('Australia', 'Singapore', 'UK', 'USA', 'Canada') THEN 'English'
WHEN Country = 'France' THEN 'French'
WHEN Country = 'Germany' THEN 'German'
WHEN Country = 'Denmark' THEN 'Danish'
WHEN Country = 'Italy' THEN 'Italian'
WHEN Country = 'Japan' THEN 'Japanese'
WHEN Country = 'Spain' THEN 'Spanish'
WHEN Country = 'Norway' THEN 'Norwegian'
WHEN Country = 'Netherlands' THEN 'Dutch'
WHEN Country = 'Sweden' THEN 'Swedish'
WHEN Country = 'Finland' THEN 'Finnish'
WHEN Country = 'Brazil' THEN 'Portuguese' END as [Language] 
FROM dbo.Supplier S
ORDER BY [Language]; 


--10. List all products that are packaged in Jars

SELECT P.ProductName, P.Package
FROM dbo.Product P
WHERE P.Package Like '%jars%';

--11. List procucts name, unitprice and packages for products that starts with Ca
SELECT P.ProductName, P.UnitPrice, P.Package
FROM dbo.Product P
WHERE P.ProductName Like 'Ca%'; 

--12. List the number of products for each supplier, sorted high to low.
SELECT S.CompanyName, COUNT (P.ProductName) as No_of_product
FROM dbo.Product P
Join dbo.Supplier S ON S.ID = P.SupplierId
GROUP BY S.CompanyName
ORDER BY No_of_product DESC;

--13. List the number of customers in each country.

SELECT C.Country, count(C.Id) as No_of_customers
FROM dbo.Customer C
GROUP BY Country;

--14. List the number of customers in each country, sorted high to low.
SELECT C.Country, count(C.Id) as No_of_customers
FROM dbo.Customer C
GROUP BY C.Country
ORDER BY No_of_customers DESC;



--15. List the total order amount for each customer, sorted high to low.

SELECT C.Id as CustomeriD, C.FirstName, C.LastName, Sum(O.TotalAmount) as Total_OrderAmount
FROM dbo.Customer C 
Join dbo.[Order] O ON (C.Id = O.CustomerId)
GROUP BY C.Id, C.FirstName, C.LastName
ORDER BY Total_OrderAmount DESC;

--16. List all countries with more than 2 suppliers.

SELECT S.Country, COUNT(S.Id) as No_ofSuppliers
FROM dbo.Supplier S
GROUP BY S.Country 
HAVING COUNT(S.Id) > 2;



--17. List the number of customers in each country. Only include countries with more than 10 customers.

SELECT C.Country, COUNT(C.Id) as No_ofcustomers
FROM dbo.Customer C
GROUP BY C.Country
HAVING COUNT(Id) > 10;


--18. List the number of customers in each country, except the USA, sorted high to low. Only include countries with 9 or more customers.
SELECT C.Country, COUNT(C.Id) as No_ofcustomers
FROM dbo.Customer C
WHERE NOT C.COUNTRY = 'USA'
GROUP BY C.Country
HAVING COUNT(C.Id) >= 9
ORDER BY No_ofcustomers DESC;



--19. List customer with average orders between $1000 and $1200.

SELECT C.Id as CustomeriD, C.FirstName, C.LastName, AVG(O.TotalAmount) as Average_OrderAmount
FROM dbo.Customer C
JOIN dbo.[Order] O ON (C.Id = O.CustomerId)
GROUP BY C.Id, C.FirstName, C.LastName
HAVING AVG(O.TotalAmount) BETWEEN 1000 AND 1200;



--20. Get the number of orders and total amount sold between Jan 1, 2013 and Jan 31, 2013.

SELECT COUNT(OI.OrderId) as No_of_Orders, SUM(O.TotalAmount) as Total_amount_sold
FROM dbo.[Order] O
JOIN dbo.OrderItem OI ON (O.Id = OI.OrderId)
WHERE O.OrderDate BETWEEN CAST('2013/01/01' AS datetime) AND CAST('2013/01/31' AS datetime) 

 







