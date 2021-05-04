--Blake Donahoo
--Homework assignment May 3, 2021
--Chapter 7 Exercises

USE AP
GO

/*
		1.Write SELECT INTO statements to create two test tables named 
		VendorCopy and InvoiceCopy that are complete copies of the Vendors and Invoices tables. 
		If VendorCopy and InvoiceCopy already exist, first code two DROP TABLE statements to delete them.
*/
DROP TABLE InvoiceCopy;
DROP TABLE VendorCopy;

SELECT *
INTO InvoiceCopy
FROM Invoices;

SELECT *
INTO VendorCopy
FROM Vendors;
/*
Commands completed successfully.

Completion time: 2021-05-03T17:19:18.8543454-05:00

(114 rows affected)

(122 rows affected)

Completion time: 2021-05-03T17:19:47.4195371-05:00
*/

---------------------------------------------------------------------------------------------------------------------------

/*
		2.Write an INSERT statement that adds a row to the InvoiceCopy table with the following values:
		VendorID:	32	
		InvoiceTotal:	$434.58 
		TermsID:	2
		InvoiceNumber: AX-014-027	
		PaymentTotal:  $0.00	
		InvoiceDueDate: 11/8/02 
		InvoiceDate:	10/21/02	
		CreditTotal:	$0.00	
		PaymentDate:	null
*/
INSERT InvoiceCopy
VALUES (32, 'AX-014-027', '2012-6-21', 434.58, 0, 0,
        2, '2012-07-08', NULL);
/*
(1 row affected)

Completion time: 2021-05-03T17:24:58.2895128-05:00
*/

---------------------------------------------------------------------------------------------------------------------------
/*
		3.Write an INSERT statement that adds a row to the VendorCopy table for each
		non-California vendor in the Vendors table. (This will result in duplicate vendors in the VendorCopy table.)
*/
INSERT VendorCopy
SELECT VendorName, VendorAddress1, VendorAddress2,
       VendorCity, VendorState, VendorZipCode,
       VendorPhone, VendorContactLName, VendorContactFName,
       DefaultTermsID, DefaultAccountNo
FROM Vendors
WHERE VendorState <> 'CA';
/*
(47 rows affected)

Completion time: 2021-05-03T17:30:23.3122449-05:00
*/

---------------------------------------------------------------------------------------------------------------------------
/*
		4.Write an UPDATE statement that modifies the VendorCopy table. 
		Change the default account number to 403 for each vendor that has a default account number of 400.
*/
UPDATE VendorCopy
SET DefaultAccountNo = 403
WHERE DefaultAccountNo = 400;
/*
(9 rows affected)

Completion time: 2021-05-03T17:30:57.5542913-05:00
*/

---------------------------------------------------------------------------------------------------------------------------
/*
		5.Write an UPDATE statement that modifies the InvoiceCopy table. 
		Change the PaymentDate to today’s date and the PaymentTotal to the balance due for each invoice with a balance due. 
		Set today’s date with a literal date string, or use the GETDATE() function.
*/
UPDATE InvoiceCopy
SET PaymentDate = GETDATE(),
    PaymentTotal = InvoiceTotal - CreditTotal
WHERE InvoiceTotal - CreditTotal - PaymentTotal > 0;
/*
(13 rows affected)

Completion time: 2021-05-03T17:33:25.5935213-05:00
*/
---------------------------------------------------------------------------------------------------------------------------
/*
		6.Write an UPDATE statement that modifies the InvoiceCopy table. 
		Change TermsID to 2 for each invoice that’s from a vendor with a DefaultTermsID of 2. Use a subquery.
*/
UPDATE InvoiceCopy
SET TermsID = 2
WHERE VendorID IN
    (SELECT VendorID
     FROM VendorCopy
     WHERE DefaultTermsID = 2);
/*
(18 rows affected)

Completion time: 2021-05-03T17:34:25.1775012-05:00
*/
---------------------------------------------------------------------------------------------------------------------------
/*
		7.Solve exercise 6 using a join rather than a subquery.
*/
UPDATE InvoiceCopy
SET TermsID = 2
FROM InvoiceCopy JOIN VendorCopy
  ON InvoiceCopy.VendorID = VendorCopy.VendorID
WHERE DefaultTermsID = 2;
/*
(18 rows affected)

Completion time: 2021-05-03T17:34:25.1775012-05:00
*/
---------------------------------------------------------------------------------------------------------------------------
/*
		8.Write a DELETE statement that deletes all vendors in the state of Minnesota from the VendorCopy table.
*/
DELETE VendorCopy
WHERE VendorState = 'MN';
/*
(2 rows affected)

Completion time: 2021-05-03T17:37:34.1639390-05:00
*/
---------------------------------------------------------------------------------------------------------------------------
/*
		9.Write a DELETE statement for the VendorCopy table. 
		Delete the vendors that are located in states from which no vendor has ever sent an invoice.
		Hint: Use a subquery coded with “SELECT DISTINCT VendorState” introduced with the NOT IN operator.
*/
DELETE VendorCopy
WHERE VendorState NOT IN
  (SELECT DISTINCT VendorState
   FROM VendorCopy JOIN InvoiceCopy
     ON VendorCopy.VendorID = InvoiceCopy.VendorID);
/*
(32 rows affected)

Completion time: 2021-05-03T17:38:10.0196622-05:00
*/
