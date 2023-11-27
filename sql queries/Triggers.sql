-- DML Trigger: UpdateAccountBalanceTrigger
CREATE TRIGGER UpdateAccountBalanceTrigger
ON [Transaction]
AFTER INSERT
AS
BEGIN
    UPDATE Account
    SET Balance = Balance - i.Amount
    FROM Account a
    JOIN inserted i ON a.AccountNumber = i.AccountNumber;
END;
GO

-- Assuming TransactionID is not an identity column
INSERT INTO [Transaction] (TransactionID, AccountNumber, Amount, Transaction_Date, Description, Transaction_Type)
VALUES
    (1, 603, 100.00, '2023-11-25', 'Deposit', 'Credit'),
    (2, 604, 50.00, '2023-11-25', 'Withdrawal', 'Debit');


EXEC sp_helptext 'UpdateAccountBalanceTrigger';

