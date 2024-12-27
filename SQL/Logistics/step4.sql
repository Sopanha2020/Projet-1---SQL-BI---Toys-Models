/* ETAPE 4: Requêtes bonus pour afficher par mois le détail des ventes des 5 meilleurs moddèles et leur stock */ 
SELECT *
FROM
(SELECT products.productCode, productName, productLine,
SUM(quantityOrdered) AS total_des_ventes, quantityInStock,
DATE_FORMAT(orderDate, "%Y-%m") AS commande_par_mois,
RANK() OVER(PARTITION BY DATE_FORMAT(orderDate, "%Y-%m"), orderDate ORDER BY orderDate DESC) AS ranking
FROM products
INNER JOIN orderdetails ON products.productCode = orderdetails.productCode
INNER JOIN orders ON orders.orderNumber = orderdetails.orderNumber
GROUP BY products.productCode, commande_par_mois, orderDate
ORDER BY DATE_FORMAT(orderDate, "%Y-%m") DESC, total_des_ventes DESC) AS five_best_sellers
WHERE ranking<6;