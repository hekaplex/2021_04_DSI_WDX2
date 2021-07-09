USE AP 

GO 

/*Q1.Write a SELECT statement that returns two columns 
from the Invoices table: VendorID and PaymentSum, where PaymentSum is the sum of the PaymentTotal column. 
Group the result set by VendorID.  */
SELECT VendorID,

SUM(PaymentTotal) AS PaymentSum

FROM Invoices

GROUP BY VendorID


/*Q2. Write a SELECT statement that returns two columns: 
VendorName and PaymentSum, where PaymentSum is the sum of the PaymentTotal column. Group the result set by VendorName.
Return only 10 rows, corresponding to the 10 vendors who’ve been paid the most. 
Hint: Use the TOP clause and join Vendors to Invoices.  */

SELECT TOP 10 VendorName, SUM(PaymentTotal) AS PaymentSum

FROM Vendors JOIN Invoices
ON Vendors.VendorID = Invoices.VendorID
GROUP BY VendorName
Order BY PaymentSum DESC 

/*
Q3. Write a SELECT statement that returns three columns: 
VendorName, InvoiceCount, and InvoiceSum. InvoiceCount is the count of the number of invoices, and InvoiceSum is the sum of the InvoiceTotal column. 
Group the result set by vendor. Sort the result set so that the vendor with the highest number of invoices appears first. 
*/

SELECT VendorName, COUNT(*) AS InvoiceCount, SUM (InvoiceTotal) AS InvoiceSum
FROM Invoices JOIN Vendors
ON Vendors.VendorID = Invoices.VendorID 
GROUP BY VendorName 
ORDER BY InvoiceCount DESC; 

/*
Q4.Write a SELECT statement that returns three columns: 
AccountDescription, LineItemCount, and LineItemSum. 
LineItemCount is the number of entries in the InvoiceLineItems table that have that AccountNo. 
LineItemSum is the sum of the InvoiceLineItemAmount column for that AccountNo. 
Filter the result set to include only those rows with LineItemCount greater than 1. 
Group the result set by account description, and sort it by descending LineItemCount.
Hint: Join the GLAccounts table to the InvoiceLineItems table.
*/

SELECT AccountDescription, COUNT (*) AS LineItemCount, 
SUM(InvoiceLineItemAmount) AS LineItemSum

FROM GLAccounts JOIN InvoiceLineItems
ON GLAccounts.AccountNo = InvoiceLineItems.AccountNo
GROUP BY AccountDescription
ORDER BY LineItemCount DESC; 

/*
Q5.Modify the solution to exercise 4 to filter for invoices dated in the first quarter of 2002 (January 1, 2002 to March 31, 2002).
Hint: Join to the Invoices table to code a search condition based on InvoiceDate.
*/

SELECT AccountDescription, COUNT (*) AS LineItemCount, 
SUM(InvoiceLineItemAmount) AS LineItemSum
FROM GLAccounts JOIN InvoiceLineItems
ON GLAccounts.AccountNo = InvoiceLineItems.AccountNo
JOIN Invoices
ON InvoiceLineItems.InvoiceID = Invoices.InvoiceID
WHERE InvoiceDate BETWEEN '2002-01-01' '2002-03-31' 
GROUP BY AccountDescription
ORDER BY LineItemCount DESC; 

/*
Q6.Write a SELECT statement that answers the following question: 
What is the total amount invoiced for each AccountNo? Use the WITH ROLLUP operator to include a row that gives the grand total.
Hint: Use the InvoiceLineItemAmount column of the InvoiceLineItems table.
*/

SELECT AccountNo, SUM(InvoiceLineItemAmount)  AS LineItemTotal
FROM InvoiceLineItems
GROUP BY AccountNo WITH ROLLUP;


/*
Q7.Write a SELECT statement that returns four columns: VendorName, AccountDescription, LineItemCount, and LineItemSum. 
LineItemCount is the row count, 
LineItemSum is the sum of the InvoiceLineItemAmount column. 
For each vendor and account, return the number and sum of line items, sorted first by vendor, then by account description.
Hint: Use a four-way join.
*/

SELECT VendorName, AccountDescription, Count(*) AS LineItemCount, SUM(InvoiceLineItemAmount) AS LineItemSUM  
FROM Vendors JOIN Invoices 
ON Vendors.VendorID = Invoices.VendorID
JOIN InvoiceLineItems
ON InvoiceLineItems.InvoiceID = Invoices.InvoiceID
JOIN GLAccounts
ON InvoiceLineItems.AccountNo = GLAccounts.AccountNo
GROUP BY VendorName, AccountDescription
ORDER BY VendorName, AccountDescription


/*
Q8.Write a SELECT statement that answers this question: 
Which vendors are being paid from more than one account? 
Return two columns: the vendor name and the total number of accounts that apply to that vendor’s invoices.
Hint: Use the DISTINCT keyword to count InvoiceLineItems.AccountNo.
*/

SELECT VendorName, COUNT (DISTINCT AccountNo) AS [# of Accounts]

FROM Vendors JOIN Invoices 
ON Vendors.VendorID = Invoices.VendorID
JOIN InvoiceLineItems 
ON Invoices.InvoiceID = InvoiceLineItems.InvoiceID
GROUP BY VendorName
HAVING COUNT (DISTINCT InvoiceLineItems.AccountNo) > 1 
ORDER BY VendorName 