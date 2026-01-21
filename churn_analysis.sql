-- Customer Churn & Retention Analysis

-- Base churn view
CREATE VIEW churn_base AS
SELECT
    customerID,
    tenure,
    Contract,
    MonthlyCharges,
    CAST(
        CASE 
            WHEN TotalCharges IS NULL OR TRIM(TotalCharges) = '' 
            THEN 0
            ELSE TotalCharges
        END AS REAL
    ) AS TotalCharges,
    PaymentMethod,
    InternetService,
    CASE
        WHEN tenure <= 6
         AND Contract = 'Month-to-month'
        THEN 1
        ELSE 0
    END AS is_churned_custom
FROM TelcoCustomerChurn;

-- Overall churn rate
SELECT
    COUNT(*) AS total_customers,
    ROUND(SUM(is_churned_custom) * 100.0 / COUNT(*), 2) AS churn_rate_pct
FROM churn_base;

-- Churn by contract type
SELECT
    Contract,
    COUNT(*) AS customers,
    SUM(is_churned_custom) AS churned,
    ROUND(SUM(is_churned_custom) * 100.0 / COUNT(*), 2) AS churn_rate_pct
FROM churn_base
GROUP BY Contract
ORDER BY churn_rate_pct DESC;

-- Spend-based churn analysis
SELECT
    CASE
        WHEN MonthlyCharges < 50 THEN 'Low'
        WHEN MonthlyCharges BETWEEN 50 AND 80 THEN 'Medium'
        ELSE 'High'
    END AS spend_segment,
    COUNT(*) AS customers,
    ROUND(SUM(is_churned_custom) * 100.0 / COUNT(*), 2) AS churn_rate_pct
FROM churn_base
GROUP BY spend_segment
ORDER BY churn_rate_pct DESC;

--How early are we losing customers?
SELECT
  CASE
    WHEN tenure <= 3 THEN '0–3 months'
    WHEN tenure BETWEEN 4 AND 6 THEN '4–6 months'
    WHEN tenure BETWEEN 7 AND 12 THEN '7–12 months'
    ELSE '12+ months'
  END AS tenure_bucket,
  COUNT(*) AS customers,
  ROUND(SUM(is_churned_custom) * 100.0 / COUNT(*), 2) AS churn_rate_pct
FROM churn_base
GROUP BY tenure_bucket
ORDER BY churn_rate_pct DESC;

--PAYMENT METHOD RISK
SELECT
  PaymentMethod,
  COUNT(*) AS customers,
  ROUND(SUM(is_churned_custom) * 100.0 / COUNT(*), 2) AS churn_rate_pct
FROM churn_base
GROUP BY PaymentMethod
ORDER BY churn_rate_pct DESC;

--comparison of our churn logic with the dataset’s actual Churn column
SELECT
  Churn,
  COUNT(*) AS customers,
  ROUND(AVG(is_churned_custom) * 100, 2) AS custom_churn_alignment_pct
FROM churn_base cb
JOIN TelcoCustomerChurn t
  ON cb.customerID = t.customerID
GROUP BY Churn;
