/*
1.	Write a SELECT statement that returns two columns from the Invoices table: VendorID and PaymentSum, 
where PaymentSum is the sum of the PaymentTotal column. Group the result set by VendorID.
*/


SELECT VendorID, SUM(PaymentTotal) AS PaymentSum
FROM Invoices
GROUP BY VendorID;


/*
VendorID    PaymentSum
----------- ---------------------
34          1200.12
37          340.00
48          856.92
72          21842.00
80          175.00
*/

/*
2.	Write a SELECT statement that returns two columns: VendorName and PaymentSum, where PaymentSum is the sum of the PaymentTotal column. Group the result set by VendorName. Return only 10 rows, corresponding to the 10 vendors who’ve been paid the most.
Hint: Use the TOP clause and join Vendors to Invoices.
*/


SELECT TOP 10 VendorName, SUM(PaymentTotal) AS PaymentSum
FROM Vendors JOIN Invoices
  ON Vendors.VendorID = Invoices.VendorID
GROUP BY VendorName
ORDER BY PaymentSum DESC;

/*
VendorName                                         PaymentSum
-------------------------------------------------- ---------------------
Malloy Lithographing Inc                           86069.22
United Parcel Service                              23177.96
Data Reproductions Corp                            21842.00
Digital Dreamworks                                 7125.34
Bertelsmann Industry Svcs. Inc                     6940.25
Zylka Design                                       6740.25
Yesmed, Inc                                        4901.26
Federal Express Corporation                        4167.13
Computerworld                                      2433.00
Cahners Publishing Company                         2184.50

*/


/*
3.	Write a SELECT statement that returns three columns: VendorName, InvoiceCount, and InvoiceSum. InvoiceCount is the count of the number of invoices, and InvoiceSum is the sum of the InvoiceTotal column. Group the result set by vendor. Sort the result set so that the vendor with the highest number of invoices appears first.
*/


SELECT VendorName, COUNT(*) AS InvoiceCount,
       SUM(InvoiceTotal) AS InvoiceSum
FROM Vendors JOIN Invoices
  ON Vendors.VendorID = Invoices.VendorID
GROUP BY VendorName
ORDER BY InvoiceCount DESC;

/*
VendorName                                         InvoiceCount InvoiceSum
-------------------------------------------------- ------------ ---------------------
Federal Express Corporation                        47           4378.02
United Parcel Service                              9            23177.96
Zylka Design                                       8            6940.25
Pacific Bell                                       6            171.01
Malloy Lithographing Inc                           5            119892.41
Roadway Package System, Inc                        4            43.67
Blue Cross                                         3            564.00
*/


/*
4.	Write a SELECT statement that returns three columns: AccountDescription, LineItemCount, and LineItemSum. LineItemCount is the number of entries in the InvoiceLineItems table that have that AccountNo. LineItemSum is the sum of the InvoiceLineItemAmount column for that AccountNo. Filter the result set to include only those rows with LineItemCount greater than 1. Group the result set by account description, and sort it by descending LineItemCount.
*/

SELECT GLAccounts.AccountDescription, COUNT(*) AS LineItemCount,
       SUM(InvoiceLineItemAmount) AS LineItemSum
FROM GLAccounts JOIN InvoiceLineItems
  ON GLAccounts.AccountNo = InvoiceLineItems.AccountNo
GROUP BY GLAccounts.AccountDescription
HAVING COUNT(*) > 1
ORDER BY LineItemCount DESC;

/*
AccountDescription                                 LineItemCount LineItemSum
-------------------------------------------------- ------------- ---------------------
Freight                                            60            27599.65
Book Printing Costs                                8             148759.97
Book Production Costs                              8             6175.12
Telephone                                          7             266.01
Direct Mail Advertising                            6             3900.77
Books, Dues, and Subscriptions                     6             5207.32
Computer Equipment                                 3             2137.05
Group Insurance                                    3             564.00
Office Supplies                                    3             175.80
Outside Services                                   3             13394.10
*/


/*
5.	Modify the solution to exercise 4 to filter for invoices dated in the first quarter of 2002 (January 1, 2002 to March 31, 2002).
*/


SELECT GLAccounts.AccountDescription, COUNT(*) AS LineItemCount,
       SUM(InvoiceLineItemAmount) AS LineItemSum
FROM GLAccounts JOIN InvoiceLineItems
  ON GLAccounts.AccountNo = InvoiceLineItems.AccountNo
 JOIN Invoices
   ON InvoiceLineItems.InvoiceID = Invoices.InvoiceID
WHERE InvoiceDate BETWEEN '2011-12-01' AND '2012-02-29'
GROUP BY GLAccounts.AccountDescription
HAVING COUNT(*) > 1
ORDER BY LineItemCount DESC;

/*
AccountDescription                                 LineItemCount LineItemSum
-------------------------------------------------- ------------- ---------------------
*/


/*
6.	Write a SELECT statement that answers the following question: What is the total amount invoiced for each AccountNo? Use the WITH ROLLUP operator to include a row that gives the grand total.
*/


SELECT AccountNo, SUM(InvoiceLineItemAmount) AS LineItemSum
FROM InvoiceLineItems
GROUP BY AccountNo WITH ROLLUP;

/*
AccountNo   LineItemSum
----------- ---------------------
150         17.50
160         2137.05
170         356.48
400         148759.97
403         6175.12
*/


/*
7.	Write a SELECT statement that returns four columns: VendorName, AccountDescription, LineItemCount, and LineItemSum. LineItemCount is the row count, and LineItemSum is the sum of the InvoiceLineItemAmount column. For each vendor and account, return the number and sum of line items, sorted first by vendor, then by account description.
*/

SELECT VendorName, AccountDescription, COUNT(*) AS LineItemCount,
       SUM(InvoiceLineItemAmount) AS LineItemSum
FROM Vendors JOIN Invoices
   ON Vendors.VendorID = Invoices.VendorID
 JOIN InvoiceLineItems
   ON Invoices.InvoiceID = InvoiceLineItems.InvoiceID
 JOIN GLAccounts
   ON InvoiceLineItems.AccountNo = GLAccounts.AccountNo
GROUP BY VendorName, AccountDescription
ORDER BY VendorName, AccountDescription;

/*
VendorName                                         AccountDescription                                 LineItemCount LineItemSum
-------------------------------------------------- -------------------------------------------------- ------------- ---------------------
Abbey Office Furnishings                           Furniture                                          1             17.50
Bertelsmann Industry Svcs. Inc                     Book Printing Costs                                1             6940.25
Blue Cross                                         Group Insurance                                    3             564.00
Cahners Publishing Company                         Direct Mail Advertising                            1             2184.50
Cardinal Business Media, Inc.                      Direct Mail Advertising                            2             265.36
Coffee Break Service                               Office Supplies                                    1             41.80
*/


/*
8.	Write a SELECT statement that answers this question: Which vendors are being paid from more than one account? Return two columns: the vendor name and the total number of accounts that apply to that vendor’s invoices.
*/


SELECT VendorName,
       COUNT(DISTINCT InvoiceLineItems.AccountNo) AS [# of Accounts]
FROM Vendors JOIN Invoices
  ON Vendors.VendorID = Invoices.VendorID
 JOIN InvoiceLineItems
   ON Invoices.InvoiceID = InvoiceLineItems.InvoiceID
GROUP BY VendorName
HAVING COUNT(DISTINCT InvoiceLineItems.AccountNo) > 1
ORDER BY VendorName;

/*
VendorName                                         # of Accounts
-------------------------------------------------- -------------
Wells Fargo Bank                                   3
Zylka Design                                       2
*/