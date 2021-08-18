USE AP


/*
Write SELECT INTO statements to create two test tables named VendorCopy and InvoiceCopy
that are complete copies of the Vendors and Invoices tables. If VendorCopy and InvoiceCopy already exist,
first code two DROP TABLE statements to delete them. 
*/ 

SELECT * 
INTO InvoiceCopy
FROM Invoices

SELECT * 
INTO VendorCopy
FROM Vendors


/*Write an INSERT statement that adds a row to the InvoiceCopy table with the following values: 

VendorID:	32	InvoiceTotal:	$434.58 TermsID:	2 

InvoiceNumber: AX-014-027	PaymentTotal:  $0.00	InvoiceDueDate: 11/8/02 InvoiceDate:	10/21/02	CreditTotal:	$0.00	PaymentDate:	null  
*/ 

INSERT INTO InvoiceCopy
(VendorID , InvoiceTotal , TermsID , InvoiceNumber , PaymentTotal , InvoiceDueDate ,  InvoiceDate , CreditTotal , PaymentDate) 
Values (32, '$434.58' , 2 , 'AX-014-027', '$0.00' , '11/8/02', '11/21/02 ', '$0.00' , null);

/* Write an INSERT statement that adds a row to the VendorCopy table for each 

non-California vendor in the Vendors table. (This will result in duplicate vendors in the VendorCopy table.) */ 

INSERT INTO VendorsCopy
SELECT VendorName, VendorAddress1, VendorAddress2,
       VendorCity, VendorState, VendorZipCode,
       VendorPhone, VendorContactLName, VendorContactFName,
       DefaultTermsID, DefaultAccountNo
FROM Vendors
WHERE VendorCity != 'CA'

/* Write an UPDATE statement that modifies the VendorCopy table. 
Change the default account number to 403 for each vendor that has a default account number of 400. */ 

UPDATE VendorsCopy
SET DefaultAccountNo = 403
WHERE DefaultAccountNo = 400

/*Write an UPDATE statement that modifies the InvoiceCopy table. 
Change the PaymentDate to today’s date and the PaymentTotal to the balance due for each invoice with a balance due. 
Set today’s date with a literal date string, or use the GETDATE() function. */

UPDATE InvoiceCopy
SET PaymentDate = GETDATE() 
WHERE InvoiceTotal - CreditTotal > 0;

/* Write an UPDATE statement that modifies the InvoiceCopy table. 
Change TermsID to 2 for each invoice that’s from a vendor with a DefaultTermsID of 2. Use a subquery. */

UPDATE InvoiceCopy
SET TermsID = 2 
WHERE VendorID IN
(SELECT VendorID 
FROM VendorsCopy 
WHERE DefaultTermsID = 2)

/* Solve exercise 6 using a join rather than a subquery. */ 

UPDATE InvoiceCopy 
SET TermsID = 2
FROM InvoiceCopy JOIN VendorsCopy
	ON VendorsCopy.VendorID = InvoiceCopy.VendorID
WHERE DefaultTermsID = 2;

/* Write a DELETE statement that deletes all vendors in the state of Minnesota from the VendorCopy table. */ 
DELETE VendorsCopy 
WHERE VendorState = 'MN'


/* Write a DELETE statement for the VendorCopy table. Delete the vendors that are located in states from which no vendor has ever sent an invoice. 

Hint: Use a subquery coded with “SELECT DISTINCT VendorState” introduced with the NOT IN operator. */ 

DELETE VendorsCopy 
WHERE VendorState NOT IN 
	(SELECT DISTINCT VendorState 
	FROM InvoiceCopy JOIN VendorsCopy
	ON VendorsCopy.VendorID = InvoiceCopy.VendorID)
 