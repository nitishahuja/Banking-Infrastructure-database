-- Example UDF for computing a column value
CREATE FUNCTION dbo.ComputeSomeValue(@Input1 INT, @Input2 INT)
RETURNS INT
AS
BEGIN
    DECLARE @Result INT;

    -- Your computation logic here
    SET @Result = @Input1 + @Input2;

    RETURN @Result;
END;



-- Add a computed column to the Account table using the UDF
ALTER TABLE Account
ADD ComputedColumn AS dbo.ComputeSomeValue(Balance, 100);


-- Example: Update existing rows in the Account table to modify the Balance column
UPDATE Account
SET Balance = Balance + 100;


SELECT * from Account




-- UDF: Concatenate Name And Address
CREATE FUNCTION dbo.ConcatenateNameAndAddress(
    @CustomerID INT,
    @Separator VARCHAR(10) = ', '
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
    DECLARE @Result NVARCHAR(MAX);

    SELECT @Result = CONCAT(c.Name, @Separator, c.Address)
    FROM Customers c
    WHERE c.Customer_ID = @CustomerID;

    RETURN @Result;
END;
-- Example: Using the ConcatenateNameAndAddress UDF in a SELECT statement
SELECT dbo.ConcatenateNameAndAddress(202, ' - ') AS FullNameAndAddress;

