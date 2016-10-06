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
SELECT year(o.orderdate), o.shipperid, o.shippeddate
 FROM Sales.Orders o
)


SELECT * FROM pvt;

SELECT *
 from Pvt p
 PIVOT ( max(o.shippeddate)