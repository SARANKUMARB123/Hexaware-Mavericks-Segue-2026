-- TASK 1

-- Policies Expiring in the Next 30 Days

SELECT
    policy_id,
    policy_number,
    customer_id,
    expiry_date
FROM policies
WHERE expiry_date BETWEEN GETDATE() AND DATEADD(DAY,30,GETDATE());


-- Premium Collected Per Product

SELECT
    p.product_name,
    SUM(pr.premium_amount) AS total_premium
FROM policies po
JOIN premiums pr
ON po.policy_id = pr.policy_id
JOIN products p
ON po.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_premium DESC;


-- Customers with More Than One Active Policy

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(po.policy_id) AS active_policies
FROM customers c
JOIN policies po
ON c.customer_id = po.customer_id
WHERE po.status = 'Active'
GROUP BY
    c.customer_id,
    c.customer_name
HAVING COUNT(po.policy_id) > 1;


-- Claim Ratio Per Product

SELECT
    p.product_name,
    COUNT(cl.claim_id) * 1.0 / COUNT(DISTINCT po.policy_id) AS claim_ratio
FROM products p
JOIN policies po
ON p.product_id = po.product_id
LEFT JOIN claims cl
ON po.policy_id = cl.policy_id
GROUP BY p.product_name;


-- Policies Without Claims

SELECT
    po.policy_id,
    po.policy_number
FROM policies po
LEFT JOIN claims cl
ON po.policy_id = cl.policy_id
WHERE cl.claim_id IS NULL;


-- Average Premium by Age Band

SELECT
    CASE
        WHEN c.age < 30 THEN 'Below 30'
        WHEN c.age BETWEEN 30 AND 50 THEN '30-50'
        ELSE 'Above 50'
    END AS age_band,
    ROUND(AVG(pr.premium_amount),2) AS average_premium
FROM customers c
JOIN policies po
ON c.customer_id = po.customer_id
JOIN premiums pr
ON po.policy_id = pr.policy_id
GROUP BY
    CASE
        WHEN c.age < 30 THEN 'Below 30'
        WHEN c.age BETWEEN 30 AND 50 THEN '30-50'
        ELSE 'Above 50'
    END;


-- Monthly New Policies

SELECT
    FORMAT(start_date,'yyyy-MM') AS policy_month,
    COUNT(policy_id) AS total_policies
FROM policies
GROUP BY FORMAT(start_date,'yyyy-MM')
ORDER BY policy_month;


-- Top 5 Agents by Premium

SELECT TOP 5
    agent_id,
    SUM(pr.premium_amount) AS total_premium
FROM policies po
JOIN premiums pr
ON po.policy_id = pr.policy_id
GROUP BY agent_id
ORDER BY total_premium DESC;