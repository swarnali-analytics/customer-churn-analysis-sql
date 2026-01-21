# customer-churn-analysis-sql
Customer churn and retention analysis using SQL on subscription data.
Customer Churn & Retention Analysis (SQL)

Overview
This project analyzes customer churn behavior using a subscription-based dataset to identify high-risk customer segments and derive data-driven retention strategies. The analysis focuses on defining churn risk using customer tenure and contract behavior, simulating real-world scenarios where churn labels may not always be available.

Dataset
	•	Public subscription customer dataset (7,043 customers)
	•	Each row represents a customer with demographic, contract, and billing attributes

Churn Definition
A customer is considered high-risk churn if:
	•	Tenure ≤ 6 months
	•	Contract type = Month-to-month

This custom definition was later validated against labeled churn data.

Key Analysis Performed
	•	Overall churn risk estimation
	•	Churn analysis by contract type
	•	Spend-based churn segmentation
	•	Tenure-based churn patterns
	•	Payment method churn risk
	•	Validation of custom churn logic against labeled churn outcomes

Key Findings
	•	~20% of customers are at high risk of churn
	•	Month-to-month contracts show the highest churn risk
	•	High-spend customers exhibit greater churn sensitivity
	•	Majority of churn occurs within the first 6 months
	•	Custom churn logic shows ~3× higher alignment with actual churned customers

Tools Used
	•	SQL (SQLite)
	•	SQLite Online Editor
