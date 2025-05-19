-- High-Value Customers with Multiple Products
-- This query identifies customers with with at least one funded savings plan AND one funded investment plan, sorted by total deposits.

SELECT p.owner_id, -- Return owner_id
 CONCAT(u.first_name, ' ', u.last_name) AS name, -- Combine first and last names
 COUNT(DISTINCT CASE
                    WHEN p.is_regular_savings = 1 THEN p.id
                END) AS savings_count, -- Count funded savings plans
 COUNT(DISTINCT CASE
                    WHEN p.is_a_fund = 1 THEN p.id
                END) AS investment_count, -- Count funded investment plans
 SUM(sa.confirmed_amount) * 0.001 AS total_deposits -- Convert kobo to naira
FROM users_customuser u
JOIN plans_plan p ON u.id = p.owner_id
LEFT JOIN savings_savingsaccount sa ON p.id = sa.plan_id
AND sa.confirmed_amount > 0
WHERE u.is_active = 1
GROUP BY u.id,
         u.first_name,
         u.last_name
HAVING savings_count > 0
AND investment_count > 0 -- Ensure both savings and investment plans exist
ORDER BY total_deposits DESC; -- Sort by total deposits