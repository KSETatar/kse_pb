-- Assignment 1 (insert_data.sql)

USE The_Lagoone;

INSERT INTO customers (customer_id, full_name, email, city, country, created_at) VALUES
(1,'Billy Berrington','billy.b@fellowbrother.com','Los Angeles','USA','2025-01-10'),
(2,'Val Darkholme','val.d@fellowbrother.com','San Jose','USA','2025-02-05'),
(3,'Steve Dambo','steve.d@fellowbrother.com','Phoenix','USA','2025-03-12'),
(4,'Martin Wolff','martin.w@fellowbrother.com','Montreal','Canada','2025-03-20'),
(5,'Tom Catt','tom.c@fellowbrother.com','New York','USA','2025-04-01'),
(6,'Ricardo Miles','ricardo.m@fellowbrother.com','Rio de Janeiro','Brazil','2025-04-15'),
(7,'Franço Sagat','franco.s@fellowbrother.com','Paris','France','2025-05-02'),
(8,'Pierre Pitch','pierre.p@fellowbrother.com','Ottawa','Canada','2025-05-20');

INSERT INTO categories VALUES
(1, 'Apparel & Costumes'),
(2, 'Media & Collectibles'),
(3, 'Studio Gear'),
(4, 'Gym & Training'),
(5, 'Accessories & Props');

INSERT INTO products VALUES
(1,  'Leather Harness (Deluxe Edition)', 1, 699.99),
(2,  'Collector Photo Book Set',          2, 1199.00),
(3,  'Premium Leather Gloves',            1, 149.99),
(4,  'Poster: The Lord of the Lockerroom', 2, 19.99),
(5,  'DVD: Behind the Scenes',            2, 59.99),
(6,  'Studio Light Stand',                3, 89.99),
(7,  'Red Bandana',                       1, 14.99),
(8,  'Windbreaker Jacket (Black)',        1, 79.99),
(9,  'Gym Towel Set',                     4, 39.99),
(10, 'Portable Boombox 10"',              3, 329.99);

INSERT INTO orders VALUES
(101, 3, '2025-07-03', 'shipped'),
(102, 2, '2025-07-15', 'shipped'),
(103, 3, '2025-08-05', 'shipped'),
(104, 4, '2025-08-20', 'shipped'),
(105, 5, '2025-09-02', 'shipped'),
(106, 6, '2025-09-18', 'shipped'),
(107, 7, '2025-09-28', 'shipped'),
(108, 8, '2025-10-01', 'shipped'),
(109, 1, '2025-10-05', 'processing'),
(110, 2, '2025-06-25', 'shipped'),
(111, 3, '2025-07-30', 'shipped'),
(112, 4, '2025-09-10', 'shipped');

INSERT INTO order_items VALUES
(1001, 101, 1, 1, 699.99),
(1002, 101, 3, 2, 149.99),
(1003, 102, 2, 1, 1199.00),
(1004, 102, 4, 2, 19.99),
(1005, 103, 5, 1, 59.99),
(1006, 103, 10, 1, 329.99),
(1007, 104, 6, 1, 89.99),
(1008, 104, 9, 2, 39.99),
(1009, 105, 1, 1, 699.99),
(1010, 105, 5, 2, 59.99),
(1011, 106, 2, 1, 1199.00),
(1012, 106, 3, 1, 149.99),
(1013, 106, 7, 3, 14.99),
(1014, 107, 10, 2, 329.99),
(1015, 107, 4, 3, 19.99),
(1016, 108, 8, 1, 79.99),
(1017, 108, 6, 1, 89.99),
(1018, 108, 3, 1, 149.99),
(1019, 109, 2, 1, 1199.00),
(1020, 109, 4, 1, 19.99),
(1021, 110, 7, 2, 14.99),
(1022, 110, 9, 1, 39.99),
(1023, 111, 10, 1, 329.99),
(1024, 111, 5, 1, 59.99),
(1025, 112, 1, 1, 699.99),
(1026, 112, 8, 1, 79.99);