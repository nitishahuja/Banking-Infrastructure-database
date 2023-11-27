-- View 1: ActiveAccountsView
CREATE VIEW ActiveAccountsView AS
SELECT AccountNumber, Customer_ID, Branch_Code, Balance
FROM Account
WHERE Account_Status = 'Active';
GO

-- View 2: HighValueCustomersView
CREATE VIEW HighValueCustomersView AS
SELECT c.Customer_ID, c.Name, a.Balance
FROM Customers c
JOIN Account a ON c.Customer_ID = a.Customer_ID
WHERE a.Balance > 10000;
GO

-- View 3: PolicySummaryView
CREATE VIEW PolicySummaryView AS
SELECT cp.Customer_ID, cp.Policy_ID, p.Name AS PolicyName, p.Type AS PolicyType
FROM Customer_Policy cp
JOIN Policy p ON cp.Policy_ID = p.Policy_ID;
GO

-- Check View 1: ActiveAccountsView
SELECT * FROM ActiveAccountsView;

-- Check View 2: HighValueCustomersView
SELECT * FROM HighValueCustomersView;

-- Check View 3: PolicySummaryView
SELECT * FROM PolicySummaryView;
