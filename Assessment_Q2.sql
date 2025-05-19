-- Transaction Frequency Analysis
-- This query calculates the average number of transactions per customer per month
-- and categorizes them into frequency categories.
USE `adashi_staging`;


SELECT frequency_category,
       COUNT(DISTINCT u.id) AS customer_count,
       ROUND(AVG(transactions_per_month), 2) AS avg_transactions_per_month
FROM
  (SELECT s.owner_id,
          COUNT(*) AS transactions_per_month,
          CASE
              WHEN COUNT(*) >= 10 THEN 'High Frequency'
              WHEN COUNT(*) BETWEEN 3 AND 9 THEN 'Medium Frequency'
              ELSE 'Low Frequency'
          END AS frequency_category
   FROM savings_savingsaccount s
   WHERE s.transaction_date IS NOT NULL
   GROUP BY s.owner_id,
            YEAR(s.transaction_date),
            MONTH(s.transaction_date)) AS monthly_transactions
JOIN users_customuser u ON u.id = monthly_transactions.owner_id
GROUP BY frequency_category
ORDER BY FIELD(frequency_category, 'High Frequency', 'Medium Frequency', 'Low Frequency');