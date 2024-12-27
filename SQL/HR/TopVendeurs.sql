SELECT *
FROM (
SELECT
e.firstName,
e.lastName,
YEAR(o.orderDate) AS year,
MONTH(o.orderDate) AS month, offi.country as Pays_bureau,
SUM(od.quantityOrdered * od.priceEach) AS total_ca,
RANK() OVER(PARTITION BY YEAR(o.orderDate), MONTH(o.orderDate) ORDER BY SUM(od.quantityOrdered * od.priceEach) DESC) AS Rang
FROM orders AS o
JOIN orderdetails AS od ON o.orderNumber = od.orderNumber
JOIN customers AS c ON c.customerNumber = o.customerNumber
JOIN employees AS e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices as offi ON offi.officeCode= e.officeCode
WHERE o.status != 'cancelled'
GROUP BY e.firstname, e.lastname, YEAR(o.orderDate), MONTH(o.orderDate), offi.country
ORDER BY year DESC, month DESC, total_ca DESC) AS S1
WHERE Rang < 3
ORDER BY 'year' DESC, 'month' DESC, 'employee' DESC;