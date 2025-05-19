-- Customer Lifetime Value (CLV) Estimation
-- This query calculates the estimated CLV based on account tenure and transaction volume.
USE `adashi_staging`;


SELECT u.id AS customer_id,
       CONCAT(u.first_name, ' ', u.last_name) AS name,
       TIMESTAMPDIFF(MONTH, u.date_joined, CURRENT_DATE) AS tenure_months,
       COUNT(DISTINCT s.id) AS total_transactions,
       ROUND((COUNT(DISTINCT s.id) / NULLIF(TIMESTAMPDIFF(MONTH, u.date_joined, CURRENT_DATE), 0)) * 12 * (SUM(s.confirmed_amount) * 0.001 * 0.001), 2) AS estimated_clv
FROM users_customuser u
LEFT JOIN savings_savingsaccount s ON u.id = s.owner_id
WHERE u.is_active = 1
GROUP BY u.id,
         u.first_name,
         u.last_name
HAVING tenure_months > 0
ORDER BY estimated_clv DESC;