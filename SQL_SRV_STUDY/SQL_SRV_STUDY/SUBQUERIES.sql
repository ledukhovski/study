/*For example, the following
query uses a self-contained subquery to return the products with the minimum unit price.*/

/* Simple*/

SELECT p.productname,
       p.unitprice AS MinimumPrice
FROM Production.Products p
WHERE p.unitprice =
(
    SELECT MIN(p2.unitprice) AS price
    FROM Production.Products p2
);

/*Correlated Subqueries
As an example, suppose that you need to return products with the minimum unit price
per category. You can use a correlated subquery to return the minimum unit price out of
the products where the category ID is equal to the one in the outer row (the correlation),*/

--1
SELECT p.productname,
       p.categoryid,
       p.unitprice
FROM Production.Products p
WHERE p.unitprice =
(
    SELECT MIN(p2.unitprice) AS minprice
    FROM Production.Products p2
    WHERE p2.categoryid = p.categoryid
);

--2
/*As another example of a correlated subquery, the following query returns customers who
placed orders on February 12, 2007.
*/


SELECT c.*
FROM Sales.Customers c
WHERE c.custid IN
(SELECT * FROM Sales.Orders o WHERE o.orderdate = '20070212')