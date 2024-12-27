SELECT p.productLine, o.orderDate AS Date, YEAR(o.orderDate) AS year, COUNT(od.productCode) AS productsSold
FROM orders AS o
JOIN orderdetails AS od ON o.orderNumber = od.orderNumber
JOIN products AS p ON od.productCode = p.productCode
WHERE o.status != 'Cancelled'
GROUP BY p.productLine, o.orderDate, YEAR(o.orderDate)
ORDER BY year DESC;