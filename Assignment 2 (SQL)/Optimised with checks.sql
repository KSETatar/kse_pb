EXPLAIN 
WITH recent_paid_orders AS (                               -- CHANGED: replace correlated subquery + DATE() filter 
  SELECT o.order_id, o.customer_id
  FROM orders o
  WHERE o.status IN ('paid','shipped')
    AND o.order_ts >= NOW() - INTERVAL 365 DAY              -- CHANGED: sargable predicate (no DATE() on column) 
), electronics_items AS (                                  -- CHANGED: prefilter once instead of EXISTS per row 
  SELECT oi.order_id, oi.item_amount_cents
  FROM order_items oi
  JOIN products p ON p.product_id = oi.product_id
  WHERE p.category_id = 42                                 -- CHANGED: drop redundant IN(subselect) 
)
SELECT r.customer_id,                                      -- CHANGED: no DISTINCT; GROUP BY handles uniqueness 
       SUM(e.item_amount_cents) AS revenue_365d_cents
FROM recent_paid_orders r
JOIN electronics_items e
  ON e.order_id = r.order_id                               -- CHANGED: join on keys, no function-wrapped key
GROUP BY r.customer_id                                     -- CHANGED: explicit aggregation step 
ORDER BY revenue_365d_cents DESC
LIMIT 20;

-- -- -- 

WITH crap AS (SELECT DISTINCT c.customer_id,
       (SELECT SUM(oi.item_amount_cents)
          FROM order_items oi
          JOIN products p ON p.product_id = oi.product_id
         WHERE p.category_id IN (
                 SELECT category_id FROM products WHERE category_id = p.category_id
               )
           AND oi.order_id IN (
                 SELECT o.order_id FROM orders o
                  WHERE o.customer_id = c.customer_id
                    AND (o.status = 'paid' OR o.status = 'shipped')
                    AND DATE(o.order_ts) >= DATE(NOW()) - INTERVAL 365 DAY
               )
       ) AS revenue_365d_cents
FROM customers c
JOIN orders o ON CONCAT('', o.customer_id) = CONCAT('', c.customer_id)  -- function-wrapped key
WHERE o.status IN ('paid','shipped')
  AND DATE(o.order_ts) >= DATE(NOW()) - INTERVAL 365 DAY
  AND EXISTS (SELECT 1
                FROM order_items oi
                JOIN products p ON p.product_id = oi.product_id
               WHERE oi.order_id = o.order_id
                 AND p.category_id = 42)  -- “Electronics”
ORDER BY revenue_365d_cents DESC
LIMIT 20),
     good AS ( WITH recent_paid_orders AS (                               -- CHANGED: replace correlated subquery + DATE() filter 
  SELECT o.order_id, o.customer_id
  FROM orders o
  WHERE o.status IN ('paid','shipped')
    AND o.order_ts >= NOW() - INTERVAL 365 DAY              -- CHANGED: sargable predicate (no DATE() on column) 
), electronics_items AS (                                  -- CHANGED: prefilter once instead of EXISTS per row 
  SELECT oi.order_id, oi.item_amount_cents
  FROM order_items oi
  JOIN products p ON p.product_id = oi.product_id
  WHERE p.category_id = 42                                 -- CHANGED: drop redundant IN(subselect) 
)
SELECT r.customer_id,                                      -- CHANGED: no DISTINCT; GROUP BY handles uniqueness 
       SUM(e.item_amount_cents) AS revenue_365d_cents
FROM recent_paid_orders r
JOIN electronics_items e
  ON e.order_id = r.order_id                               -- CHANGED: join on keys, no function-wrapped key
GROUP BY r.customer_id                                     -- CHANGED: explicit aggregation step 
ORDER BY revenue_365d_cents DESC
LIMIT 20)
SELECT
  (SELECT COUNT(*) FROM crap) AS crap_rows,
  (SELECT COUNT(*) FROM good) AS good_rows,
  (SELECT COUNT(*) FROM (
      SELECT * FROM crap
      UNION ALL
      SELECT * FROM good
  ) t) AS union_all_rows,
  (SELECT COUNT(*) FROM (
      SELECT * FROM crap
      UNION
      SELECT * FROM good
  ) t) AS union_distinct_rows;


