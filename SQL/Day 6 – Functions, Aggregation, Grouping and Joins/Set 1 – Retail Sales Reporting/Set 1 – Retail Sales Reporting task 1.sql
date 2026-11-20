-- TASK 1

-- Top 5 Products by Revenue

SELECT TOP 5
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC;


-- Month-wise Sales

SELECT
    FORMAT(o.order_date,'yyyy-MM') AS sales_month,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY FORMAT(o.order_date,'yyyy-MM')
ORDER BY sales_month;


-- Customers with More Than 3 Orders

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
HAVING COUNT(o.order_id) > 3
ORDER BY total_orders DESC;


-- Average Basket Value Per City

SELECT
    c.city,
    ROUND(AVG(order_total.total_amount),2) AS average_basket_value
FROM customers c
JOIN
(
    SELECT
        o.order_id,
        o.customer_id,
        SUM(oi.quantity * oi.unit_price) AS total_amount
    FROM orders o
    JOIN order_items oi
    ON o.order_id = oi.order_id
    GROUP BY
        o.order_id,
        o.customer_id
) AS order_total
ON c.customer_id = order_total.customer_id
GROUP BY c.city
ORDER BY average_basket_value DESC;


-- Orders Without Payment

SELECT
    o.order_id,
    o.order_date,
    c.customer_name
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
LEFT JOIN payments p
ON o.order_id = p.order_id
WHERE p.payment_id IS NULL;


-- Customers With No Orders

SELECT
    c.customer_id,
    c.customer_name
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;


-- Product Category Revenue Share

SELECT
    p.category,
    SUM(oi.quantity * oi.unit_price) AS category_revenue,
    ROUND(
        SUM(oi.quantity * oi.unit_price) * 100.0 /
        (
            SELECT SUM(quantity * unit_price)
            FROM order_items
        ),2
    ) AS revenue_percentage
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY category_revenue DESC;


-- Day with Highest Sales

SELECT TOP 1
    CAST(o.order_date AS DATE) AS sales_date,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY CAST(o.order_date AS DATE)
ORDER BY total_sales DESC;