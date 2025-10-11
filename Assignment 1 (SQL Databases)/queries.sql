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
  SUM(oi.quantity)                 AS total_qty,          -- total items bought (post-filter)
  SUM(oi.quantity * oi.unit_price) AS total_revenue,      -- revenue contributed
  COUNT(DISTINCT oq.order_id)      AS orders_count,       -- unique orders in Q3
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

-- -- -- -- 

-- -- A brief explanation of my schema and query logic
-- Basically a "definitly just some regular small shop" database.
-- There are 5 tables - "customers", "categories", products", "orders", and "order_items".
-- Each connects with foreign keys like a normal store setup.
-- Everything lives in three files:
-- create_tables.sql - makes the tables.
-- insert_data.sql - fills them with themed data.
-- queries.sql - the actual query logic.

-- -- Schema idea
-- "customers": people buying stuff (id, name, email, etc.)
-- "categories": product types like Apparel & Costumes, Media & Collectibles, etc.
-- "products": items with prices and categories.
-- "orders": when someone buys something.
-- "order_items": connects orders and products, with quantity and price.

-- -- Query logic The main query does one big analysis:
-- Uses CTEs to limit data to Q3 2025 orders and to get average price per category.
-- Joins all five tables.
-- Filters products that cost more than their category average (big money).
-- Keeps only specific categories and customers who bought at least two items.
-- Sorts by revenue, supposed to show the top 5.

-- Then theres also a piece of code with UNION function for the bonus task

