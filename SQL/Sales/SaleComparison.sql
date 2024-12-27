WITH salesgrowth_2024 AS (
    SELECT currentYear.productLine, currentYear.month, currentYear.year,
           (currentYear.productsSold - previousYear.productsSold) / previousYear.productsSold * 100 AS salesGrowth
    FROM
    (SELECT p.productLine, MONTH(o.orderDate) AS month, YEAR(o.orderDate) AS year,
            COUNT(od.productCode) AS productsSold
     FROM orders AS o
     JOIN orderdetails AS od ON o.orderNumber = od.orderNumber
     JOIN products AS p ON od.productCode = p.productCode
     WHERE o.status != 'Cancelled' AND YEAR(o.orderDate) = YEAR(CURDATE())
     GROUP BY p.productLine, MONTH(o.orderDate), YEAR(o.orderDate)) AS currentYear
    LEFT JOIN
    (SELECT p.productLine, MONTH(o.orderDate) AS month, YEAR(o.orderDate) AS year,
            COUNT(od.productCode) AS productsSold
     FROM orders AS o
     JOIN orderdetails AS od ON o.orderNumber = od.orderNumber
     JOIN products AS p ON od.productCode = p.productCode
     WHERE o.status != 'Cancelled' AND YEAR(o.orderDate) = YEAR(CURDATE()) - 1
     GROUP BY p.productLine, MONTH(o.orderDate), YEAR(o.orderDate)) AS previousYear
    ON currentYear.productLine = previousYear.productLine AND currentYear.month = previousYear.month
),
salesgrowth_2023 AS (
    SELECT currentYear.productLine, currentYear.month, currentYear.year,
           (currentYear.productsSold - previousYear.productsSold) / previousYear.productsSold * 100 AS salesGrowth
    FROM
    (SELECT p.productLine, MONTH(o.orderDate) AS month, YEAR(o.orderDate) AS year,
            COUNT(od.productCode) AS productsSold
     FROM orders AS o
     JOIN orderdetails AS od ON o.orderNumber = od.orderNumber
     JOIN products AS p ON od.productCode = p.productCode
     WHERE o.status != 'Cancelled' AND YEAR(o.orderDate) = YEAR(CURDATE()) - 1
     GROUP BY p.productLine, MONTH(o.orderDate), YEAR(o.orderDate)) AS currentYear
    LEFT JOIN
    (SELECT p.productLine, MONTH(o.orderDate) AS month, YEAR(o.orderDate) AS year,
            COUNT(od.productCode) AS productsSold
     FROM orders AS o
     JOIN orderdetails AS od ON o.orderNumber = od.orderNumber
     JOIN products AS p ON od.productCode = p.productCode
     WHERE o.status != 'Cancelled' AND YEAR(o.orderDate) = YEAR(CURDATE()) - 2
     GROUP BY p.productLine, MONTH(o.orderDate), YEAR(o.orderDate)) AS previousYear
    ON currentYear.productLine = previousYear.productLine AND currentYear.month = previousYear.month
    WHERE currentYear.month > 2
)
SELECT *
FROM salesgrowth_2024
UNION ALL
SELECT *
FROM salesgrowth_2023;