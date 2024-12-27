/* ETAPE 3: établir le stock actuel des 5 meilleures ventes */ 
SELECT  products.productCode, productName,productLine, total_des_ventes,quantityInStock
FROM products
INNER JOIN (
  SELECT productCode, SUM(quantityOrdered) AS total_des_ventes		-- JOINTURE  DE LA TABLE products AVEC LA REQUETE ETAPE 2
  FROM orderdetails													 
  GROUP BY productCode
  ORDER BY total_des_ventes DESC
  LIMIT 5
) orderdetails ON products.productCode = orderdetails.productCode;