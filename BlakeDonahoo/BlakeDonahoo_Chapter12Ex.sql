--Blake Donahoo
--Homework assignment May 5, 2021
--Chapter 12 Exercises

/*
1.Write a script that declares and sets a variable that’s equal to the total outstanding balance due. 
If that balance due is greater than $10,000.00, the script should return a result set consisting of 
VendorName, InvoiceNumber, InvoiceDueDate, and Balance for each invoice with a balance due, sorted with the oldest due date first. 
If the total outstanding balance due is less than $10,000.00, return the message “Balance due is less than $10,000.00.”
*/
DECLARE @TotalInvoiceDue money;

SELECT @TotalInvoiceDue = 
       SUM(InvoiceTotal - CreditTotal - PaymentTotal)
FROM Invoices
WHERE InvoiceTotal - CreditTotal - PaymentTotal > 0;

IF @TotalInvoiceDue > 10000
    SELECT VendorName, InvoiceNumber, InvoiceDueDate,
           InvoiceTotal - CreditTotal - PaymentTotal AS Balance
    FROM Invoices JOIN Vendors
      ON Invoices.VendorID = Vendors.VendorID
    WHERE InvoiceTotal - CreditTotal - PaymentTotal > 0
    ORDER BY InvoiceDueDate;
ELSE
  PRINT 'Balance due is less than $10,000.00.';
/*
VendorName                                         InvoiceNumber                                      InvoiceDueDate          Balance
-------------------------------------------------- -------------------------------------------------- ----------------------- ---------------------
Data Reproductions Corp                            39104                                              2016-04-09 00:00:00     85.31
Ingram                                             31361833                                           2016-04-10 00:00:00     579.42
Federal Express Corporation                        963253264                                          2016-04-17 00:00:00     52.25
Cardinal Business Media, Inc.                      134116                                             2016-04-17 00:00:00     90.36
Federal Express Corporation                        263253268                                          2016-04-20 00:00:00     59.97
Federal Express Corporation                        263253270                                          2016-04-21 00:00:00     67.92
Federal Express Corporation                        263253273                                          2016-04-21 00:00:00     30.75
Malloy Lithographing Inc                           P-0608                                             2016-04-22 00:00:00     19351.18
Ford Motor Credit Company                          9982771                                            2016-04-23 00:00:00     503.20
Malloy Lithographing Inc                           0-2436                                             2016-04-30 00:00:00     10976.06
Blue Cross                                         547480102                                          2016-04-30 00:00:00     224.00

(11 rows affected)


Completion time: 2021-05-05T20:54:27.7000405-05:00
*/
---------------------------------------------------------------------------------------------------------------------------------
/*
2.The following script uses a derived table to return the date and invoice total of the earliest invoice issued by each vendor. 
Write a script that generates the same result set but uses a temporary table in place of the derived table. 
Make sure your script tests for the existence of any objects it creates.

USE AP

SELECT VendorName, FirstInvoiceDate, InvoiceTotal FROM Invoices JOIN
(SELECT VendorID, MIN(InvoiceDate) AS FirstInvoiceDate FROM Invoices
GROUP BY VendorID) AS FirstInvoice
ON (Invoices.VendorID = FirstInvoice.VendorID AND Invoices.InvoiceDate = FirstInvoice.FirstInvoiceDate)
JOIN Vendors
ON Invoices.VendorID = Vendors.VendorID
ORDER BY VendorName, FirstInvoiceDate
*/
IF OBJECT_ID('tempdb..#FirstInvoice') IS NOT NULL
    DROP TABLE #FirstInvoice;

SELECT VendorID, MIN(InvoiceDate) AS FirstInvoiceDate
INTO #FirstInvoice
FROM Invoices
GROUP BY VendorID;

SELECT VendorName, FirstInvoiceDate, InvoiceTotal
FROM Invoices JOIN #FirstInvoice
  ON (Invoices.VendorID = #FirstInvoice.VendorID AND
      Invoices.InvoiceDate = #FirstInvoice.FirstInvoiceDate)
JOIN Vendors
  ON Invoices.VendorID = Vendors.VendorID
ORDER BY VendorName, FirstInvoiceDate;
/*
(34 rows affected)
VendorName                                         FirstInvoiceDate        InvoiceTotal
-------------------------------------------------- ----------------------- ---------------------
Abbey Office Furnishings                           2016-03-05 00:00:00     17.50
Bertelsmann Industry Svcs. Inc                     2016-02-18 00:00:00     6940.25
Blue Cross                                         2016-02-03 00:00:00     224.00
Cahners Publishing Company                         2016-02-28 00:00:00     2184.50
Cardinal Business Media, Inc.                      2016-02-22 00:00:00     175.00
Coffee Break Service                               2016-02-24 00:00:00     41.80
Compuserve                                         2016-01-03 00:00:00     9.95
Computerworld                                      2016-02-11 00:00:00     2433.00
*/
---------------------------------------------------------------------------------------------------------------------------------
/*
3.Write a script that generates the same result set as the code shown in example 2, but uses a view instead of a derived table. 
Also write the script that creates the view. Make sure that your script tests for the existence of the view. 
The view doesn’t need to be redefined each time the script is executed.
*/
IF OBJECT_ID('FirstInvoice_V') IS NOT NULL
    DROP VIEW FirstInvoice_V;
GO

CREATE VIEW FirstInvoice_V
AS
SELECT VendorID, MIN(InvoiceDate) AS FirstInvoiceDate
FROM Invoices
GROUP BY VendorID;
/*
Commands completed successfully.

Completion time: 2021-05-05T20:56:32.3498906-05:00
*/
---------------------------------------------------------------------------------------------------------------------------------
/*
4.Write a script that uses dynamic SQL to return a single column that represents the number of rows in a particular table in the current database. 
The script should automatically choose the user base table that appears first alphabetically. 
Exclude system tables, views, and the table named “dtproperties.” Name the column CountOfTable, where Table is the chosen table name.
Hint: Use one of the information schema views.
*/
DECLARE @TableName varchar(128);

SELECT @TableName = MIN(name)
FROM sys.tables
WHERE name <> 'dtproperties' AND name <> 'sysdiagrams';

EXEC ('SELECT COUNT(*) AS CountOf' + @TableName +
      ' FROM ' + @TableName + ';');
/*
CountOfContactUpdates
---------------------
8

(1 row affected)


Completion time: 2021-05-05T20:57:39.4574157-05:00
*/


