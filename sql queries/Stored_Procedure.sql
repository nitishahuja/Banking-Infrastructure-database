-- Stored Procedure 1: GetCustomerInfo
CREATE PROCEDURE GetCustomerInfo
    @CustomerID INT,
    @CustomerName VARCHAR(255) OUTPUT,
    @CustomerAddress VARCHAR(255) OUTPUT,
    @TotalBalance DECIMAL(10, 2) OUTPUT
AS
BEGIN
    SELECT @CustomerName = Name, @CustomerAddress = Address
    FROM Customers
    WHERE Customer_ID = @CustomerID;

    SELECT @TotalBalance = SUM(Balance)
    FROM Account
    WHERE Customer_ID = @CustomerID;
END;
GO

DECLARE @CustName VARCHAR(255), @CustAddress VARCHAR(255), @CustBalance DECIMAL(10, 2), @CustID INT;

SET @CustID = 201; -- Replace with the desired customer ID

EXEC GetCustomerInfo @CustomerID = @CustID, 
                     @CustomerName = @CustName OUTPUT, 
                     @CustomerAddress = @CustAddress OUTPUT, 
                     @TotalBalance = @CustBalance OUTPUT;

-- Display the results
PRINT 'Customer Name: ' + ISNULL(@CustName, 'N/A');
PRINT 'Customer Address: ' + ISNULL(@CustAddress, 'N/A');
PRINT 'Total Balance: ' + ISNULL(CONVERT(VARCHAR(20), @CustBalance), 'N/A');


-- Stored Procedure 2: GetLoanStatus
CREATE PROCEDURE GetLoanStatus
    @LoanID INT,
    @LoanStatus VARCHAR(50) OUTPUT,
    @RemainingAmount DECIMAL(10, 2) OUTPUT
AS
BEGIN
    SELECT @LoanStatus = Status
    FROM Loan_Application
    WHERE Loan_ID = @LoanID;

    SELECT @RemainingAmount = l.Disbursed_Amount - ISNULL((SELECT SUM(Amount) FROM Loan_Application WHERE Loan_ID = @LoanID), 0)
    FROM Loan l
    WHERE l.Loan_ID = @LoanID;
END;
GO


DECLARE @LoanID INT, @LoanStat VARCHAR(50), @RemainingAmt DECIMAL(10, 2);

SET @LoanID = 701; -- Replace with the desired loan ID

EXEC GetLoanStatus @LoanID = @LoanID, 
                   @LoanStatus = @LoanStat OUTPUT, 
                   @RemainingAmount = @RemainingAmt OUTPUT;

-- Display the results
PRINT 'Loan ID: ' + ISNULL(CONVERT(VARCHAR(10), @LoanID), 'N/A');
PRINT 'Loan Status: ' + ISNULL(@LoanStat, 'N/A');
PRINT 'Remaining Amount: ' + ISNULL(CONVERT(VARCHAR(20), @RemainingAmt), 'N/A');



-- Stored Procedure 3: GetEmployeeDetails
CREATE PROCEDURE GetEmployeeDetails
    @EmployeeID INT,
    @EmployeeName VARCHAR(255) OUTPUT,
    @EmployeeAddress VARCHAR(255) OUTPUT,
    @EmployeeBranch VARCHAR(255) OUTPUT
AS
BEGIN
    SELECT @EmployeeName = e.Name, @EmployeeAddress = e.Address, @EmployeeBranch = b.Name
    FROM Employee e
    INNER JOIN Branch b ON e.Branch_Code = b.Branch_Code
    WHERE e.Employee_ID = @EmployeeID;
END;
GO


DECLARE @EmployeeID INT, @EmpName VARCHAR(255), @EmpAddress VARCHAR(255), @EmpBranch VARCHAR(255);

SET @EmployeeID = 501; -- Replace with the desired employee ID

EXEC GetEmployeeDetails @EmployeeID = @EmployeeID, 
                        @EmployeeName = @EmpName OUTPUT, 
                        @EmployeeAddress = @EmpAddress OUTPUT, 
                        @EmployeeBranch = @EmpBranch OUTPUT;

-- Display the results
PRINT 'Employee ID: ' + ISNULL(CONVERT(VARCHAR(10), @EmployeeID), 'N/A');
PRINT 'Employee Name: ' + ISNULL(@EmpName, 'N/A');
PRINT 'Employee Address: ' + ISNULL(@EmpAddress, 'N/A');
PRINT 'Employee Branch: ' + ISNULL(@EmpBranch, 'N/A');


