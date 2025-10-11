-- Assignment 1 (create_tables.sql)

CREATE DATABASE IF NOT EXISTS The_Lagoone
  DEFAULT CHARACTER SET utf8mb4;
USE The_Lagoone;

DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
  customer_id   INT PRIMARY KEY,
  full_name     VARCHAR(100) NOT NULL,
  email         VARCHAR(120) UNIQUE NOT NULL,
  city          VARCHAR(80),
  country       VARCHAR(80),
  created_at    DATE NOT NULL
);

CREATE TABLE categories (
  category_id   INT PRIMARY KEY,
  category_name VARCHAR(60) NOT NULL
);

CREATE TABLE products (
  product_id    INT PRIMARY KEY,
  product_name  VARCHAR(120) NOT NULL,
  category_id   INT NOT NULL,
  unit_price    DECIMAL(10,2) NOT NULL CHECK (unit_price >= 0),
  FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE orders (
  order_id      INT PRIMARY KEY,
  customer_id   INT NOT NULL,
  order_date    DATE NOT NULL,
  status        VARCHAR(30) NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
  order_item_id INT PRIMARY KEY,
  order_id      INT NOT NULL,
  product_id    INT NOT NULL,
  quantity      INT NOT NULL CHECK (quantity > 0),
  unit_price    DECIMAL(10,2) NOT NULL CHECK (unit_price >= 0),
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);


-- -- -- -- -- --

SELECT full_name, email FROM customers;
