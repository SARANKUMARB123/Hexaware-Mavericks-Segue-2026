-- TASK 3

-- COUNT(*) Counts All Rows Including Rows with NULL Values

SELECT
    COUNT(*) AS total_rows
FROM customers;


-- COUNT(column) Counts Only Non-NULL Values

SELECT
    COUNT(phone_number) AS customers_with_phone_numbers
FROM customers;


-- AVG(column) Ignores NULL Values

SELECT
    AVG(discount) AS average_discount
FROM orders;


-- Example Showing NULL Behaviour Together

SELECT
    COUNT(*) AS total_orders,
    COUNT(discount) AS orders_with_discount,
    AVG(discount) AS average_discount
FROM orders;