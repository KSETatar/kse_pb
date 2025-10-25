-- BAD QUERY (returns correct data but is slow)
EXPLAIN
SELECT DISTINCT c.customer_id,
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
LIMIT 20;




