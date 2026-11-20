-- TASK 2

-- Policy Age Using DATEDIFF

SELECT
    policy_id,
    policy_number,
    DATEDIFF(YEAR, start_date, GETDATE()) AS policy_age_years
FROM policies;


-- Policy Renewal Date Using DATEADD

SELECT
    policy_id,
    policy_number,
    DATEADD(YEAR, 1, expiry_date) AS next_renewal_date
FROM policies;


-- Policy Age Band Using CASE

SELECT
    policy_id,
    policy_number,
    CASE
        WHEN DATEDIFF(YEAR, start_date, GETDATE()) < 1 THEN 'Less than 1 Year'
        WHEN DATEDIFF(YEAR, start_date, GETDATE()) BETWEEN 1 AND 5 THEN '1 - 5 Years'
        ELSE 'More than 5 Years'
    END AS policy_age_band
FROM policies;


-- Masked Policy Number Using String Functions

SELECT
    policy_id,
    CONCAT(
        LEFT(policy_number, 4),
        '****',
        RIGHT(policy_number, 4)
    ) AS masked_policy_number
FROM policies;


-- Customer-Friendly Policy Report

SELECT
    po.policy_id,
    CONCAT(
        LEFT(po.policy_number, 4),
        '****',
        RIGHT(po.policy_number, 4)
    ) AS masked_policy_number,
    UPPER(c.customer_name) AS customer_name,
    DATEDIFF(YEAR, po.start_date, GETDATE()) AS policy_age_years,
    CASE
        WHEN DATEDIFF(YEAR, po.start_date, GETDATE()) < 1 THEN 'Less than 1 Year'
        WHEN DATEDIFF(YEAR, po.start_date, GETDATE()) BETWEEN 1 AND 5 THEN '1 - 5 Years'
        ELSE 'More than 5 Years'
    END AS policy_age_band,
    DATEADD(YEAR, 1, po.expiry_date) AS next_renewal_date
FROM policies po
JOIN customers c
ON po.customer_id = c.customer_id;