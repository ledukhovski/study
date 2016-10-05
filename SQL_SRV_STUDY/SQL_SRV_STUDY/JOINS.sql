USE TSQL2012;

/* ==CROSS JOINS==

Consider an example from the TSQL2012 sample database. This database contains a table
called dbo.Nums that has a column called n with a sequence of integers from 1 on. Your task is
to use the Nums table to generate a result with a row for each weekday (1 through 7) and shift
number (1 through 3), assuming there are three shifts a day. The result can later be used as the
basis for building information about activities in the different shifts in the different days. With
seven days in the week and three shifts every day, the result should have 21 rows.*/

SELECT WEEKDAYS.n AS WEEKDAY,
       SHIFTDAYS.n AS SHIFDAY
FROM dbo.Nums AS WEEKDAYS
     CROSS JOIN dbo.Nums AS SHIFTDAYS
WHERE WEEKDAYS.n <= 7
      AND SHIFTDAYS.n <= 3
ORDER BY WEEKDAY,
         SHIFDAY;

/* ==OUTER JOIN==
As an example, the following query returns suppliers from Japan and the products they
supply, including suppliers from Japan that don’t have related products.*/

SELECT s.country+' '+s.companyname AS Supplier,
       p.productname AS ProductName
FROM Production.Suppliers s
     LEFT JOIN Production.Products p ON p.supplierid = s.supplierid
	WHERE s.country = N'JAPAN'

/* ==Multiply joins
As an example, suppose that you wanted to return all suppliers from Japan, and matching
products where relevant. For this, you need an outer join between Production.Suppliers and
Production.Products, preserving Suppliers. But you also want to include product category
information, so you add an inner join to Production.Categories,*/

SELECT s.country AS SupliersCountry,
       s.companyname AS Suplier,
       p.productname AS ProductName,
       p.unitprice AS Price,
       c.categoryname AS Category
FROM Production.Suppliers s
     LEFT JOIN(Production.Products p
               JOIN Production.Categories c ON c.categoryid = p.categoryid) ON s.supplierid = p.supplierid
WHERE s.country = N'Japan';