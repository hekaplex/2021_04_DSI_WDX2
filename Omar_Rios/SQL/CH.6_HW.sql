USE AP

SELECT InvoiceNumber, InvoiceDate, InvoiceTotal

FROM Invoices

WHERE InvoiceTotal > (SELECT AVG (InvoiceTotal) FROM Invoices) 

ORDER BY InvoiceTotal


 /*  Q.1 
 
 Write a SELECT statement that returns the same result set as this SELECT statement. Substitute a subquery in a WHERE clause for the inner join. 

SELECT DISTINCT VendorName FROM Vendors JOIN Invoices 

ON Vendors.VendorID = Invoices.VendorID 

ORDER BY VendorName */

SELECT DISTINCT VendorName 

FROM Vendors 

WHERE VendorID IN (SELECT VendorID FROM Invoices) 

ORDER BY VendorName

/* Q.2 Write a SELECT statement that answers this question: 
Which invoices have a PaymentTotal that’s greater than the average PaymentTotal for all paid invoices?
Return the InvoiceNumber and InvoiceTotal for each invoice. */

SELECT PaymentTotal

FROM Invoices

WHERE PaymentTotal > (SELECT AVG (PaymentTotal) FROM Invoices WHERE PaymentTotal <> 0 )  

/* Q.3 
3.Write a SELECT statement that answers this question: 
		Which invoices have a PaymentTotal that’s greater than the median PaymentTotal for all paid invoices? 
		(The median marks the midpoint in a set of values; an equal number of values lie above and below it.) 
		Return the InvoiceNumber and InvoiceTotal for each invoice.
		Hint: Begin with the solution to exercise 2, then use the ALL keyword in the WHERE clause and code “TOP 50 PERCENT PaymentTotal” in the subquery.
*/

SELECT InvoiceNumber, InvoiceTotal
FROM Invoices
WHERE PaymentTotal > ALL 
(SELECT TOP 50 PERCENT PaymentTotal FROM Invoices WHERE PaymentTotal <> 0 ORDER BY PaymentTotal) 



/* Q.4 
4.Write a SELECT statement that returns two columns from the GLAccounts table: 
AccountNo and AccountDescription. The result set should have one row for each account number that has never been used. 
Use a correlated subquery introduced with the NOT EXISTS operator. Sort the final result set by AccountNo */ 

SELECT AccountNo, AccountDescription

FROM GLAccounts

WHERE NOT EXISTS (Select * FROM InvoiceLineItems WHERE InvoiceLineItems.AccountNo = GLAccounts.AccountNo) 

ORDER BY AccountNo

/* 
Q5.Write a SELECT statement that returns four columns: 
VendorName, InvoiceID, InvoiceSequence, and InvoiceLineItemAmount for each invoice that has more than one line item in the InvoiceLineItems table.
Hint: Use a subquery that tests for InvoiceSequence > 1.
*/

SELECT VendorName, Invoices.InvoiceID, InvoiceSequence, InvoiceLineItemAmount

FROM Vendors JOIN Invoices 

ON Vendors.VendorID = Invoices.VendorID

JOIN InvoiceLineItems 

ON Invoices.InvoiceID = InvoiceLineItems.InvoiceID

WHERE Invoices.InvoiceID IN (SELECT InvoiceID FROM InvoiceLineItems WHERE InvoiceSequence > 1)


/* Q6. Write a SELECT statement that returns a single value that represents the sum of the largest unpaid invoices submitted by each vendor. 
		Use a derived table that returns MAX(InvoiceTotal) grouped by VendorID, filtering for invoices with a balance due.
*/  

SELECT SUM(maxed) AS UnpaidInvoices

FROM (SELECT VendorID, MAX(InvoiceTotal) AS maxed FROM Invoices)

GROUP BY VendorID
/*
Q7.Write a SELECT statement that returns the name, city, and state of each vendor that’s located in a unique city and state. 
In other words, don’t include vendors that have a city and state in common with another vendor.
*/

SELECT VendorName, VendorCity, VendorState

FROM Vendors AS Vendors_Main

WHERE VendorCity + VendorState NOT IN

(SELECT VendorCity + VendorState

FROM Vendors AS Vendors_Sub
WHERE Vendors_Sub.VendorID <> Vendors_Main.VendorID)


/*
Q8.Write a SELECT statement that returns four columns: 
		VendorName, InvoiceNumber, InvoiceDate, and InvoiceTotal. 
		Return one row per vendor, representing the vendor’s invoice with the earliest date.
*/
SELECT VendorName, InvoiceNumber AS EarlyInv,
       FirstInvoice.InvoiceDate, InvoiceTotal
FROM Invoices JOIN
(SELECT VendorID, MIN(InvoiceDate) AS InvoiceDate FROM Invoices GROUP BY VendorID) AS FirstInvoice
ON (Invoices.VendorID = FirstInvoice.VendorID AND
Invoices.InvoiceDate = FirstInvoice.InvoiceDate)
JOIN Vendors
  ON Invoices.VendorID = Vendors.VendorID
ORDER BY VendorName