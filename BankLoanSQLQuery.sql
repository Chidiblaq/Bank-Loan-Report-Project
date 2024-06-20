select * from Bank_loan_data

-- KEY PERFORMANCE INDICATORS
-- Total Loan Applications
SELECT COUNT(id) AS Total_Loan_Applications FROM Bank_loan_data

-- Month To Date(MTD) Loan Applications
SELECT COUNT(id) AS MTD_Total_Loan_Applications FROM Bank_loan_data
WHERE MONTH(issue_date) = 12

-- Previous Month To Date Loan Applications
SELECT COUNT(id) AS PMTD_Total_Loan_Applications FROM Bank_loan_data
WHERE MONTH(issue_date) = 11

-- Total Funded Loan Amount
SELECT SUM(loan_amount) AS Total_Funded_Loan_Amount FROM bank_loan_data

-- MTD Total Funded Loan Amount
SELECT SUM(loan_amount) AS MTD_Total_Funded_Loan_Amount FROM bank_loan_data
WHERE MONTH(issue_date) = 12

-- Previous MTD Total Funded Loan Amount
SELECT SUM(loan_amount) AS PMTD_Total_Funded_Loan_Amount FROM bank_loan_data
WHERE MONTH(issue_date) = 11

-- Total Loan Amount Received
SELECT SUM(total_payment) AS Total_Loan_Amount_Collected FROM bank_loan_data

-- MTD Total Loan Amount Received
SELECT SUM(total_payment) AS MTD_Total_Amount_Collected FROM bank_loan_data
WHERE MONTH(issue_date) = 12

-- Previous MTD Total Loan Amount Received
SELECT SUM(total_payment) AS PMTD_Total_Amount_Collected FROM bank_loan_data
WHERE MONTH(issue_date) = 11

-- Average Interest Rate
SELECT ROUND(AVG(int_rate)*100, 2) AS Avg_Int_Rate FROM bank_loan_data

-- MTD Average Interest
SELECT ROUND(AVG(int_rate)*100, 2) AS MTD_Avg_Int_Rate FROM bank_loan_data
WHERE MONTH(issue_date) = 12

-- Previous MTD Average Interest
SELECT ROUND(AVG(int_rate)*100, 2) AS PMTD_Avg_Int_Rate FROM bank_loan_data
WHERE MONTH(issue_date) = 11

-- Average Debt To Income(DTI)
SELECT ROUND(AVG(dti)*100, 2) AS Avg_DTI FROM bank_loan_data

-- MTD Average Debt To Income(DTI)
SELECT ROUND(AVG(dti)*100, 2) AS MTD_Avg_DTI FROM bank_loan_data
WHERE MONTH(issue_date) = 12

-- Previous MTD Average Debt To Income(DTI)
SELECT ROUND(AVG(dti)*100, 2) AS PMTD_Avg_DTI FROM bank_loan_data
WHERE MONTH(issue_date) = 11


-- GOOD LOAN ISSUED
-- Good Loan Percentage
SELECT CAST(
           (SUM(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) 
           AS DECIMAL(10,2)) AS Good_Loan_Percentage
FROM (
    SELECT id, loan_status
    FROM bank_loan_data
) AS subquery

-- Good Loan Applications
WITH filtered_loans AS (
    SELECT id
    FROM bank_loan_data
    WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'
)
SELECT COUNT(id) AS Good_Loan_Applications
FROM filtered_loans

-- Good Loan Funded Amount
WITH total_filtered_loans AS (
    SELECT loan_amount
    FROM bank_loan_data
    WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'
)
SELECT SUM(loan_amount) AS Good_Loan_Funded_amount
FROM total_filtered_loans

-- Good Loan Amount Received
WITH total_filtered_payment AS (
    SELECT total_payment
    FROM bank_loan_data
    WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'
)
SELECT SUM(total_payment) AS Good_Loan_amount_received
FROM total_filtered_payment


--BAD LOAN ISSUED
--Bad Loan Percentage
SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
	COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan_data

SELECT CAST(
           (SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) 
           AS DECIMAL(10,2)) AS Good_Loan_Percentage
FROM (
    SELECT id, loan_status
    FROM bank_loan_data
) AS subquery

-- Bad Loan Applications
WITH filtered_loans AS (
    SELECT id
    FROM bank_loan_data
    WHERE loan_status = 'Charged Off'
)
SELECT COUNT(id) AS Good_Loan_Applications
FROM filtered_loans

-- Bad Loan Funded Amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded_amount FROM bank_loan_data
WHERE loan_status = 'Charged Off'

WITH total_filtered_loans AS (
    SELECT loan_amount
    FROM bank_loan_data
    WHERE loan_status = 'Charged Off'
)
SELECT SUM(loan_amount) AS Good_Loan_Funded_amount
FROM total_filtered_loans

-- Bad Loan Amount Received
WITH total_filtered_payment AS (
    SELECT total_payment
    FROM bank_loan_data
    WHERE loan_status = 'Charged Off'
)
SELECT SUM(total_payment) AS Good_Loan_amount_received
FROM total_filtered_payment;


-- LOAN STATUS
WITH aggregated_data AS (
    SELECT
        loan_status,
        COUNT(id) AS LoanCount,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate * 100.0) AS Interest_Rate,
        AVG(dti * 100.0) AS DTI
    FROM
        bank_loan_data
    GROUP BY
        loan_status
)
SELECT
    loan_status,
    LoanCount,
    Total_Amount_Received,
    Total_Funded_Amount,
    ROUND(Interest_Rate, 2) AS Interest_Rate,
    ROUND(DTI, 2) AS DTI
FROM
    aggregated_data;

-- Month To Date (MTD) Summary
WITH aggregated_mtd_data AS (
    SELECT
        loan_status,
        SUM(total_payment) AS MTD_Total_Amount_Received,
        SUM(loan_amount) AS MTD_Total_Funded_Amount
    FROM bank_loan_data
	WHERE MONTH(issue_date) = 12 
    GROUP BY
        loan_status
)
SELECT
    loan_status,
    MTD_Total_Amount_Received,
    MTD_Total_Funded_Amount
    
FROM
    aggregated_mtd_data;



-- Loan Report Overview
-- MONTH
WITH aggregated_data AS (
    SELECT 
        MONTH(issue_date) AS Month_Number, 
        DATENAME(MONTH, issue_date) AS Month_Name, 
        COUNT(id) AS Total_Loan_Applications,
        SUM(loan_amount) AS Total_Funded_Amount,
        SUM(total_payment) AS Total_Amount_Received
    FROM bank_loan_data
    GROUP BY 
        MONTH(issue_date), DATENAME(MONTH, issue_date)
)
SELECT 
    Month_Number,
    Month_Name,
    Total_Loan_Applications,
    Total_Funded_Amount,
    Total_Amount_Received
FROM 
    aggregated_data
ORDER BY 
    Month_Number;


-- STATE
WITH aggregated_data AS (
    SELECT 
        address_state AS State, 
        COUNT(id) AS Total_Loan_Applications,
        SUM(loan_amount) AS Total_Funded_Amount,
        SUM(total_payment) AS Total_Amount_Received
    FROM bank_loan_data
    GROUP BY 
        address_state
)
SELECT 
    State,
    Total_Loan_Applications,
    Total_Funded_Amount,
    Total_Amount_Received
FROM 
    aggregated_data
ORDER BY 
    Total_Loan_Applications DESC


-- TERM
WITH aggregated_data AS (
    SELECT 
        term AS Term, 
        COUNT(id) AS Total_Loan_Applications,
        SUM(loan_amount) AS Total_Funded_Amount,
        SUM(total_payment) AS Total_Amount_Received
    FROM bank_loan_data
    GROUP BY 
        term
)
SELECT 
    Term,
    Total_Loan_Applications,
    Total_Funded_Amount,
    Total_Amount_Received
FROM 
    aggregated_data
ORDER BY 
    Term;


-- EMPLOYEE LENGTH
WITH aggregated_data AS (
    SELECT 
        emp_length AS Employee_Length, 
        COUNT(id) AS Total_Loan_Applications,
        SUM(loan_amount) AS Total_Funded_Amount,
        SUM(total_payment) AS Total_Amount_Received
    FROM bank_loan_data
    GROUP BY 
        emp_length
)
SELECT 
    Employee_Length,
    Total_Loan_Applications,
    Total_Funded_Amount,
    Total_Amount_Received
FROM 
    aggregated_data
ORDER BY 
    Total_Loan_Applications DESC;


-- Purpose
WITH aggregated_data AS (
    SELECT 
        purpose AS Purpose, 
        COUNT(id) AS Total_Loan_Applications,
        SUM(loan_amount) AS Total_Funded_Amount,
        SUM(total_payment) AS Total_Amount_Received
    FROM bank_loan_data
    GROUP BY 
        purpose
)
SELECT 
    Purpose,
    Total_Loan_Applications,
    Total_Funded_Amount,
    Total_Amount_Received
FROM 
    aggregated_data
ORDER BY 
    Total_Loan_Applications DESC;

-- Home Ownership
WITH aggregated_data AS (
    SELECT 
        home_ownership AS Home_ownership, 
        COUNT(id) AS Total_Loan_Applications,
        SUM(loan_amount) AS Total_Funded_Amount,
        SUM(total_payment) AS Total_Amount_Received
    FROM bank_loan_data
    GROUP BY 
        home_ownership
)
SELECT 
    Home_ownership,
    Total_Loan_Applications,
    Total_Funded_Amount,
    Total_Amount_Received
FROM 
    aggregated_data
ORDER BY 
    Total_Loan_Applications DESC;

