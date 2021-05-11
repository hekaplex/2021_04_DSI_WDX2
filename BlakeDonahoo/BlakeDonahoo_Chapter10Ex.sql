--Blake Donahoo
--Homework assignment May 3, 2021
--Chapter 10 Exercises

USE AP
GO

/*
1.Create a new database named Membership.
*/
CREATE DATABASE Membership;
/*
Commands completed successfully.

Completion time: 2021-05-05T20:31:36.8399198-05:00
*/
------------------------------------------------------------------------------------------------------------
/*
2.Write the CREATE TABLE statements needed to implement the following design in the Membership database. 
Include reference constraints. Define IndividualID and GroupID with the IDENTITY keyword. 
Decide which columns should allow null values, if any, and explain your decision. 
Define the Dues column with a default of zero and a check constraint to allow only positive values.
*/
CREATE TABLE Individuals
(IndividualID int NOT NULL IDENTITY PRIMARY KEY,
 FirstName varchar(50) NOT NULL,
 LastName varchar(50) NOT NULL,
 Address varchar(100) NULL,
 Phone varchar(50) NULL);

CREATE TABLE Groups
(GroupID int NOT NULL IDENTITY PRIMARY KEY,
 GroupName varchar(50) NOT NULL,
 Dues money NOT NULL DEFAULT 0 CHECK (Dues >= 0));

CREATE Table GroupMembership
(GroupID int REFERENCES Groups(GroupID),
 IndividualID int REFERENCES Individuals(IndividualID)); 
/*
Commands completed successfully.

Completion time: 2021-05-05T20:33:35.4223740-05:00
*/
------------------------------------------------------------------------------------------------------------
/*
3.Write the CREATE INDEX statements to create a clustered index on the GroupID column and a nonclustered index on the IndividualID column of the GroupMembership table.
*/
CREATE CLUSTERED INDEX IX_GroupMembership_GroupID
    ON GroupMembership(GroupID)
CREATE INDEX IX_GroupMembership_IndividualID
    ON GroupMembership(IndividualID);
/*
Commands completed successfully.

Completion time: 2021-05-05T20:34:31.3504388-05:00
*/
------------------------------------------------------------------------------------------------------------
/*
4.Write an ALTER TABLE statement that adds a new column, DuesPaid, to the Individuals table. 
Use the bit data type, disallow null values, and assign a default Boolean value of False.
*/
ALTER TABLE Individuals
ADD DuesPaid bit NOT NULL DEFAULT 0;
/*
Commands completed successfully.

Completion time: 2021-05-05T20:35:29.2009852-05:00
*/

------------------------------------------------------------------------------------------------------------
/*
5.Write an ALTER TABLE statement that adds two new check constraints to the Invoices table of the AP database. 
The first should allow (1) PaymentDate to be null only if PaymentTotal is zero and 
(2) PaymentDate to be not null only if PaymentTotal is greater than zero. 
The second constraint should prevent the sum of PaymentTotal and CreditTotal from being greater than InvoiceTotal.
*/
ALTER TABLE Invoices
ADD CHECK ((PaymentDate IS NULL AND PaymentTotal = 0) OR
           (PaymentDate IS NOT NULL AND PaymentTotal > 0)),
    CHECK ((PaymentTotal + CreditTotal) <= InvoiceTotal);
/*
Commands completed successfully.

Completion time: 2021-05-05T20:36:06.7745495-05:00
*/

------------------------------------------------------------------------------------------------------------
/*
6.Delete the GroupMembership table from the Membership database. 
Then write a CREATE TABLE statement that recreates the table, 
this time with a unique constraint that prevents an individual from being a member in the same group twice.
*/
DROP TABLE GroupMembership;

CREATE Table GroupMembership
(GroupID int REFERENCES Groups(GroupID),
 IndividualID int REFERENCES Individuals(IndividualID),
 UNIQUE(GroupID, IndividualID));
/*
Commands completed successfully.

Completion time: 2021-05-05T20:37:06.7332608-05:00
*/



