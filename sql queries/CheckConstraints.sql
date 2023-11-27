-- Table-level CHECK Constraints
-- Constraint 1: Ensure Loan Duration is between 1 and 30 years
ALTER TABLE Loan
ADD CONSTRAINT CHK_Loan_Duration
CHECK (Duration BETWEEN 1 AND 30);

-- Valid data
INSERT INTO Loan (Loan_ID, Customer_ID, Disbursed_Amount, Duration, Rate_of_Interest)
VALUES (1, 201, 50000.00, 15, 5.0);

-- Invalid data (Duration exceeds the allowed range)
INSERT INTO Loan (Loan_ID, Customer_ID, Disbursed_Amount, Duration, Rate_of_Interest)
VALUES (2, 102, 70000.00, 40, 6.5);
-- You should expect an error for this insert due to the CHECK constraint


-- Constraint 2: Ensure Transaction Amount is not negative
ALTER TABLE [Transaction]
ADD CONSTRAINT CHK_Transaction_Amount
CHECK (Amount >= 0);


-- Valid data
INSERT INTO [Transaction] (TransactionID, AccountNumber, Amount, Transaction_Date, Transaction_Type)
VALUES (15, 601, 100.00, '2023-01-01', 'Deposit');

-- Invalid data (Negative amount)
INSERT INTO [Transaction] (TransactionID, AccountNumber, Amount, Transaction_Date, Transaction_Type)
VALUES (13, 602, -50.00, '2023-01-02', 'Withdrawal');
-- You should expect an error for this insert due to the CHECK constraint


-- Constraint 3: Ensure Employee Mobile Number is valid
ALTER TABLE Employee
ADD CONSTRAINT CHK_Employee_MobileNumber
CHECK (LEN(Mobile_Number) = 12 AND Mobile_Number LIKE '555-%');


-- Valid data
INSERT INTO Employee (Employee_ID, Name, Mobile_Number, SSN, Address, Branch_Code)
VALUES (515, 'John Doe', '555-555-5555', '111-22-3333', '123 Work St', 101);

-- Invalid data (Mobile number length doesn't match the expected format)
INSERT INTO Employee (Employee_ID, Name, Mobile_Number, SSN, Address, Branch_Code)
VALUES (516, 'Jane Smith', '555-5555', '222-33-4444', '456 Work Ave', 102);
-- You should expect an error for this insert due to the CHECK constraint