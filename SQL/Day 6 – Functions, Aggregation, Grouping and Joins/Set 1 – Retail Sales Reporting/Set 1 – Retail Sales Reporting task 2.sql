-- TASK 2

-- Customer Name in Uppercase

SELECT
    customer_id,
    UPPER(customer_name) AS customer_name_upper
FROM customers;


-- Full Customer Address Using CONCAT

SELECT
    customer_id,
    CONCAT(customer_name, ' - ', city) AS customer_details
FROM customers;


-- Days Since Order Was Placed

SELECT
    order_id,
    order_date,
    DATEDIFF(DAY, order_date, GETDATE()) AS days_since_order
FROM orders;


-- Month and Year of Order

SELECT
    order_id,
    FORMAT(order_date, 'MMMM yyyy') AS order_month
FROM orders;


-- Rounded Order Amount

SELECT
    o.order_id,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_order_amount
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY o.order_id;


-- Customer-Friendly Order Report

SELECT
    o.order_id,
    CONCAT('Order #', o.order_id) AS order_number,
    UPPER(c.customer_name) AS customer_name,
    FORMAT(o.order_date, 'dd MMM yyyy') AS order_date,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_amount,
    DATEDIFF(DAY, o.order_date, GETDATE()) AS days_since_order
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY
    o.order_id,
    c.customer_name,
    o.order_date;