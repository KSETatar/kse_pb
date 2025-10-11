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
