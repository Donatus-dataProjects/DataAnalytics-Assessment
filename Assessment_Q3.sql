-- Account Inactivity Alert
-- This query finds all active accounts with no inflow transactions for over one year.

SELECT p.id AS plan_id,
       p.owner_id,
       CASE
           WHEN p.is_regular_savings = 1 THEN 'Savings'
           WHEN p.is_a_fund = 1 THEN 'Investment'
           ELSE 'Other'
       END AS TYPE,
       MAX(s.transaction_date) AS last_transaction_date,
       DATEDIFF('2025-05-17', MAX(s.transaction_date)) AS inactivity_days
FROM plans_plan p
LEFT JOIN savings_savingsaccount s ON p.id = s.plan_id
AND s.confirmed_amount > 0
WHERE p.is_deleted = 0
  AND p.is_archived = 0
  AND (p.is_regular_savings = 1
       OR p.is_a_fund = 1)
GROUP BY p.id,
         p.owner_id
HAVING MAX(s.transaction_date) IS NOT NULL
AND YEAR(MAX(s.transaction_date)) = 2024
AND MAX(s.transaction_date) < DATE_SUB('2025-05-17', INTERVAL 365 DAY)
ORDER BY inactivity_days DESC;