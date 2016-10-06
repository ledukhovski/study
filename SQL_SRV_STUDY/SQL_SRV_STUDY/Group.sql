/* Grouping Sets*/

SELECT o.type AS ObjectType,
       s.name AS SchemeName,
       COUNT(*)
FROM sys.objects o
     JOIN sys.schemas s ON o.schema_id = s.schema_id
GROUP BY GROUPING SETS((o.type), (s.name), (), (o.type, s.name));

/*The CUBE clause accepts a list of expressions as
inputs and defines all possible grouping sets that can be generated from the inputs—including
the empty grouping set.

Equal with CUBE:*/

SELECT o.type AS ObjectType,
       s.name AS SchemeName,
       COUNT(*)
FROM sys.objects o
     JOIN sys.schemas s ON o.schema_id = s.schema_id
GROUP BY CUBE(o.type, s.name);