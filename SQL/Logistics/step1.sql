/*  ETAPE 1: établir le total des ventes pour chaque produit */ 
SELECT productCode,  SUM(quantityOrdered) AS total_des_ventes	-- addition des produits vendus (total_des_ventes) sélectionnés par ID
FROM orderdetails			-- Colonne du détail des ventes
GROUP BY productCode;
