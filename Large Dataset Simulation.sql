-- Duplicate orders
INSERT INTO orders (customer_id, order_date, total_amount)
SELECT customer_id, order_date, total_amount
FROM orders;
