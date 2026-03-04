-- Order total_amount
SELECT 
    o.order_id,
    o.total_amount AS stored_total,
    SUM(p.price * oi.quantity) AS calculated_total,
    (o.total_amount - SUM(p.price * oi.quantity)) AS diff
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY o.order_id
HAVING diff <> 0;
-- Data Cleanup
UPDATE orders o
JOIN (
    SELECT 
        oi.order_id,
        SUM(p.price * oi.quantity) AS new_total
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY oi.order_id
) t ON o.order_id = t.order_id
SET o.total_amount = t.new_total;
--Complex JOIN Report
SELECT
    o.order_id,
    o.order_date,
    c.name AS customer_name,
    c.city,
    COUNT(oi.item_id) AS total_items,
    SUM(oi.quantity) AS total_qty,
    SUM(p.price * oi.quantity) AS revenue
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY o.order_id, o.order_date, c.name, c.city
ORDER BY revenue DESC;
