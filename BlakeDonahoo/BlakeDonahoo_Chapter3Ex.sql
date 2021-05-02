--Blake Donahoo
--Homework assignment April 29, 2021
--Chapter 3 Exercises


USE AP;
GO
/* 
		1.Write a SELECT statement that returns three columns from the Vendors table: 
		VendorContactFName, VendorContactLName, and VendorName. 
		Sort the result set by last name, then by first name.
*/
SELECT VendorContactFName
		,VendorContactLName
		,VendorName
FROM Vendors
ORDER BY VendorContactLName
		,VendorContactFName;
/*
VendorContactFName                                 VendorContactLName                                 VendorName
-------------------------------------------------- -------------------------------------------------- --------------------------------------------------
Thom                                               Aaronsen                                           Dristas Groom & McCormick
Joan                                               Aileen                                             Internal Revenue Service
Francesco                                          Alberto                                            US Postal Service
Alexandro                                          Alexis                                             Yale Industrial Trucks-Fresno
*/
----------------------------------------------------
/* 
		2.Write a SELECT statement that returns four columns from the Invoices table, named Number, Total, Credits, and Balance:
		Number		Column alias for the InvoiceNumber column Total	
					Column alias for the InvoiceTotal column
		Credits		Sum of the PaymentTotal and CreditTotal columns
		Balance		InvoiceTotal minus the sum of PaymentTotal and CreditTotal
			a.Use the AS keyword to assign column aliases.
			b.Use the = assignment operator to assign column aliases.
*/
SELECT Number = InvoiceNumber,
       Total = InvoiceTotal,
       Credits = PaymentTotal + CreditTotal,
       Balance = InvoiceTotal - (PaymentTotal + CreditTotal)
FROM Invoices;
/*
Number                                             Total                 Credits               Balance
-------------------------------------------------- --------------------- --------------------- ---------------------
989319-457                                         3813.33               3813.33               0.00
263253241                                          40.20                 40.20                 0.00
963253234                                          138.75                138.75                0.00
2-000-2993                                         144.70                144.70                0.00
*/
----------------------------------------------------
/*
		3.Write a SELECT statement that returns one column from the Vendors table named Full Name. 
		Create this column from the VendorContactFName and VendorContactLName columns. 
		Format it as follows: last name, comma, first name (for example, “Doe, John”). 
		Sort the result set by last name, then by first name.
*/
SELECT VendorContactLName + ', ' + VendorContactFName AS [Full Name]
FROM Vendors
ORDER BY VendorContactLName, VendorContactFName;
/*
Full Name
------------------------------------------------------------------------------------------------------
Aaronsen, Thom
Aileen, Joan
Alberto, Francesco
Alexis, Alexandro
*/
-------------------------------------------------------------
/*
		4.Write a SELECT statement that returns three columns: 
		InvoiceTotal		From the Invoices table
		10%					10% of the value of InvoiceTotal Plus 
		10%					The value of InvoiceTotal plus 10%
		(For example, if InvoiceTotal is 100.0000, 10% is 10.0000, and Plus 10% is 110.0000.) 
		Only return those rows with a balance due greater than 1000. 
		Sort the result set by InvoiceTotal, with the largest invoice first.
*/
SELECT InvoiceTotal, InvoiceTotal / 10 AS [10%],
       InvoiceTotal * 1.1 AS [Plus 10%]
FROM Invoices
WHERE InvoiceTotal - PaymentTotal - CreditTotal > 1000
ORDER BY InvoiceTotal DESC;
/*
InvoiceTotal          10%                   Plus 10%
--------------------- --------------------- ---------------------------------------
20551.18              2055.118              22606.29800
10976.06              1097.606              12073.66600
*/
------------------------------------------------------
/*
		5.Modify the solution to exercise 2a to filter for invoices with an 
		InvoiceTotal that’s greater than or equal to $500 but less than or equal to $10,000.
*/
SELECT InvoiceNumber AS Number,
       InvoiceTotal AS Total,
       PaymentTotal + CreditTotal AS Credits,
       InvoiceTotal - (PaymentTotal + CreditTotal) AS Balance
FROM Invoices
WHERE InvoiceTotal BETWEEN 500 AND 10000;
/*
Number                                             Total                 Credits               Balance
-------------------------------------------------- --------------------- --------------------- ---------------------
989319-457                                         3813.33               3813.33               0.00
97/488                                             601.95                601.95                0.00
I77271-O01                                         662.00                662.00                0.00
P02-88D77S7                                        856.92                856.92                0.00
*/
------------------------------------------------------
/*
6.Modify the solution to exercise 3 to filter for contacts whose last name begins with the letter A, B, C, or E.
*/
SELECT VendorContactLName + ', ' + VendorContactFName AS [Full Name]
FROM Vendors
WHERE VendorContactLName LIKE '[A,B,C,E]%'
ORDER BY VendorContactLName, VendorContactFName;
/*
Full Name
------------------------------------------------------------------------------------------------------
Aaronsen, Thom
Aileen, Joan
Alberto, Francesco
Alexis, Alexandro
Alondra, Zev
*/
-------------------------------------------------------
/*
		7.Write a SELECT statement that determines whether the PaymentDate column of the Invoices table has any invalid values. 
		To be valid, PaymentDate must be a null value if there’s a balance due and a non-null value if there’s no balance due. 
		Code a compound condition in the WHERE clause that tests for these conditions.
*/
SELECT *
FROM Invoices
WHERE ((InvoiceTotal - PaymentTotal - CreditTotal <= 0) AND PaymentDate IS NOT NULL) 
		OR
      ((InvoiceTotal - PaymentTotal - CreditTotal > 0) AND PaymentDate IS NULL)
ORDER BY InvoiceTotal DESC;
/*
InvoiceID   VendorID    InvoiceNumber                                      InvoiceDate             InvoiceTotal          PaymentTotal          CreditTotal           TermsID     InvoiceDueDate          PaymentDate
----------- ----------- -------------------------------------------------- ----------------------- --------------------- --------------------- --------------------- ----------- ----------------------- -----------------------
39          110         0-2058                                             2016-01-28 00:00:00     37966.19              37966.19              0.00                  3           2016-02-27 00:00:00     2016-02-28 00:00:00
96          110         P-0259                                             2016-03-19 00:00:00     26881.40              26881.40              0.00                  3           2016-04-18 00:00:00     2016-04-20 00:00:00
106         110         0-2060                                             2016-03-24 00:00:00     23517.58              21221.63              2295.95               3           2016-04-23 00:00:00     2016-04-27 00:00:00
43          72          40318                                              2016-02-01 00:00:00     21842.00              21842.00              0.00                  3           2016-03-01 00:00:00     2016-02-28 00:00:00
102         110         P-0608                                             2016-03-23 00:00:00     20551.18              0.00                  1200.00               3           2016-04-22 00:00:00     NULL
112         110         0-2436                                             2016-03-31 00:00:00     10976.06              0.00                  0.00                  3           2016-04-30 00:00:00     NULL
*/