-- TASK 1

-- Total Call Minutes Per Plan

SELECT
    p.plan_name,
    SUM(cr.call_minutes) AS total_call_minutes
FROM plans p
JOIN subscribers s
ON p.plan_id = s.plan_id
JOIN call_records cr
ON s.subscriber_id = cr.subscriber_id
GROUP BY p.plan_name
ORDER BY total_call_minutes DESC;


-- Subscribers Exceeding Their Data Limit

SELECT
    s.subscriber_id,
    s.subscriber_name,
    p.plan_name,
    SUM(cr.data_used_mb) AS total_data_used,
    p.data_limit_mb
FROM subscribers s
JOIN plans p
ON s.plan_id = p.plan_id
JOIN call_records cr
ON s.subscriber_id = cr.subscriber_id
GROUP BY
    s.subscriber_id,
    s.subscriber_name,
    p.plan_name,
    p.data_limit_mb
HAVING SUM(cr.data_used_mb) > p.data_limit_mb;


-- Month-wise Revenue

SELECT
    FORMAT(invoice_date,'yyyy-MM') AS revenue_month,
    SUM(amount) AS total_revenue
FROM invoices
GROUP BY FORMAT(invoice_date,'yyyy-MM')
ORDER BY revenue_month;


-- Invoices Overdue by More Than 15 Days

SELECT
    invoice_id,
    invoice_number,
    subscriber_id,
    due_date,
    amount
FROM invoices
WHERE payment_date IS NULL
AND DATEDIFF(DAY,due_date,GETDATE()) > 15;


-- Subscribers With No Usage

SELECT
    s.subscriber_id,
    s.subscriber_name
FROM subscribers s
LEFT JOIN call_records cr
ON s.subscriber_id = cr.subscriber_id
WHERE cr.record_id IS NULL;


-- Average Revenue Per User (ARPU) by Circle

SELECT
    s.circle,
    ROUND(AVG(i.amount),2) AS arpu
FROM subscribers s
JOIN invoices i
ON s.subscriber_id = i.subscriber_id
GROUP BY s.circle
ORDER BY arpu DESC;


-- Plan Popularity

SELECT
    p.plan_name,
    COUNT(s.subscriber_id) AS total_subscribers
FROM plans p
JOIN subscribers s
ON p.plan_id = s.plan_id
GROUP BY p.plan_name
ORDER BY total_subscribers DESC;


-- Top 10 Data Consumers

SELECT TOP 10
    s.subscriber_id,
    s.subscriber_name,
    SUM(cr.data_used_mb) AS total_data_used
FROM subscribers s
JOIN call_records cr
ON s.subscriber_id = cr.subscriber_id
GROUP BY
    s.subscriber_id,
    s.subscriber_name
ORDER BY total_data_used DESC;