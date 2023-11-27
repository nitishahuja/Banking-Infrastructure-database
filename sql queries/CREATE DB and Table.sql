CREATE DATABASE [BANK]
GO
USE [BANK]
GO

-- Branch Table
CREATE TABLE Branch (
    Branch_Code INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Address VARCHAR(255) NOT NULL
);

-- Customers Table
CREATE TABLE Customers (
    Customer_ID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    Contact_Information VARCHAR(255),
    Date_of_Birth DATE NOT NULL,
    Social_Security_Number VARCHAR(11) NOT NULL
);

-- Policy Table
CREATE TABLE Policy (
    Policy_ID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Type VARCHAR(50) NOT NULL,
    Premium DECIMAL(10, 2) NOT NULL,
    Duration INT NOT NULL,
    Policy_Type VARCHAR(50) NOT NULL
);


-- Create a  Claims table
CREATE TABLE Claims (
    Issue_ID INT PRIMARY KEY,
    Customer_ID INT,
    Policy_Type VARCHAR(50) NOT NULL,
    Description TEXT NOT NULL,
    Claim_Amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);


-- Locker Table
CREATE TABLE Locker (
    LockerID INT PRIMARY KEY,
    Size VARCHAR(50) NOT NULL,
    Status VARCHAR(50) NOT NULL
);

-- Employee Table
CREATE TABLE Employee (
    Employee_ID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Mobile_Number VARCHAR(20) NOT NULL,
    SSN VARCHAR(11) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    Branch_Code INT NOT NULL,
    FOREIGN KEY (Branch_Code) REFERENCES Branch(Branch_Code)
);

-- Account Table
CREATE TABLE Account (
    AccountNumber INT PRIMARY KEY,
    Customer_ID INT NOT NULL,
    Branch_Code INT NOT NULL,
    Balance DECIMAL(10, 2) NOT NULL,
    Date_of_Account_Creation DATE NOT NULL,
    Account_Status VARCHAR(50) NOT NULL,
    Account_Type VARCHAR(50) NOT NULL,
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
    FOREIGN KEY (Branch_Code) REFERENCES Branch(Branch_Code)
);

-- Transaction Table
CREATE TABLE [Transaction] (
    TransactionID INT PRIMARY KEY,
    AccountNumber INT NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    Transaction_Date DATE NOT NULL,
    Description TEXT,
    Transaction_Type VARCHAR(50) NOT NULL,
    FOREIGN KEY (AccountNumber) REFERENCES Account(AccountNumber)
);

-- Loan Table
CREATE TABLE Loan (
    Loan_ID INT PRIMARY KEY,
    Customer_ID INT NOT NULL,
    Disbursed_Amount DECIMAL(10, 2) NOT NULL,
    Duration INT NOT NULL,
    Rate_of_Interest DECIMAL(5, 2) NOT NULL,
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);

-- Loan Application Table
CREATE TABLE Loan_Application (
    Customer_ID INT NOT NULL,
    Loan_ID INT NOT NULL,
    Loan_Type VARCHAR(50) NOT NULL,
    Status VARCHAR(50) NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (Customer_ID, Loan_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
    FOREIGN KEY (Loan_ID) REFERENCES Loan(Loan_ID)
);

-- Customer Policy Table
CREATE TABLE Customer_Policy (
    Customer_ID INT NOT NULL,
    Policy_ID INT NOT NULL,
    Commencement_Date DATE NOT NULL,
    Expiration_Date DATE NOT NULL,
    Coverage_Type VARCHAR(255) NOT NULL,
    PRIMARY KEY (Customer_ID, Policy_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
    FOREIGN KEY (Policy_ID) REFERENCES Policy(Policy_ID)
);

-- Complaint Table
CREATE TABLE Complaint (
    Complaint_ID INT PRIMARY KEY,
    Employee_ID INT NOT NULL,
    Customer_ID INT NOT NULL,
    Details TEXT NOT NULL,
    Status VARCHAR(50) NOT NULL,
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);



-- Access Log Table
CREATE TABLE Access_Log (
    Customer_ID INT NOT NULL,
    LockerID INT NOT NULL,
    Access_Time DATETIME DEFAULT CURRENT_TIMESTAMP,
    Access_Type VARCHAR(50) NOT NULL,
    PRIMARY KEY (Customer_ID, LockerID), -- Corrected the primary key definition
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
    FOREIGN KEY (LockerID) REFERENCES Locker(LockerID) -- Corrected the foreign key reference
);



-- Customers Employee Relationship Table
CREATE TABLE Customers_Employee (
    Customer_ID INT NOT NULL,
    Employee_ID INT NOT NULL,
    Start_Date DATE NOT NULL,
    End_Date DATE,
    Location VARCHAR(255) NOT NULL,
    PRIMARY KEY (Customer_ID, Employee_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID)
);


-- Add Username and Password columns to the Customers table
ALTER TABLE Customers
ADD Username VARCHAR(50),
    Password VARBINARY(MAX);

-- Add Username and Password columns to the Employee table
ALTER TABLE Employee
ADD Username VARCHAR(50),
    Password VARBINARY(MAX);
