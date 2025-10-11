-- Assignment 1 (queries.sql)

USE The_Lagoone;

WITH
orders_q3_2025 AS (
  SELECT o.order_id, o.customer_id, o.order_date
  FROM orders o
  WHERE o.order_date >= '2025-07-01'
    AND o.order_date <  '2025-10-01'
),
avg_price_by_category AS (
  SELECT p.category_id, AVG(p.unit_price) AS avg_price_in_cat
  FROM products p
  GROUP BY p.category_id
)
SELECT
  c.customer_id,
  c.full_name,
  SUM(oi.quantity)                 AS total_qty,          
  SUM(oi.quantity * oi.unit_price) AS total_revenue,      
  COUNT(DISTINCT oq.order_id)      AS orders_count,    
  MIN(oq.order_date)               AS first_order_q3,
  MAX(oq.order_date)               AS last_order_q3
FROM orders_q3_2025 oq
JOIN customers       c   ON c.customer_id   = oq.customer_id
JOIN order_items     oi  ON oi.order_id     = oq.order_id
JOIN products        p   ON p.product_id    = oi.product_id
JOIN categories      cat ON cat.category_id = p.category_id
JOIN avg_price_by_category a ON a.category_id = p.category_id
WHERE p.unit_price >= a.avg_price_in_cat
  AND cat.category_name IN ('Apparel & Costumes','Media & Collectibles','Studio Gear')
GROUP BY c.customer_id, c.full_name
HAVING SUM(oi.quantity) >= 2
ORDER BY total_revenue DESC, total_qty DESC, c.customer_id
LIMIT 5;

-- -- -- -- -- --

SELECT 'Apparel & Costumes' AS category_name, product_name
FROM products p
JOIN categories c ON c.category_id = p.category_id
WHERE c.category_name = 'Apparel & Costumes'

UNION 

SELECT 'Media & Collectibles' AS category_name, product_name
FROM products p
JOIN categories c ON c.category_id = p.category_id
WHERE c.category_name = 'Media & Collectibles'
ORDER BY category_name, product_name;



