 -- Example Non-Clustered Index on the Account table
CREATE NONCLUSTERED INDEX IX_Account_CustomerID
ON Account (Customer_ID);



-- Example Non-Clustered Index on the Loan_Application table
CREATE NONCLUSTERED INDEX IX_Loan_Application_LoanID
ON Loan_Application (Loan_ID);



-- Example Non-Clustered Index on the Transaction table
CREATE NONCLUSTERED INDEX IX_Transaction_AccountNumber
ON [Transaction] (AccountNumber);

