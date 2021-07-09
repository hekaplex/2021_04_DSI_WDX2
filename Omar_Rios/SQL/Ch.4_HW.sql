/* Q.1 Write a SELECT statement that returns all columns from the Vendors table inner- 
joined with the Invoices table.*/  

SELECT *
FROM Vendors JOIN Invoices
ON Vendors.VendorID = Invoices.VendorID

/* Q.2 Write a SELECT statement that returns four columns: VendorName	
From the Vendors table 
InvoiceNumber From the Invoices table 
InvoiceDate From the Invoices table 
Balance	InvoiceTotal minus the sum of PaymentTotal and CreditTotal 
The result set should have one row for each invoice with a non-zero balance. Sort the result set by VendorName in ascending order. 
*/

SELECT VendorName, InvoiceNumber, InvoiceDate, 
InvoiceTotal - (PaymentTotal + CreditTotal) AS Balance
FROM Vendors 
JOIN Invoices ON Vendors.VendorID = Invoices.VendorID 
WHERE InvoiceTotal - (PaymentTotal + CreditTotal) > 0
ORDER BY VendorName 

/* Q.3 Write a SELECT statement that returns three columns: 
VendorName From the Vendors table 
DefaultAccountNo From the Vendors table 
AccountDescription From the GLAccounts table 
The result set should have one row for each vendor, 
with the account number and account description for that vendor’s default account number. 
Sort the result set by AccountDescription, then by VendorName. 
*/
SELECT VendorName, DefaultAccountNo, AccountDescription

FROM Vendors 
JOIN GLAccounts ON DefaultAccountNo = GLAccounts.AccountNo

ORDER BY AccountDescription, VendorName
-- Q.4 Generate the same result set described in exercise 2, but use the implicit join syntax. 
SELECT VendorName,InvoiceNumber,InvoiceDate
FROM Vendors, Invoices 
WHERE Vendors.VendorID = Invoices.VendorID

/* Q.5 Write a SELECT statement that returns five columns from three tables, all using column aliases: 
Vendor	VendorName column
Date	InvoiceDate column 
Number	InvoiceNumber column 
#	InvoiceSequence column 
LineItem	InvoiceLineItemAmount column Assign the following correlation names to the tables: 
Vend	Vendors table 
Inv	Invoices table LineItem	InvoiceLineItems table 
Sort the final result set by Vendor, Date, Number, and #. */

SELECT VendorName AS Vendor, InvoiceDate AS Date, InvoiceNumber AS Number, InvoiceSequence AS [#], InvoiceLineItemAmount AS LineItem

FROM Invoices i JOIN Vendors v
ON v.VendorID = i.VendorID
Join InvoiceLineItems AS li 
ON i.InvoiceID = li.InvoiceID
ORDER BY Vendor,Date,Number, [#]
/* 
Q.6 Write a SELECT statement that returns three columns: VendorID From the Vendors table 
VendorName	From the Vendors table 
Name	A concatenation of VendorContactFName and 
VendorContactLName, with a space in between 
The result set should have one row for each vendor whose contact has the same first name as another vendor’s contact. Sort the final result set by Name. 
Hint: Use a self-join. 
*/
SELECT DISTINCT Vendors1.VendorName,Vendors1.VendorID,
Vendors1.VendorContactFName + '' + Vendors1.VendorContactLName AS Name 
FROM Vendors AS Vendors1 JOIN Vendors AS Vendors2
ON (Vendors1.VendorID <> Vendors2.VendorID) AND 
(Vendors1.VendorContactFName = Vendors2.VendorContactFName) 
Order BY Name ASC;
/*
A.6 
VendorName					VendorID	Name
Federal Express Corporation	123			CharlieBucket
Dataforms/West				120			CharlieChurch
Unocal						118			RachaelBluzinski
Executive Office Products	73			RachaelDanielson
Pollstar					113			RobertAranovitch
Wang Laboratories, Inc.		81			RobertKapil
*/

/*
Q.7 Write a SELECT statement that returns two columns from the GLAccounts table: AccountNo and AccountDescription. The result set should have one row for each account number that has never been used. Sort the final result set by AccountNo. 
Hint: Use an outer join to the InvoiceLineItems table.  
*/ 

SELECT GLAccounts.AccountNo,GLAccounts.AccountDescription
FROM GLAccounts LEFT JOIN InvoiceLineItems 
ON GLAccounts.AccountNo = InvoiceLineItems.AccountNo
WHERE InvoiceLineItems.AccountNo IS NULL 
Order By GLAccounts.AccountNo

/*
Q.8 
Use the UNION operator to generate a result set consisting of two columns from the Vendors table: VendorName and VendorState. 
If the vendor is in California, the VendorState value should be “CA”; otherwise, the VendorState value should be “Outside CA.” 
Sort the final result set by VendorName. 
*/ 

SELECT VendorName, VendorState
FROM Vendors
WHERE VendorState= 'CA'
UNION 
Select VendorName, 'Outside CA'
FROM Vendors
Where VendorState <> 'CA'
ORDER BY VendorName


/* 
A.8 
VendorName						VendorState
Abbey Office Furnishings		CA
American Booksellers Assoc		Outside CA
American Express				CA
ASC Signs						CA
Ascom Hasler Mailing Systems	Outside CA
*/