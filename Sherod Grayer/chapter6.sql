/*
1.	Write a SELECT statement that returns the same result set as this SELECT statement. Substitute a subquery in a WHERE clause for the inner join.
SELECT DISTINCT VendorName FROM Vendors JOIN Invoices
ON Vendors.VendorID = Invoices.VendorID
ORDER BY VendorName
*/


SELECT VendorName
FROM Vendors
WHERE VendorID IN
     (SELECT VendorID FROM Invoices)
ORDER BY VendorName;


/*
VendorName
--------------------------------------------------
Abbey Office Furnishings
Bertelsmann Industry Svcs. Inc
Blue Cross
Cahners Publishing Company
Cardinal Business Media, Inc.
Coffee Break Service
Compuserve
*/


/*
2.	Write a SELECT statement that answers this question: Which invoices have a PaymentTotal that’s greater than the average PaymentTotal for all paid invoices? Return the InvoiceNumber and InvoiceTotal for each invoice.
*/

SELECT InvoiceNumber, InvoiceTotal
FROM Invoices
WHERE PaymentTotal >
     (SELECT AVG(PaymentTotal)
      FROM Invoices
      WHERE PaymentTotal <> 0);

	  /*
	  InvoiceNumber                                      InvoiceTotal
-------------------------------------------------- ---------------------
989319-457                                         3813.33
10843                                              4901.26
77290                                              1750.00
P02-3772                                           7125.34
0-2058                                             37966.19
40318                                              21842.00
*/

/*
3.	Write a SELECT statement that answers this question: Which invoices have a PaymentTotal that’s greater than the median PaymentTotal for all paid invoices? (The median marks the midpoint in a set of values; an equal number of values lie above and below it.) Return the InvoiceNumber and InvoiceTotal for each invoice.
*/
SELECT InvoiceNumber, InvoiceTotal
FROM Invoices
WHERE PaymentTotal > ALL
     (SELECT TOP 50 PERCENT PaymentTotal
      FROM Invoices
      WHERE PaymentTotal <> 0
      ORDER BY PaymentTotal);

	  /*
	  InvoiceNumber                                      InvoiceTotal
-------------------------------------------------- ---------------------
989319-457                                         3813.33
963253234                                          138.75
2-000-2993                                         144.70
963253237                                          172.50
97/488                                             601.95
I77271-O01                                         662.00
P02-88D77S7                                        856.92
10843                                              4901.26
*/



/*
4.	Write a SELECT statement that returns two columns from the GLAccounts table: AccountNo and AccountDescription. The result set should have one row for each account number that has never been used. Use a correlated subquery introduced with the NOT EXISTS operator. Sort the final result set by AccountNo.
*/


SELECT AccountNo, AccountDescription
FROM GLAccounts
WHERE NOT EXISTS
    (SELECT *
     FROM InvoiceLineItems
     WHERE InvoiceLineItems.AccountNo = GLAccounts.AccountNo)
ORDER BY AccountNo;

/*
AccountNo   AccountDescription
----------- --------------------------------------------------
100         Cash
110         Accounts Receivable
120         Book Inventory
162         Capitalized Lease
167         Software
*/



/*
5.	Write a SELECT statement that returns four columns: VendorName, InvoiceID, InvoiceSequence, and InvoiceLineItemAmount for each invoice that has more than one line item in the InvoiceLineItems table.
*/

SELECT VendorName, Invoices.InvoiceID, InvoiceSequence, InvoiceLineItemAmount
FROM Vendors JOIN Invoices 
  ON Vendors.VendorID = Invoices.VendorID
JOIN InvoiceLineItems
  ON Invoices.InvoiceID = InvoiceLineItems.InvoiceID
WHERE Invoices.InvoiceID IN
      (SELECT InvoiceID
       FROM InvoiceLineItems
       WHERE InvoiceSequence > 1)
ORDER BY VendorName, Invoices.InvoiceID, InvoiceSequence;

/*
VendorName                                         InvoiceID   InvoiceSequence InvoiceLineItemAmount
-------------------------------------------------- ----------- --------------- ---------------------
Wells Fargo Bank                                   12          1               50.00
Wells Fargo Bank                                   12          2               75.60
Wells Fargo Bank                                   12          3               58.40
Wells Fargo Bank                                   12          4               478.00
Zylka Design                                       78          1               1197.00
Zylka Design                                       78          2               765.13

*/

/*
6.	Write a SELECT statement that returns a single value that represents the sum of the largest unpaid invoices submitted by each vendor. Use a derived table that returns MAX(InvoiceTotal) grouped by VendorID, filtering for invoices with a balance due.
*/

SELECT SUM(InvoiceMax) AS SumOfMaximums
FROM (SELECT VendorID, MAX(InvoiceTotal) AS InvoiceMax
      FROM Invoices
      WHERE InvoiceTotal - CreditTotal - PaymentTotal > 0
      GROUP BY VendorID) AS MaxInvoice;

	  /*
	  SumOfMaximums
---------------------
22101.39
*/


/*
7.	Write a SELECT statement that returns the name, city, and state of each vendor that’s located in a unique city and state. In other words, don’t include vendors that have a city and state in common with another vendor.
*/

SELECT VendorName, VendorCity, VendorState
FROM Vendors
WHERE VendorState + VendorCity NOT IN 
	(SELECT VendorState + VendorCity
	FROM Vendors
	GROUP BY VendorState + VendorCity
	HAVING COUNT(*) > 1)
ORDER BY VendorState, VendorCity;


/*
VendorName                                         VendorCity                                         VendorState
-------------------------------------------------- -------------------------------------------------- -----------
Diversified Printing & Pub                         Brea                                               CA
Vision Envelope & Printing                         Gardena                                            CA
Texaco                                             Inglewood                                          CA
Publishers Marketing Assoc                         Manhatttan Beach                                   CA
Blanchard & Johnson Associates                     Mission Viejo                                      CA
Blue Cross                                         Oxnard                                             CA

*/

/*
8.	Write a SELECT statement that returns four columns: VendorName, InvoiceNumber, InvoiceDate, and InvoiceTotal. Return one row per vendor, representing the vendor’s invoice with the earliest date.

*/

SELECT VendorName, InvoiceNumber AS FirstInv,
       InvoiceDate, InvoiceTotal
FROM Invoices AS I_Main JOIN Vendors
  ON I_Main.VendorID = Vendors.VendorID
WHERE InvoiceDate =
  (SELECT MIN(InvoiceDate)
   FROM Invoices AS I_Sub
   WHERE I_Sub.VendorID = I_Main.VendorID)
ORDER BY VendorName;


/*
VendorName                                         FirstInv                                           InvoiceDate             InvoiceTotal
-------------------------------------------------- -------------------------------------------------- ----------------------- ---------------------
Abbey Office Furnishings                           203339-13                                          2016-03-05 00:00:00     17.50
Bertelsmann Industry Svcs. Inc                     509786                                             2016-02-18 00:00:00     6940.25
Blue Cross                                         547481328                                          2016-02-03 00:00:00     224.00
Cahners Publishing Company                         587056                                             2016-02-28 00:00:00     2184.50
Cardinal Business Media, Inc.                      133560                                             2016-02-22 00:00:00     175.00
Coffee Break Service                               109596                                             2016-02-24 00:00:00     41.80
Compuserve                                         21-4748363                                         2016-01-03 00:00:00     9.95
*/


