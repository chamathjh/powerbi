USE FraudDetection;

-- Creating Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,	
    Name NVARCHAR(100),
    Location NVARCHAR(100),
    RiskScore NVARCHAR(10)
);

-- Creating Accounts table
CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY,
    CustomerID INT,
    AccountType NVARCHAR(20),
    OpeningDate DATE,
    Balance DECIMAL(18, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Creating Counterparties table
CREATE TABLE Counterparties (
    CounterpartyID INT PRIMARY KEY,
    Name NVARCHAR(100),
    Location NVARCHAR(100),
    RiskScore NVARCHAR(10)
);

-- Creating Transactions table
CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY,
    AccountID INT,
    Date DATE,
    Amount DECIMAL(18, 2),
    Type NVARCHAR(20),
    Location NVARCHAR(100),
    CounterpartyID INT,
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID),
    FOREIGN KEY (CounterpartyID) REFERENCES Counterparties(CounterpartyID)
);


-- Load using bulk insert
BULK INSERT Customers
FROM 'C:\Users\Chamath\Downloads\Projects\Fraud detection\customers.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,  -- Skip header row
    CODEPAGE = '65001'  -- UTF-8 encoding
);

BULK INSERT Accounts
FROM 'C:\Users\Chamath\Downloads\Projects\Fraud detection\accounts.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,  -- Skip header row
    CODEPAGE = '65001'  -- UTF-8 encoding
);


BULK INSERT Counterparties
FROM 'C:\Users\Chamath\Downloads\Projects\Fraud detection\counterparties.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,  
    CODEPAGE = '65001',  
    FORMAT = 'CSV', 
    FIELDQUOTE = '"' -- need to handle quotes placed around names (since some names contain special characters)
);


BULK INSERT Transactions
FROM 'C:\Users\Chamath\Downloads\Projects\Fraud detection\transactions.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,  -- Skip header row
    CODEPAGE = '65001'  -- UTF-8 encoding
);

/*
SELECT * FROM Transactions
WHERE AccountID=4
ORDER BY Date ASC;

SELECT * FROM Accounts
WHERE AccountID=4;

SELECT COUNT(DISTINCT Location) FROM Transactions
*/


--------------------------------------------------------------------------
-- Analysis using SQL

-- counting the number of rows

SELECT 'Customers' AS Table_Name, COUNT(*) AS Row_count FROM Customers
UNION ALL
SELECT 'Accounts', COUNT(*) FROM Accounts
UNION ALL
SELECT 'Counterparties', COUNT(*) FROM Counterparties
UNION ALL
SELECT 'Transactions', COUNT(*) FROM Transactions

--viewing sample data (top 10)

SELECT TOP 10 * FROM Customers;
SELECT TOP 10 * FROM Accounts;
SELECT TOP 10 * FROM Counterparties;
SELECT TOP 10 * FROM Transactions;

-- summary of transactions

SELECT 
	MIN(Amount) AS min_amount,
	MAX(Amount) AS max_amount,
	AVG(Amount) AS average_amount,
	SUM(Amount) AS total_transaction_value
FROM Transactions;

------------------------------------------------------------------
-- accounts with multiple small transactions (just below $3,000) within a short period (7 days)
-- threshold defined as $10,000

SELECT
	AccountID,
	SUM(Amount) AS Total_amount,
	MIN(Date) AS First_date,
	MAX(Date) AS Last_date,
	COUNT(TransactionID) AS Number_of_transactions
FROM Transactions
WHERE Amount<3000
GROUP BY AccountID
HAVING 
	COUNT(TransactionID)>3
	AND SUM(Amount)>= 10000
	AND DATEDIFF(DAY, MIN(Date), MAX(Date)) <= 7

---------------------------------------------------------------
-- detect accounts involved in round-tripping (funds moving back and forth between two accounts).
-- CTE 

WITH RoundTripping AS (SELECT 
	t1.AccountID AS Account_1,
	t2.AccountID AS Account_2,
	t1.Date,
	t1.Amount
	FROM Transactions t1
	JOIN Transactions t2
	ON t1.AccountID = t2.CounterpartyID
	AND t2.AccountID = t1.CounterpartyID
	AND t1.Date = t2.Date
	AND t1.Amount = t2.Amount)

SELECT
	Account_1,
	Account_2,
	SUM(Amount) AS Total_amount,
	COUNT(*) AS Number_of_transactions
FROM RoundTripping
GROUP BY Account_1, Account_2
HAVING Count(*)>2
ORDER BY Total_amount DESC

-------------------------------------------------------
-- Detecting unusually large transactions from accounts (more than thrice the average transaction amount)

WITH CustomerBehavior AS (
    SELECT 
        c.CustomerID,
        AVG(t.Amount) AS AvgTransactionAmount,
        MAX(t.Amount) AS MaxTransactionAmount
    FROM 
        Customers c
    JOIN 
        Accounts a ON c.CustomerID = a.CustomerID
    JOIN 
        Transactions t ON a.AccountID = t.AccountID
    GROUP BY 
        c.CustomerID
)
SELECT 
    t.TransactionID,
    t.AccountID,
    t.Amount,
    t.Date,
    t.Location,
    c.CustomerID,
    cb.AvgTransactionAmount,
    cb.MaxTransactionAmount
FROM 
    Transactions t
JOIN 
    Accounts a ON t.AccountID = a.AccountID
JOIN 
    Customers c ON a.CustomerID = c.CustomerID
JOIN 
    CustomerBehavior cb ON c.CustomerID = cb.CustomerID
WHERE 
    t.Amount > 3 * cb.AvgTransactionAmount  -- Large transaction
ORDER BY 
    t.Amount DESC;

-----------------------------------------------------------
-- find the locations with the most number of transactions

SELECT 
	Location,
	COUNT(*) AS Number_of_transactions,
	SUM(Amount) AS Total_amount,
	AVG(Amount) AS Average_amount
FROM Transactions
GROUP BY Location
ORDER BY Number_of_transactions DESC

---------------------------------------------------------------
-- total transaction amount by customer

SELECT
	c.CustomerID,
	c.RiskScore,
	SUM(t.Amount) AS total_amount,
	COUNT(*) AS number_of_transaction
FROM Customers c
JOIN Accounts a
ON c.CustomerID = a.CustomerID
JOIN Transactions t
ON t.AccountID = a.AccountID
GROUP BY c.CustomerID, c.RiskScore

---------------------------------------------------------------
-- total transaction amount by counterparty

SELECT
	c.CounterpartyID,
	c.RiskScore,
	SUM(t.Amount) AS total_amount,
	COUNT(*) AS number_of_transaction
FROM Counterparties c
JOIN Transactions t
ON t.CounterpartyID = c.CounterpartyID
GROUP BY c.CounterpartyID, c.RiskScore
