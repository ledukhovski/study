USE TSQL2012;



/*Write a PIVOT query against the Sales.Orders table that returns the maximum shipping
date for each order year and shipper ID. Return order years on rows, shipper IDs (1, 2,
and 3) on columns, and the maximum shipping dates in the data part.*/

/*
WITH PivotData AS
(SELECT
< grouping column >,
< spreading column >,
< aggregation column >
FROM < source table >
)
SELECT < select list >
FROM PivotData
PIVOT( < aggregate function >(< aggregation column >)
FOR < spreading column > IN (< distinct spreading values >) ) AS P;
*/


--SELECT * FROM sales.Orders o

WITH Pvt AS
(
SELECT year(o.orderdate) AS [Year], o.shipperid AS [ShipperId], o.shippeddate AS [DATE]
 FROM Sales.Orders o
)
SELECT *
 from Pvt p
 PIVOT ( max([DATE]) FOR shipperid IN ([1], [2], [3])) as A;


 SELECT Customer.custid AS [@custid],
Customer.companyname AS [companyname]
FROM Sales.Customers AS Customer
WHERE Customer.custid <= 2
ORDER BY Customer.custid
FOR XML PATH ('Customer'), ROOT('Customers');