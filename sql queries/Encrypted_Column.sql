
-- Update Customers table with encrypted passwords
UPDATE Customers
SET Password = HASHBYTES('SHA2_256', 'YourPasswordHere')
WHERE Password IS NULL;

-- Update Employee table with encrypted passwords
UPDATE Employee
SET Password = HASHBYTES('SHA2_256', 'YourPasswordHere')
WHERE Password IS NULL;


-- Example of checking a password during authentication
DECLARE @EnteredPassword VARBINARY(MAX);
SET @EnteredPassword = HASHBYTES('SHA2_256', 'EnteredPasswordHere');

IF EXISTS (SELECT 1 FROM Customers WHERE Username = 'EnteredUsername' AND Password = @EnteredPassword)
BEGIN
    -- Password is correct
    PRINT 'Login successful';
END
ELSE
BEGIN
    -- Password is incorrect
    PRINT 'Invalid login';
END;



-- Update Customers table with random usernames and encrypted passwords
UPDATE Customers
SET Username = 'Customer' + CAST(ABS(CHECKSUM(NEWID())) AS VARCHAR(10)),
    Password = HASHBYTES('SHA2_256', CAST(ABS(CHECKSUM(NEWID())) AS VARBINARY(8000)))
WHERE Username IS NULL;

-- Update Employee table with random usernames and encrypted passwords
UPDATE Employee
SET Username = 'Employee' + CAST(ABS(CHECKSUM(NEWID())) AS VARCHAR(10)),
    Password = HASHBYTES('SHA2_256', CAST(ABS(CHECKSUM(NEWID())) AS VARBINARY(8000)))
WHERE Username IS NULL;
