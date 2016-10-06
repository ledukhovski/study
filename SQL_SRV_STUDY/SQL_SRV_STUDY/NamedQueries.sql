USE TSQL2012;

/*Exercise 1 Return Products with Minimum Unit Price per Category
As a first step in your solution, write a query against the Production.Products table that
groups the products by categoryid, and returns for each category the minimum unit
price. Here’s a query that achieves this step.*/

--SELECT p.categoryid,
--       MIN(p.unitprice)
--FROM Production.Products p
--GROUP BY p.categoryid;

/*The next step in the solution is to define a CTE based on the previous query, and then
join the CTE to the Production.Products table to return per each category the products
with the minimum unit price.*/

--WITH ProdCTE
--     AS (SELECT p.categoryid,
--                MIN(p.unitprice) AS minprice
--         FROM Production.Products p
--         GROUP BY p.categoryid)
--     SELECT p.categoryid AS CategoryID,
--            p.productid AS ID,
--            p.productname AS Product,
--            p.unitprice AS Price
--     FROM Production.Products p
--          JOIN ProdCTE pc ON pc.minprice = p.unitprice AND pc.categoryid = p.categoryid;

/*Exercise 2 Return N Products with Lowest Unit Price per Supplier
Define an inline table-valued function that accepts a supplier ID as input (@supplierid),
in addition to a number (@n), and returns the @n products with the lowest prices for
the input supplier. In case of ties in the unit price, use the product ID as the tiebreaker.
*/

--IF OBJECT_ID('Production.GetTopProducts', 'IF') IS NOT NULL
--    DROP FUNCTION Production.GetTopProducts;
--GO
--CREATE FUNCTION Production.GetTopProducts
--(@supplierid AS INT,
-- @n AS          BIGINT
--)
--RETURNS TABLE
--AS
--     RETURN
--     SELECT p.productid AS Id,
--            p.productname AS Producrt,
--            p.unitprice AS Price
--     FROM Production.Products p
--     WHERE p.supplierid = @supplierid
--     ORDER BY p.unitprice
--     OFFSET 0 ROWS FETCH FIRST @n ROWS ONLY;
--GO
--SELECT *
--FROM Production.GetTopProducts(1, 2) gtp;

/*Next, return per each supplier from Japan the two products with the lowest prices. To
achieve this, use the CROSS APPLY operator, with Production.Suppliers as the left side
and the Production.GetTopProducts function as the right side,*/

--SELECT *
--FROM Production.Suppliers s
--     CROSS APPLY Production.GetTopProducts(s.supplierid, 2) gtp
--WHERE s.country = N'JAPAN';

SELECT name AS objectname
FROM sys.tables t
     CROSS APPLY
(
    SELECT COUNT(*)
    FROM (SELECT a  from sys.tables a)
) AS C;