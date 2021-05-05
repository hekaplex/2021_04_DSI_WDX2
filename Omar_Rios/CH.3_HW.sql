USE [AP]

GO


/*
	Q1. Write a SELECT statement that returns three columns from the Vendors table: VendorContactFName, 
	VendorContactLName, and VendorName.
	Sort the result set by last name, then by first name. 
*/

--A1.
Select [VendorContactfName], VendorContactlName, VendorName 

from Vendors


Order by [VendorContactLName]

/* 
Thom		Aaronsen	Dristas Groom & McCormick
Joan		Aileen		Internal Revenue Service
Francesco	Alberto		US Postal Service
Alexandro	Alexis		Yale Industrial Trucks-Fresno
Zev			Alondra		Leslie Company
*/

/*
Q2. 
Write a SELECT statement that returns four columns from the Invoices table, named Number, Total, Credits, and Balance: 
*/

Select Number = InvoiceNumber, 
Total = InvoiceTotal,
Credits = PaymentTotal + CreditTotal, 
Balance = InvoiceTotal - (PaymentTotal + CreditTotal)


From Invoices

/* A2. 
Number		Total	Credits	Balance
989319-457	381333	3813.33	0.00
263253241	40.20	40.20	0.00
963253234	138.75	138.75	0.00
2-000-2993	144.70	144.70	0.00
963253251	15.50	15.50	0.00
*/ 

/*
Q3. Write a SELECT statement that returns one column from the Vendors table named Full Name. 
Create this column from the VendorContactFName and VendorContactLName columns. Format it as follows: 
last name, comma, first name (for example, “Doe, John”). Sort the result set by last name, then by first name. 
*/

Select VendorContactLName + ','  + VendorContactFName AS [Full Name] 

From Vendors

Order By [Full Name]


/* 
Q4. Write a SELECT statement that returns three columns: InvoiceTotal	From the Invoices table 
10%	10% of the value of InvoiceTotal Plus 10%	The value of InvoiceTotal plus 10% 
(For example, if InvoiceTotal is 100.0000, 10% is 10.0000, and Plus 10% is 110.0000.)
Only return those rows with a balance due greater than 1000. Sort the result set by InvoiceTotal, with the largest invoice first. 
*/

SELECT

[10%] = InvoiceTotal*.10,

[10plus] = InvoiceTotal *1.1

FROM Invoices

WHERE InvoiceTotal- PaymentTotal - CreditTotal > 1000

ORDER BY InvoiceTotal DESC;

-- 10%			10plus
-- 1097.606000	12073.66600
-- 2055.118000	22606.29800

/* 
Q5. 
Modify the solution to exercise 2a to filter for 
invoices with an InvoiceTotal that’s greater than or equal to $500 but less than or equal to $10,000. 
*/ 

Select Number = InvoiceNumber, 
Total = InvoiceTotal,
Credits = PaymentTotal + CreditTotal, 
Balance = InvoiceTotal - (PaymentTotal + CreditTotal)


From Invoices
WHERE InvoiceTotal BETWEEN 500 and 10000

ORDER BY InvoiceTotal DESC; 

/*Q6. 
Modify the solution to exercise 3 to filter for contacts whose last name begins with the letter A, B, C, or E.
*/
SELECT VendorContactLName + ','  + VendorContactFName

FROM Vendors

WHERE VendorContactLName  LIKE '[A-C,E]%'

ORDER BY VendorContactLName

/* Q7. 

Write a SELECT statement that determines whether the PaymentDate column of the Invoices table has any invalid values. 
To be valid, PaymentDate must be a null value if there’s a balance due and a non-null value if there’s no balance due. 
Code a compound condition in the WHERE clause that tests for these conditions. */

SELECT *
FROM Invoices
WHERE ((InvoiceTotal - PaymentTotal - CreditTotal <= 0) AND PaymentDate IS NOT NULL) 
		OR
      ((InvoiceTotal - PaymentTotal - CreditTotal > 0) AND PaymentDate IS NULL)
ORDER BY InvoiceTotal DESC;