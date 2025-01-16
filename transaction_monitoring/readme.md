# Transaction Monitoring and Anomaly Detection Dashboard

## Overview
This project is a **Transaction Monitoring and Anomaly Detection Dashboard** designed to identify suspicious financial activities such as round-tripping, outlier transactions, and aggregated small transactions. The project involves creating synthetic data, analyzing it using SQL, and visualizing the results in Power BI.

---

## Project Workflow

### 1. Synthetic Data Creation
- **Tools Used**: Python, Faker library, VS Code
- **Process**:
  - Created synthetic data for 4 tables: **Customers**, **Counterparties**, **Accounts**, and **Transactions**.
  - Defined real-world locations associated with customer IDs.
  - Included fields such as:
    - Primary keys: `customer_id`, `account_id`, `counterparty_id`, `transaction_id`
    - Other fields: `transaction_location`, `risk_level`, `transaction_amount`, `transaction_date`, etc.
  - Saved the tables as CSV files for further analysis.

---

### 2. Data Analysis with SQL
- **Tools Used**: SQL Server, SSMS (SQL Server Management Studio)
- **Process**:
  - Created 4 tables in SQL Server and bulk-inserted the CSV data.
  - Ran basic queries to identify:
    - Locations, customers, and counterparties with the highest transactions.
  - Detected suspicious activities using 3 methods:
    1. **Round-Tripping Transactions**: Repeated transfers of the same amount between two accounts on the same date to obscure the origin of funds.
    2. **Outlier Transactions**: Transactions exceeding three times the average transaction amount for an account.
    3. **Aggregated Small Transactions**: Multiple small transactions (below $3,000) from the same account, cumulatively exceeding $10,000 within 7 days.
  - Utilized **CTEs**, **joins**, and **self-joins** for advanced analysis.

---

### 3. Data Visualization with Power BI
- **Tools Used**: Power BI
- **Process**:
  - Loaded CSV data into Power BI and applied SQL queries to generate 3 additional tables.
  - Performed **data modeling** with most connections automatically created by Power BI.
  - Created a **two-page dashboard**:
    - **Overview Page**: General insights into transaction data.
    - **Flagged Transactions Page**: Dedicated page for suspicious activities.
  - Added interactive features:
    - **Page navigation buttons** to switch between pages.
    - **Bookmarks** to toggle visuals dynamically.
    - **Interactive dropdown filters** to filter data by `location` and `risk_level`.

---

## Key Features
- **Synthetic Data Generation**: Realistic data created using Python and Faker.
- **Advanced SQL Analysis**: Detection of round-tripping, outliers, and aggregated small transactions.
- **Interactive Power BI Dashboard**: Two-page dashboard with dynamic visuals and filters.

---

## Tools and Technologies
- **Programming Language**: Python
- **Libraries**: Faker
- **Database**: SQL Server
- **IDE**: VS Code, SSMS
- **Visualization**: Power BI
