-- BI Team's Recurring Queries Script

-- Query 1:
/* From the  table HumanResources.Employee write a query in SQL to retrieve all rows and 
columns from the employee table in the Adventureworks database. 
Sort the result set in ascending order on jobtitle.*/

SELECT *
FROM AdventureWorks2019.HumanResources.Employee
ORDER BY JobTitle;

-- Query 2: 
/* From the table Person.Person write a query in SQL to retrieve all rows and columns from the 
employee table using table aliasing in the Adventureworks database. 
Sort the output in ascending order on lastname.*/

SELECT  p.*
FROM AdventureWorks2019.Person.Person AS p
ORDER BY LastName;

-- Query 3:
/* From the table Person.Person write a query in SQL to return all rows and a subset of the columns 
(FirstName, LastName, businessentityid) from the person table in the AdventureWorks database. 
The third column heading is renamed to Employee_id.
Arranged the output in ascending order by lastname. */

SELECT FirstName, LastName, BusinessEntityID AS Employee_id
FROM AdventureWorks2019.Person.Person 
ORDER BY LastName;

-- Query 4:
/* From the table production.Product  write a query in SQL to return only the rows for product 
that have a sellstartdate that is not NULL and a productline of 'T'. 
Return productid, productnumber, and name. Arranged the output in ascending order on name.*/

SELECT ProductID, ProductNumber, Name AS ProductName
FROM AdventureWorks2019.Production.Product
WHERE SellStartDate IS NOT NULL
    AND ProductLine='T'
ORDER BY Name;

-- Query 5:
/* From the table sales.salesorderheader write a query in SQL to return all rows from the 
salesorderheader table in Adventureworks database and calculate the percentage of tax on the 
subtotal have decided. Return salesorderid, customerid, orderdate, subtotal, percentage of tax column. 
Arranged the result set in ascending order on subtotal. */

SELECT SalesOrderID, CustomerID, OrderDate, SubTotal, (TaxAmt/SubTotal)*100 AS TaxPercent
FROM AdventureWorks2019.sales.SalesOrderHeader
ORDER BY SubTotal Desc;

-- Query 6:
/* From the table HumanResources.Employee  write a query in SQL to create a list of unique 
jobtitles in the employee table in Adventureworks database. 
Return jobtitle column and arranged the resultset in ascending order.*/

SELECT DISTINCT JobTitle
FROM AdventureWorks2019.HumanResources.Employee
ORDER BY JobTitle;

-- Query 7:
/* From the table sales.salesorderheader write a query in SQL to calculate the total freight 
paid by each customer. Return customerid and total freight. 
Sort the output in ascending order on customerid.*/

SELECT CustomerID, SUM(Freight) AS TotalFreight
FROM AdventureWorks2019.Sales.SalesOrderHeader
GROUP BY CustomerID
ORDER BY CustomerID;

-- Query 8:
/* From the table sales.salesorderheader write a query in SQL to find the average and the sum 
of the subtotal for every customer. Return customerid, average and sum of the subtotal. 
Grouped the result on customerid and salespersonid. 
Sort the result on customerid column in descending order.*/

SELECT CustomerID, SalesPersonID, AVG(SubTotal) AS AVG_SubTotal,
       SUM(SubTotal) AS SUM_SubTotal
FROM AdventureWorks2019.Sales.SalesOrderHeader
GROUP BY CustomerID, SalesPersonID
ORDER BY CustomerID Desc;

-- Query 9:
/* From the table production.productinventory write a query in SQL to retrieve total quantity 
of each productid which are in shelf of 'A' or 'C' or 'H'. Filter the results for sum quantity 
is more than 500. Return productid and sum of the quantity. 
Sort the results according to the productid in ascending order.*/

SELECT ProductID, SUM(Quantity) AS TotalQuantity
FROM AdventureWorks2019.Production.ProductInventory
WHERE Shelf IN ('A', 'C', 'H')
GROUP BY ProductID
HAVING SUM(Quantity)>500
ORDER BY ProductID;


-- Query 10:
/* From the table Production.ProductionInventory write a query in SQL to find the total 
quantity for a group of locationid multiplied by 10.*/

SELECT SUM(Quantity) AS TotalQuantity
FROM AdventureWorks2019.Production.ProductInventory
GROUP BY (LocationID*10);

-- Query 11:
/* From the Person.PersonPhone and Person.Person tables write a query in SQL to find the 
persons whose last name starts with letter 'L'. Return BusinessEntityID, FirstName, LastName, 
and PhoneNumber. Sort the result on lastname and firstname.*/

SELECT p.BusinessEntityID, FirstName, LastName, PhoneNumber AS PersonPhone
FROM AdventureWorks2019.Person.Person AS p
JOIN AdventureWorks2019.Person.PersonPhone AS ph
    ON p.BusinessEntityID = ph.BusinessEntityID
WHERE LastName LIKE 'L%'
ORDER BY LastName, FirstName;

-- Query 12:
/* From the sales.salesorderheader table write a query in SQL to find the sum of subtotal column. 
Group the sum on distinct salespersonid and customerid. Rolls up the results into subtotal and 
running total. Return salespersonid, customerid and sum of subtotal column i.e. sum_subtotal.*/

SELECT SalesPersonID, CustomerID, SUM(SubTotal) AS SUM_SubTotal
FROM AdventureWorks2019.Sales.SalesOrderHeader
WHERE SalesPersonID IS NOT NULL
GROUP BY ROLLUP(SalesPersonID, CustomerID);

-- Query 13:
/* From  table, the production.productinventory write a query in SQL to find the sum of the 
quantity of all combination of group of distinct locationid and shelf column. 
Return locationid, shelf and sum of quantity as TotalQuantity.*/

SELECT LocationID, Shelf, SUM(Quantity) AS TotalQuantity
FROM AdventureWorks2019.Production.ProductInventory
GROUP BY CUBE (LocationID, Shelf);

-- Query 14:
/* From the table production.productinventory write a query in SQL to find the sum of the 
quantity with subtotal for each locationid. Group the results for all combination of distinct 
locationid and shelf column. Rolls up the results into subtotal and running total. 
Return locationid, shelf and sum of quantity as TotalQuantity.*/

SELECT LocationID, Shelf, SUM(Quantity) AS TotalQuantity
FROM AdventureWorks2019.Production.ProductInventory
GROUP BY GROUPING SETS ( ROLLUP (locationid, shelf), CUBE (locationid, shelf) );

-- Query 15:
/* From the table production.productinventory write a query in SQL to find the total quantity 
for each locationid and calculate the grand-total for all locations. 
Return locationid and total quantity. Group the results on locationid.*/

SELECT LocationID, SUM(Quantity) AS TotalQuantity
FROM AdventureWorks2019.Production.ProductInventory
GROUP BY ROLLUP (LocationID); -- GROUP BY GROUPING SETS ( locationid, () );

-- Query 16:
/* From the table Person.BusinessEntityAddress write a query in SQL to retrieve the number of 
employees for each City. Return city and number of employees. 
Sort the result in ascending order on city.*/

SELECT a.City, COUNT(b.AddressID) AS NoOfEmployees
FROM AdventureWorks2019.Person.BusinessEntityAddress AS b
JOIN AdventureWorks2019.Person.Address AS A
    ON b.AddressID = a.AddressID
GROUP BY City
ORDER BY City;

-- Query 17:
/* From the table Sales.SalesOrderHeader write a query in SQL to retrieve the total sales for 
each year. Return the year part of order date and total due amount. 
Sort the result in ascending order on year part of order date.*/

SELECT DATEPART(year, OrderDate) AS Year, SUM(TotalDue) AS OrderAmount
FROM AdventureWorks2019.Sales.SalesOrderHeader
GROUP BY DATEPART(year,OrderDate)
ORDER BY Year;

--Query 18:
/* From the table Sales.SalesOrderHeader write a query in SQL to retrieve the total sales for each year. 
Filter the result set for those orders where order year is on or before 2016. 
Return the year part of orderdate and total due amount. 
Sort the result in ascending order on year part of order date.*/

SELECT DATEPART(year, OrderDate) AS Year, SUM(TotalDue) AS TotalDueAmount
FROM AdventureWorks2019.Sales.SalesOrderHeader
GROUP BY DATEPART(year,OrderDate)
HAVING DATEPART(year,OrderDate) <= 2016
ORDER BY Year;

-- Query 19:
/* From the table Person.ContactType write a query in SQL to find the contacts who are 
designated as a manager in various departments. Returns ContactTypeID, name. 
Sort the result set in descending order.*/

SELECT ContactTypeID, Name
FROM AdventureWorks2019.Person.ContactType
WHERE Name LIKE '%Manager%'
ORDER BY ContactTypeID Desc

-- Query 20:
/* From the tables Person.BusinessEntityContact, Person.ContactType and Person.Person write a 
query in SQL to make a list of contacts who are designated as 'Purchasing Manager'. 
Return BusinessEntityID, LastName, and FirstName columns. Sort the result set in ascending order 
of LastName, and FirstName.*/

SELECT p.BusinessEntityID, p.LastName, p.FirstName
FROM AdventureWorks2019.Person.BusinessEntityContact AS b 
JOIN AdventureWorks2019.Person.ContactType AS c
    ON c.ContactTypeID = b.ContactTypeID
JOIN AdventureWorks2019.Person.Person as p 
    ON p.BusinessEntityID = b.PersonID 
WHERE c.Name = 'Purchasing Manager'
ORDER BY LastName, FirstName;

-- Query 21: 
/* From the tables Sales.SalesPerson, Person.Person and Person.Address write a query in SQL 
to retrieve the salesperson for each PostalCode who belongs to a territory and SalesYTD is not
 zero. Return row numbers of each group of PostalCode, last name, salesytd, postalcode column. 
 Sort the salesytd of each postalcode group in descending order. 
 Shorts the postalcode in  ascending order.*/

SELECT * 
FROM AdventureWorks2019.Sales.SalesPerson AS s 
JOIN AdventureWorks2019.Person.Person AS p 
    ON p.BusinessEntityID = s.BusinessEntityID
JOIN AdventureWorks2019.Person.Address AS a 
    ON a.AddressID = s.BusinessEntityID

-- Query 22:
/* From the tables Person.BusinessEntityContact and  Person.ContactType write a query in SQL to 
count the number of contacts for combination of each type and name. Filter the output for those 
who have 100 or more contacts. Return ContactTypeID and ContactTypeName and BusinessEntityContact. 
Sort the result set in descending order on number of contact.*/

SELECT bec.ContactTypeID, ct.Name AS ContactTypeName, COUNT(*) AS NOcontacts
FROM AdventureWorks2019.Person.BusinessEntityContact AS bec 
JOIN AdventureWorks2019.Person.ContactType AS ct 
    ON bec.ContactTypeID = ct.ContactTypeID
GROUP BY bec.ContactTypeID, ct.Name
HAVING COUNT(*) >= 100
ORDER BY NOcontacts;



-- Query 23:
/* From the table HumanResources.EmployeePayHistory and Person.Person write a query in SQL to 
retrieve the RateChangeDate, full name (first name, middle name and last name) and weekly salary 
(40 hours in a week) of employees. In the output the RateChangeDate should appears in date format. 
Sort the output in ascending order on NameInFull.*/

SELECT CAST(e.RateChangeDate AS VARCHAR(10)) AS FromDate, 
       CONCAT(p.LastName, ', ', p.FirstName,' ',p.MiddleName) AS NameInFull,
       (40*e.Rate) AS SalaryInAWeek
FROM AdventureWorks2019.HumanResources.EmployeePayHistory AS e
JOIN AdventureWorks2019.Person.Person AS p
    ON e.BusinessEntityID = p.BusinessEntityID
ORDER BY NameInFull;


-- Query 24:
/* From the tables HumanResources.EmployeePayHistory and Person.Person write a query in SQL to 
calculate and display the latest weekly salary of each employee. Return RateChangeDate, full name 
(first name, middle name and last name) and weekly salary (40 hours in a week) of employees. 
Sort the output in ascending order on NameInFull.*/

SELECT CAST(hur.RateChangeDate as VARCHAR(10) ) AS FromDate
        , CONCAT(LastName, ', ', FirstName, ' ', MiddleName) AS NameInFull
        , (40 * hur.Rate) AS SalaryInAWeek
    FROM AdventureWorks2019.Person.Person AS pp
        INNER JOIN AdventureWorks2019.HumanResources.EmployeePayHistory AS hur
            ON hur.BusinessEntityID = pp.BusinessEntityID
             WHERE hur.RateChangeDate = (SELECT MAX(RateChangeDate)
                                FROM AdventureWorks2019.HumanResources.EmployeePayHistory
                                WHERE BusinessEntityID = hur.BusinessEntityID)
    ORDER BY NameInFull;


-- Query 25:
/* From the table Sales.SalesOrderDetail write a query in SQL to find the sum, average, count, 
minimum, and maximum order quentity for those orders whose id are 43659 and 43664. 
Return SalesOrderID, ProductID, OrderQty, sum, average, count, max, and min order quantity.*/

SELECT SalesOrderID, ProductID, OrderQty, 
       SUM(OrderQty) OVER (PARTITION BY SalesOrderID) AS TotalQuantity, 
       AVG(OrderQty) OVER (PARTITION BY SalesOrderID) AS AvgQuantity,
       COUNT(OrderQty) OVER (PARTITION BY SalesOrderID) AS NoOfOrders, 
       MAX(OrderQty) OVER (PARTITION BY SalesOrderID) AS MaxQuantity, 
       MIN(OrderQty) OVER (PARTITION BY SalesOrderID) AS MinQuantity
FROM AdventureWorks2019.Sales.SalesOrderDetail
WHERE SalesOrderID IN(43659,43664);


-- Query 26:
/* From the table Sales.SalesOrderDetail write a query in SQL to find the sum, average, and 
number of order quantity for those orders whose ids are 43659 and 43664 and product id starting 
with '71'. Return SalesOrderID, OrderNumber,ProductID, OrderQty, sum, average, and number of order 
quantity.*/

SELECT SalesOrderID, ProductID, OrderQty, 
       SUM(OrderQty) OVER (PARTITION BY SalesOrderID) AS TotalQuantity, 
       AVG(OrderQty) OVER (PARTITION BY SalesOrderID) AS AvgQuantity,
       COUNT(OrderQty) OVER (PARTITION BY SalesOrderID) AS NoOfOrders, 
       MAX(OrderQty) OVER (PARTITION BY SalesOrderID) AS MaxQuantity, 
       MIN(OrderQty) OVER (PARTITION BY SalesOrderID) AS MinQuantity
FROM AdventureWorks2019.Sales.SalesOrderDetail
WHERE SalesOrderID IN(43659,43664) AND ProductID LIKE '71%';


-- Query 27:
/*  From the table Sales.SalesOrderDetail write a query in SQL to retrieve the total cost of each 
salesorderID that exceeds 100000. Return SalesOrderID, total cost.*/

SELECT SalesOrderID, SUM(LineTotal) AS TotalCost
FROM AdventureWorks2019.Sales.SalesOrderDetail
GROUP BY SalesOrderID
HAVING SUM(LineTotal) > 100000;

-- Query 28:
/* From the Production.Product table write a query in SQL to retrieve products whose names start 
with 'Lock Washer'. Return product ID, and name and order the result set in ascending order on 
product ID column.*/

SELECT ProductID, Name
FROM AdventureWorks2019.Production.Product
WHERE Name LIKE 'Lock Washer%'
ORDER BY ProductID;


-- Query 29:
/* From the table Production.Product write a query in SQL to fetch rows and order the result set on 
an unspecified column listprice. Return product ID, name, and color of the product.*/

SELECT ProductID, Name, Color
FROM AdventureWorks2019.Production.Product
ORDER BY ListPrice;


-- Query 30:
/* From the table HumanResources.Employee write a query in SQL to retrieve records of employees. 
Order the output on year (default ascending order) of hiredate. Return BusinessEntityID, JobTitle, 
and HireDate.*/

SELECT BusinessEntityID, JobTitle, HireDate
FROM AdventureWorks2019.HumanResources.Employee
ORDER BY DATEPART(year,HireDate);


-- Query 31:
/* From the table Person.Person write a query in SQL to retrieve those persons whose last name 
begins with letter 'R'. Return lastname, and firstname and display the result in ascending order 
on firstname and descending order on lastname columns.*/

SELECT LastName, FirstName
FROM AdventureWorks2019.Person.Person
WHERE LastName LIKE 'R%'
ORDER BY FirstName Asc, LastName Desc;


-- Query 32:
/* From the table HumanResources.Employee write a query in SQL to ordered the BusinessEntityID 
column descendingly when SalariedFlag set to 'true' and BusinessEntityID in ascending order when 
SalariedFlag set to 'false'. Return BusinessEntityID, SalariedFlag columns.*/

SELECT BusinessEntityID, SalariedFlag
FROM AdventureWorks2019.HumanResources.Employee
ORDER BY CASE WHEN SalariedFlag = 'true' THEN BusinessEntityID END DESC  
        ,CASE SalariedFlag WHEN 'false' THEN BusinessEntityID END;

-- Query 33:
/* From the table Sales.SalesPerson write a query in SQL to set the result in order by the column 
TerritoryName when the column CountryRegionName is equal to 'United States' and by CountryRegionName 
for all other rows.*/

SELECT p.BusinessEntityID, t.Name, t.CountryRegionCode
FROM AdventureWorks2019.Sales.SalesPerson AS p
JOIN AdventureWorks2019.Sales.SalesTerritory AS t 
    ON p.TerritoryID = t.TerritoryID
ORDER BY CASE t.CountryRegionCode WHEN 'US' THEN t.Name ELSE t.CountryRegionCode END;


-- Query 34:
/* From the table Sales.SalesPerson, Person.Person and Person.Address write a query in SQL to find 
those persons who lives in a territory and the value of salesytd except 0. Return first name, 
last name, row number as 'Row Number', 'Rank', 'Dense Rank' and NTILE as 'Quartile', salesytd and 
postalcode. Order the output on postalcode column.*/

SELECT p.FirstName, p.LastName  
    ,ROW_NUMBER() OVER (ORDER BY a.PostalCode) AS "Row Number"  
    ,RANK() OVER (ORDER BY a.PostalCode) AS "Rank"  
    ,DENSE_RANK() OVER (ORDER BY a.PostalCode) AS "Dense Rank"  
    ,NTILE(4) OVER (ORDER BY a.PostalCode) AS "Quartile"  
    ,s.SalesYTD, a.PostalCode  
FROM AdventureWorks2019.Sales.SalesPerson AS s   
    JOIN AdventureWorks2019.Person.Person AS p   
        ON s.BusinessEntityID = p.BusinessEntityID  
    JOIN AdventureWorks2019.Person.Address AS a   
        ON a.AddressID = p.BusinessEntityID  
WHERE TerritoryID IS NOT NULL AND SalesYTD <> 0;

-- Query 35:
/* From the table  HumanResources.Department write a query in SQL to skip the first 10 rows from 
the sorted result set and return all remaining rows.*/

SELECT *
FROM AdventureWorks2019.HumanResources.Department
ORDER BY DepartmentID OFFSET 10 ROWS;

-- Query 36:
/* From the table HumanResources.Department write a query in SQL to skip the first 5 rows and return the next 5 
rows from the sorted result set.*/

SELECT *
FROM AdventureWorks2019.HumanResources.Department 
ORDER BY DepartmentID ASC
OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY;

-- Query 37:
/* From the table Production.Product write a query in SQL to list all the products that are Red 
or Blue in color. Return name, color and listprice.Sorts this result by the column listprice.*/

SELECT Name, Color, ListPrice
FROM AdventureWorks2019.Production.Product
WHERE Color IN ('Blue', 'Red')
ORDER BY ListPrice;

-- Query 38:
/* From the tables Production.Product and SalesOrderDetail write a query in SQL to retrieve the 
product name and any associated sales orders. Additionally, it returns any sales orders that don't 
have any items mentioned in the Product table as well as any products that have sales orders other 
than those that are listed there. Return product name, salesorderid. Sort the result set on product 
name column.*/

SELECT p.Name, s.SalesOrderID  
FROM AdventureWorks2019.Production.Product AS p  
FULL OUTER JOIN AdventureWorks2019.Sales.SalesOrderDetail AS s 
    ON p.ProductID = s.ProductID  
ORDER BY p.Name ;

-- Query 39:
/* From the table Production.Product and Sales.SalesOrderDetail write a SQL query to retrieve 
the product name and salesorderid. 
Both ordered and unordered products are included in the result set.*/

SELECT p.Name, s.SalesOrderID  
FROM AdventureWorks2019.Production.Product AS p  
LEFT OUTER JOIN AdventureWorks2019.Sales.SalesOrderDetail AS s  
    ON p.ProductID = s.ProductID  
ORDER BY p.Name ;

-- Query 40:
/*From the tables Production.Product and SalesOrderDetail write a SQL query to get all product 
names and sales order IDs. Order the result set on product name column.*/

SELECT p.Name, s.SalesOrderID  
FROM AdventureWorks2019.Production.Product AS p  
JOIN AdventureWorks2019.Sales.SalesOrderDetail AS s  
    ON p.ProductID = s.ProductID  
ORDER BY p.Name ;

-- Query 41:
/*From the tables Sales.SalesTerritory and Sales.SalesPerson write a SQL query to retrieve the 
territory name and BusinessEntityID. The result set includes all salespeople, regardless of whether 
or not they are assigned a territory.*/

SELECT t.Name AS Territory, p.BusinessEntityID  
FROM AdventureWorks2019.Sales.SalesTerritory AS t   
RIGHT OUTER JOIN AdventureWorks2019.Sales.SalesPerson AS p  
    ON t.TerritoryID = p.TerritoryID ;

-- Query 42:
/* Write a query in SQL to find the employee's full name (firstname and lastname) and city from 
the Person.Person, HumanResources.Employee, Person.Address and Person.BusinessEntityAddress tables. 
Order the result set on lastname then by firstname.*/

SELECT concat(RTRIM(p.FirstName),' ', LTRIM(p.LastName)) AS Name, d.City  
FROM AdventureWorks2019.Person.Person AS p  
INNER JOIN AdventureWorks2019.HumanResources.Employee AS e 
    ON p.BusinessEntityID = e.BusinessEntityID   
INNER JOIN  
   (SELECT bea.BusinessEntityID, a.City   
    FROM AdventureWorks2019.Person.Address AS a  
    INNER JOIN AdventureWorks2019.Person.BusinessEntityAddress AS bea  
        ON a.AddressID = bea.AddressID) AS d  
ON p.BusinessEntityID = d.BusinessEntityID  
ORDER BY p.LastName, p.FirstName;

-- Query 43:
/* Write a SQL query to return the businessentityid,firstname and lastname columns of all persons 
in the person table (derived table) with persontype is 'IN' and the last name is 'Adams'. 
Sort the result set in ascending order on firstname. A SELECT statement after the FROM clause is 
a derived table.
*/

SELECT businessentityid, firstname,lastname  
FROM  
   (SELECT * FROM AdventureWorks2019.person.person  
    WHERE persontype = 'IN') AS personDerivedTable 
WHERE lastname = 'Adams'  
ORDER BY firstname;

SELECT businessentityid, firstname,lastname  
FROM AdventureWorks2019.person.person  
WHERE persontype = 'IN' AND lastname = 'Adams'  
ORDER BY firstname;

-- Query 44:
/* Create a SQL query to retrieve individuals from the table Person.Person with a businessentityid 
inside 1500, a lastname starting with 'Al', and a firstname starting with 'M'.*/

SELECT businessentityid, firstname,lastname  
FROM AdventureWorks2019.person.person  
WHERE BusinessEntityID <= 1500 AND lastname LIKE 'Al%' AND FirstName LIKE 'M%';

-- Query 45:
/* From the Production.Product table write a SQL query to find the productid, name, and colour 
of the items 'Blade', 'Crown Race' and 'AWC Logo Cap' using a derived table with multiple values.*/

SELECT ProductID, a.Name, Color  
FROM AdventureWorks2019.Production.Product AS a  
INNER JOIN (VALUES ('Blade'), ('Crown Race'), ('AWC Logo Cap')) AS b(Name)   
ON a.Name = b.Name;

SELECT ProductID, Name, Color  
FROM AdventureWorks2019.Production.Product 
WHERE Name IN ('Blade', 'Crown Race', 'AWC Logo Cap');

-- Query 46:
/* From the table Sales.SalesOrderHeader, create a SQL query to display the total number of sales 
orders each sales representative receives annually. Sort the result set by SalesPersonID and then 
by the date component of the orderdate in ascending order. Return the year component of the 
OrderDate, SalesPersonID, and SalesOrderID.*/

WITH Sales_CTE (SalesPersonID, SalesOrderID, SalesYear)
AS
(
    SELECT SalesPersonID, SalesOrderID, DATEPART(year,OrderDate) AS SalesYear
    FROM AdventureWorks2019.Sales.SalesOrderHeader
    WHERE SalesPersonID IS NOT NULL
)
SELECT SalesPersonID, COUNT(SalesOrderID) AS TotalSales, SalesYear
FROM Sales_CTE
GROUP BY SalesYear, SalesPersonID
ORDER BY SalesPersonID, SalesYear;


-- Query 47:
/* From the table Sales.SalesOrderHeader write a query in SQL to find the average number of sales 
orders for all the years of the sales representatives.
*/

WITH Sales_CTE (SalesPersonID, NumberOfOrders)
AS
(
    SELECT SalesPersonID, COUNT(*)
    FROM AdventureWorks2019.Sales.SalesOrderHeader
    WHERE SalesPersonID IS NOT NULL
    GROUP BY SalesPersonID
)
SELECT AVG(NumberOfOrders) AS "Average Sales Per Person"
FROM Sales_CTE;

-- Query 48:
/* Write a SQL query on the table Production.ProductPhoto to retrieve records with the characters 
green_ in the LargePhotoFileName field. The following table's columns must all be returned.*/

SELECT *   
FROM AdventureWorks2019.Production.ProductPhoto  
WHERE LargePhotoFileName LIKE '%green_%' ;

-- Query 49:
/* From the tables Person.Address and Person.StateProvince write a SQL query to retrieve the 
mailing address for any company that is outside the United States (US) and in a city whose name 
starts with Pa. Return Addressline1, Addressline2, city, postalcode, countryregioncode columns.*/

SELECT AddressLine1, AddressLine2, City, PostalCode, CountryRegionCode    
FROM AdventureWorks2019.Person.Address AS a  
JOIN AdventureWorks2019.Person.StateProvince AS s 
    ON a.StateProvinceID = s.StateProvinceID  
WHERE CountryRegionCode NOT IN ('US') AND City LIKE 'Pa%' ;

-- Query 50:
/* From the table HumanResources.Employee write a query in SQL to fetch first twenty rows. 
Return jobtitle, hiredate. Order the result set on hiredate column in descending order.
*/

SELECT TOP 20 JobTitle, HireDate
FROM AdventureWorks2019.HumanResources.Employee
ORDER BY HireDate DESC;
