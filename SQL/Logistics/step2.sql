/* ETAPE 2: déterminer les 5 meilleures ventes */
SELECT productCode, SUM(quantityOrdered) AS total_des_ventes, orderDate
FROM orderdetails
INNER JOIN orders ON orderdetails.orderNumber=orders.orderNumber
GROUP BY productCode, orderDate
ORDER BY total_des_ventes DESC					-- classement du total_des_ventes par ordre décroissant
LIMIT 5;							-- utilisation de la limite pour sélectionner les 5 premiers