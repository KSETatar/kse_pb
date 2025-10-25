-- 1.1 Create schema
DROP DATABASE IF EXISTS bigshop;
CREATE DATABASE IF NOT EXISTS bigshop;
USE bigshop;

-- 1.2 Tables (row-oriented OLTP design) 
-- (Short INT/BIGINT PKs are ideal for clustered index & secondary index size) 
CREATE TABLE customers (
  customer_id INT PRIMARY KEY AUTO_INCREMENT,
  country CHAR(2) NOT NULL,
  created_at DATETIME NOT NULL
) ENGINE=InnoDB;

CREATE TABLE products (
  product_id INT PRIMARY KEY AUTO_INCREMENT,
  category_id INT NOT NULL,
  price_cents INT NOT NULL,
  created_at DATETIME NOT NULL
) ENGINE=InnoDB;

CREATE TABLE orders (
  order_id BIGINT PRIMARY KEY AUTO_INCREMENT,
  customer_id INT NOT NULL,
  order_ts DATETIME NOT NULL,
  status ENUM('new','paid','shipped','canceled') NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
) ENGINE=InnoDB;

CREATE TABLE order_items (
  order_id BIGINT NOT NULL,
  product_id INT NOT NULL,
  qty INT NOT NULL,
  item_amount_cents INT NOT NULL,
  PRIMARY KEY (order_id, product_id),
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
) ENGINE=InnoDB;

-- Helper: a million-sequence generator (adjust N as needed)

SHOW VARIABLES LIKE 'cte_max_recursion_depth';
SET SESSION cte_max_recursion_depth = 2000000;

WITH RECURSIVE seq AS (
  SELECT 1 AS n
  UNION ALL SELECT n+1 FROM seq WHERE n < 1000000
)
SELECT COUNT(*) FROM seq; -- sanity check

-- customers ≈ 1,000,000

INSERT INTO customers(country, created_at)
SELECT
  CASE WHEN n % 5 = 0 THEN 'US'
       WHEN n % 5 = 1 THEN 'DE'
       WHEN n % 5 = 2 THEN 'UA'
       WHEN n % 5 = 3 THEN 'PL'
       ELSE 'GB' END,
  DATE_ADD('2023-01-01', INTERVAL (n % 700) DAY)
FROM (
  WITH RECURSIVE seq AS (
    SELECT 1 n UNION ALL SELECT n+1 FROM seq WHERE n < 1000000
  ) SELECT n FROM seq
) s;

-- products ≈ 1,000,000
INSERT INTO products(category_id, price_cents, created_at)
SELECT (n % 5000) + 1,
       100 + (n % 50000),
       DATE_ADD('2023-01-01', INTERVAL (n % 700) DAY)
FROM (
  WITH RECURSIVE seq AS (
    SELECT 1 n UNION ALL SELECT n+1 FROM seq WHERE n < 1000000
  ) SELECT n FROM seq
) s;

-- orders ≈ 10,000,000  (generate in chunks; example 1M chunk, run 10x)
INSERT INTO orders(customer_id, order_ts, status)
SELECT 1 + (n % 1000000),
       DATE_ADD('2024-01-01', INTERVAL (n % 365) DAY) + INTERVAL (n % 86400) SECOND,
       CASE (n % 20)
         WHEN 0 THEN 'canceled'
         WHEN 1 THEN 'new'
         WHEN 2 THEN 'shipped'
         ELSE 'paid'
       END
FROM (
  WITH RECURSIVE seq AS (
    SELECT 1 n UNION ALL SELECT n+1 FROM seq WHERE n < 1000000
  ) SELECT n FROM seq
) s;

-- order_items ≈ 3 per order on average (≈30,000,000)
-- (Again, load in chunks alongside the orders you just inserted.)

INSERT INTO order_items(order_id, product_id, qty, item_amount_cents)
SELECT o.order_id,
       1 + (o.order_id % 1000000),            -- pseudo product distribution
       1 + (o.order_id % 3),
       (1 + (o.order_id % 3)) * (100 + (o.order_id % 50000))
FROM orders o
WHERE o.order_id BETWEEN 1 AND 1000000;       -- repeat per chunk range

-- -- -- -- 



