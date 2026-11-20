-- TASK 2

-- Formatted Invoice Number

SELECT
    invoice_id,
    CONCAT('INV-', RIGHT('00000' + CAST(invoice_id AS VARCHAR(5)), 5)) AS formatted_invoice_number
FROM invoices;


-- Due-Date Status

SELECT
    invoice_id,
    invoice_number,
    due_date,
    CASE
        WHEN payment_date IS NOT NULL THEN 'Paid'
        WHEN GETDATE() <= due_date THEN 'Not Due'
        WHEN DATEDIFF(DAY, due_date, GETDATE()) <= 15 THEN 'Overdue'
        ELSE 'Overdue More Than 15 Days'
    END AS due_date_status
FROM invoices;


-- Days Until Due Date

SELECT
    invoice_id,
    invoice_number,
    DATEDIFF(DAY, GETDATE(), due_date) AS days_until_due
FROM invoices;


-- Customer-Friendly Invoice Report

SELECT
    i.invoice_id,
    CONCAT('INV-', RIGHT('00000' + CAST(i.invoice_id AS VARCHAR(5)), 5)) AS formatted_invoice_number,
    UPPER(s.subscriber_name) AS subscriber_name,
    FORMAT(i.invoice_date, 'dd MMM yyyy') AS invoice_date,
    FORMAT(i.due_date, 'dd MMM yyyy') AS due_date,
    i.amount,
    CASE
        WHEN i.payment_date IS NOT NULL THEN 'Paid'
        WHEN GETDATE() <= i.due_date THEN 'Not Due'
        WHEN DATEDIFF(DAY, i.due_date, GETDATE()) <= 15 THEN 'Overdue'
        ELSE 'Overdue More Than 15 Days'
    END AS due_date_status
FROM invoices i
JOIN subscribers s
ON i.subscriber_id = s.subscriber_id;