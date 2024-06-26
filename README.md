# Bank Loan Report Dashboard
Welcome to the Bank Loan Report Dashboard project! This repository contains the code and documentation for a comprehensive and user-friendly interface designed to access vital loan data. The dashboard serves as a one-stop solution for users seeking detailed insights into the loan portfolio, borrower profiles, and loan performance.  
This is the link to interact and navigate the [dashboard](https://app.powerbi.com/view?r=eyJrIjoiMGZjOGJmZmYtMzYwMC00MDhhLWJjODYtZDY3YTZjMGU2ODM4IiwidCI6ImQwZWYwYjU4LWQ0YTItNGJjZS1iMDFiLTQxZWQ0ZGMyZjU3ZSJ9)

### Table of Contents  
- Overview  
- Business Case  
- Problem Statement  
- Data Processing and Transformation  
- Key Performance Indicators (KPIs)  
- Technologies Used  
- Installation  
- Usage  
- Contributing  

### Overview  
The Bank Loan Report Dashboard leverages a financial dataset from a bank's loan data to provide comprehensive insights and analysis. The primary objective of the dashboard is to offer a user-friendly interface that facilitates access to critical loan data, helping users understand the overall health and performance of the loan portfolio.

### Business Case  
In today's competitive financial environment, banks need to maintain a clear understanding of their loan portfolios. This project aims to support the bank's strategic decision-making process by providing detailed insights into loan applications, funded amounts, repayment, interest rates, and borrower profiles. The dashboard helps stakeholders make informed decisions by presenting data in an accessible and actionable format.

### Problem Statement  
Banks often struggle with effectively managing and analyzing their loan portfolios due to the vast amounts of data involved. This project addresses the following challenges:

- Aggregating and visualizing loan data in an intuitive manner.  
- Monitoring key performance metrics such as loan applications, funded amounts, and repayment trends.  
- Assessing borrower profiles and financial health.  
- Identifying trends and anomalies in loan performance.

### Data Processing and Transformation.  
The data for this project went through several stages of processing and transformation:  
- Data Preview: Initially, the data was previewed in Excel to understand its structure and quality.
- CSV Export: The data was then exported as a CSV file.
- SQL Server Import: The CSV file was imported into Microsoft SQL Server for further processing.
- Data Querying: SQL Server was used to query the data using advanced queries like Common Table Expressions (CTEs) and subqueries to structure the data efficiently.
- Power BI Import: The processed data was imported into Power BI using Direct Query for real-time updates.
- Power Query Transformation: Additional transformations were performed using Power Query before creating the final reports.

  
### Key Performance Indicators (KPIs)  
The following KPIs are essential for monitoring and analyzing the bank's loan portfolio:  

Total Loan Applications:  
- Calculate the total number of loan applications received during a specified period.  
- Monitor Month-to-Date (MTD) Loan Applications.  
- Track changes Month-over-Month (MoM).  

Total Funded Amount:  
- Understand the total amount of funds disbursed as loans.  
- Monitor MTD Total Funded Amount.  
- Analyse MoM changes in this metric.
  
Total Amount Received:  
- Track the total amount received from borrowers.  
- Assess the bank's cash flow and loan repayment.  
- Analyse MTD Total Amount Received and observe MoM changes.
  
Average Interest Rate:  
- Calculate the average interest rate across all loans.  
- Monitor MTD Average Interest Rate.  
- Track MoM variations in interest rates to understand the overall cost of lending.  

Average Debt-to-Income Ratio (DTI):  
- Evaluate the average DTI for borrowers to gauge their financial health.  
- Compute the average DTI for all loans and MTD.  
- Track MoM fluctuations.
  
Good Loan vs Bad Loan KPIs:  
- Assess the quality of loans by categorizing them into good loans and bad loans based on predefined criteria.


### Technologies Used:  
- Microsoft Excel: For initial data preview and CSV export.  
- Microsoft SQL Server: For querying and managing the financial dataset.  
- Power BI: For data visualization and dashboard creation.  
- Power Query: For data transformation and preparation.  

### Installation  
To set up the project locally, follow these steps:  
1. Clone the repository:
git clone https://github.com/Chidiblaq/Bank-Loan-Report-Project.git

2. Open the project in your preferred SQL Server and Power BI environment.

3. Configure the data source connection in Power BI to point to your SQL Server database.

### Usage  
Open the Power BI file included in the repository.  
Refresh the data to ensure the latest information is loaded.  
Navigate through the dashboard to explore various reports and insights on the loan portfolio.  

### Contributing  
I welcome contributions to enhance the functionality and usability of the dashboard. To contribute, please follow these steps:  
- Fork the repository.  
- Create a new branch for your feature or bug fix.  
- Commit your changes and push them to your fork.  
- Submit a pull request with a detailed description of your changes.  

Included in this repository is the Dashboard Report, the SQL query file and the dataset.  

I hope you find the Bank Loan Report Dashboard useful for your data analysis needs. For any questions or feedback, please open an issue in the repository. Happy analyzing!
