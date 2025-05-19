# DataAnalytics-Assessment
This repository contains SQL solutions for a Data Analyst Assessment designed to evaluate my proficiency in relational databases.
The assessment consists of multiple questions that test my skills in data retrieval, aggregation, joins, subqueries, and data manipulation across various tables.

### Repository Structure
##### Assessment_Q1.sql: High-Value Customers with Multiple Products
##### Assessment_Q2.sql: Transaction Frequency Analysis
##### Assessment_Q3.sql: Account Inactivity Alert
##### Assessment_Q4.sql: Customer Lifetime Value (CLV) Estimation

The README.md documentation explains each question's approach, challenges, and solution.

### Question 1 High-Value Customers with Multiple Products
#### Objective
The goal was to identify customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits. This information can help the business explore cross-selling opportunities.

### Steps Taken:
#### Identifying Relevant Tables:
users_customuser: Contains customer demographic information.
plans_plan: Holds details about the plans created by customers, indicating whether they are savings or investment plans.
savings_savingsaccount: Contains records of deposit transactions, including confirmed amounts.

#### Joining Tables:
I joined the users_customuser table with the plans_plan table on owner_id to establish the relationship between customers and their plans.
Using a left join with the savings_savingsaccount table to include all plans while only bringing in relevant savings account data.

#### Conditional Counting:
By employing COUNT(DISTINCT CASE WHEN...) to count the number of funded savings plans (is_regular_savings = 1) and funded investment plans (is_a_fund = 1). This allowed me to track how many of each type of plan each customer holds.

#### Calculating Total Deposits:
I calculated the total deposits by summing the confirmed_amount from the savings_savingsaccount table, converting the values from kobo to naira by multiplying by 0.001.

#### Filtering Active Customers:
I included a condition in the WHERE clause to consider only active customers (u.is_active = 1).

#### Grouping and Filtering Results:
By grouping the results by customer ID and name to aggregate the counts and total deposits.
The HAVING clause ensured that only customers with at least one savings and one investment plan were included in my result.

#### Sorting Results:
I ordered the results by total deposits in descending order to prioritize customers with higher deposits.

#### Outcome
This structured approach effectively helped me to identifie high-value customers who have both types of plans and provides a clear view of their total contributions, aiding in potential marketing strategies.
