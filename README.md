# DataAnalytics-Assessment
This repository contains SQL solutions for a Data Analyst Assessment designed to evaluate my proficiency in relational databases.
The assessment consists of multiple questions that test my skills in data retrieval, aggregation, joins, subqueries, and data manipulation across various tables.

### Repository Structure
##### Assessment_Q1.sql: High-Value Customers with Multiple Products
##### Assessment_Q2.sql: Transaction Frequency Analysis
##### Assessment_Q3.sql: Account Inactivity Alert
##### Assessment_Q4.sql: Customer Lifetime Value (CLV) Estimation

The README.md documentation explains each question's approach, challenges, and solution.

## Question 1 High-Value Customers with Multiple Products
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


## Explanation Approach to Question 2: Transaction Frequency Analysis

#### Objective:
#### To categorize customers based on their transaction frequency:
#### High Frequency (≥10 transactions/month)
#### Medium Frequency (3-9 transactions/month), and 
#### Low Frequency (≤2 transactions/month).

#### Steps Taken

#### Identifying Relevant Tables:
#### Used users_customuser for customer data and savings_savingsaccount for transaction records.

#### Join Tables:
Joining users_customuser with savings_savingsaccount on the customer ID to link customers with their transaction records.

#### Count Transactions:
I Utilized COUNT(*) with a GROUP BY clause to count transactions per customer, grouped by month.

#### Categorize Frequency:
I implemented a CASE statement to classify customers based on their transaction count.

#### Filter Active Customers:
By adding a condition to consider only active customers.

#### Sorting Results:
Irdered results by customer ID for clarity.

#### Challenges and Resolution
Determining the monthly frequency required careful date handling.
Using date functions to extract the month and year for accurate grouping.

#### Handling NULL Values:
Some customers may have no transactions and I used left join and filtered out NULLs in the final output.

Ensuring the query performed well with large datasets, optimized joins and used indexing where applicable.
This approach successfully categorized customers based on their transaction frequency, providing valuable insights for marketing strategies.


## Explanation of Approach to Question 3: Account Inactivity Alert

#### Objective
The goal is to identify active accounts with no inflow transactions for over one year, allowing the business to take proactive measures for customer engagement.

#### Steps Taken

#### Identifying Relevant Tables:
Using plans_plan for account details and savings_savingsaccount for transaction records.

#### Join Tables:
Performing a left join between plans_plan and savings_savingsaccount on plan_id to connect accounts with their transaction history.

#### Determining Account Type:
Useinga CASE statement to classify each account as "Savings," "Investment," or "Other."

#### Calculate Last Transaction Date:
Utilizing MAX(s.transaction_date) to find the most recent transaction date for each account.

#### Filtering for Inactivity:
Applying conditions in the HAVING clause to check for accounts with no transactions in the last year and ensured the last transaction occurred in 2024.

#### Sorting Results:
Ordering results by the number of inactivity days to prioritize accounts with the longest inactivity.

#### Challenges and Resolution:
Establishing a clear definition for inactivity required careful consideration and reviewing business needs to set the inactivity threshold at one year.

#### Handling NULL Values:
Ensuring accounts without transactions were correctly identified.
Used left joins and filtered in the HAVING clause to avoid NULL transactions.

#### Performance Optimization:
Ensuring the query performed efficiently with potentially large datasets.
Optimizing joins and indexed key columns to improve query execution time.

This approach effectively identifies accounts at risk of inactivity, allowing for targeted outreach strategies to reduce churn.


## Explanation of Approach to Question 4: Customer Lifetime Value (CLV) Estimation

#### Objective
The goal is to estimate the Customer Lifetime Value (CLV) based on account tenure and transaction volume, providing insights for marketing strategies.

#### Steps Taken
Identifying Relevant Tables:

#### Using users_customuser for customer data and savings_savingsaccount for transaction records.

#### Joining Tables:
Performing a left join between users_customuser and savings_savingsaccount on customer ID to link customers with their transactions.

#### Calculating Tenure:
I used TIMESTAMPDIFF(MONTH, u.date_joined, CURRENT_DATE) to calculate the number of months the account has been active.

#### Counting Transactions:
Utilizing COUNT(DISTINCT s.id) to count unique transactions for each customer.

#### Estimating CLV:
I calculated the estimated CLV using the formula that considers transaction frequency and total transaction value, factoring a profit margin of 0.1%.

#### Filtering and Sorting Results:
I included HAVING clause to exclude customers with zero tenure and ordered results by estimated CLV in descending order.

#### Challenges/ Resolution
Ensuring all relevant transactions were included for accurate CLV estimation and verifying that the join captured all active customers and their transactions.

#### Handling Zero Tenure:
Customers with no tenure could skew calculations so I Added a HAVING clause to filter out customers with zero tenure.

#### Performance Optimization:
Querying performance with large datasets needed attention.

Optimizing joins and ensured indexes on key fields to enhance execution speed.
This approach effectively estimates CLV, offering valuable insights for marketing and customer retention strategies.

## These strategies helped me create a robust and efficient query.
