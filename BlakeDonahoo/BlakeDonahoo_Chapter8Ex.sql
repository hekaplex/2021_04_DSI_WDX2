--Blake Donahoo
--Homework assignment May 3, 2021
--Chapter 8 Exercises

USE AP
GO

/*
		1.Write a SELECT statement that returns four columns based on the InvoiceTotal column of the Invoices table:
		Use the CAST function to return the first column as data type decimal with 2 digits to the right of the decimal point.
		Use CAST to return the second column as a varchar.
		Use the CONVERT function to return the third column as the same data type as the first column.
		Use CONVERT to return the fourth column as a varchar, using style 1.
*/
SELECT CAST(InvoiceTotal AS decimal(17,2)) AS CastAsDecimal,
       CAST(InvoiceTotal AS varchar) AS CastAsVarchar,
       CONVERT(decimal(17,2),InvoiceTotal) AS ConvertToDecimal,
       CONVERT(varchar,InvoiceTotal,1) AS ConvertToVarchar
FROM Invoices;
/*
CastAsDecimal                           CastAsVarchar                  ConvertToDecimal                        ConvertToVarchar
--------------------------------------- ------------------------------ --------------------------------------- ------------------------------
3813.33                                 3813.33                        3813.33                                 3,813.33
40.20                                   40.20                          40.20                                   40.20
138.75                                  138.75                         138.75                                  138.75
144.70                                  144.70                         144.70                                  144.70
15.50                                   15.50                          15.50                                   15.50
*/

---------------------------------------------------------------------------------------------------------------------------------------------
/*
		2.Write a SELECT statement that returns four columns based on the InvoiceDate column of the Invoices table:
		Use the CAST function to return the first column as data type varchar.
		Use the CONVERT function to return the second and third columns as a varchar, using style 1 and style 10, respectively.
		Use the CAST function to return the fourth column as data type real.
*/
SELECT CAST(InvoiceDate AS varchar) AS CastAsVarchar,
       CONVERT(varchar,InvoiceDate,1) AS ConvertToStyle1,
       CONVERT(varchar,InvoiceDate,10) AS ConvertToStyle10,
       CAST(InvoiceDate AS real) AS ConvertToReal
FROM Invoices;
/*
CastAsVarchar                  ConvertToStyle1                ConvertToStyle10               ConvertToReal
------------------------------ ------------------------------ ------------------------------ -------------
Apr  2 2016 12:00AM            04/02/16                       04-02-16                       42460
Apr  1 2016 12:00AM            04/01/16                       04-01-16                       42459
Mar 31 2016 12:00AM            03/31/16                       03-31-16                       42458
Mar 30 2016 12:00AM            03/30/16                       03-30-16                       42457
Mar 28 2016 12:00AM            03/28/16                       03-28-16                       42455
*/


---------------------------------------------------------------------------------------------------------------------------------------------
/*
		3.Write a SELECT statement that returns two columns based on the Vendors table. 
		The first column, Contact, is the vendor contact name in this format: first name followed by last initial (for example, “John S.”) 
		The second column, Phone, is the VendorPhone column without the area code. 
		Only return rows for those vendors in the 559 area code. Sort the result set by first name, then last name.
*/

SELECT VendorContactFName + ' ' + SUBSTRING(VendorContactLName, 1,1)+'.' AS [Contact],
		SUBSTRING(VendorPhone,7,8) AS [Phone]
		--VendorPhone AS [Phone]
FROM Vendors
WHERE VendorPhone LIKE '(559)%'
ORDER BY VendorContactFName, VendorContactLName;
/*
Contact                                               Phone
----------------------------------------------------- --------
Alexandro A.                                          555-2993
Anders R.                                             555-5570
Anne B.                                               555-7900
Bill L.                                               555-9375
Caitlin J.                                            555-2420
*/


---------------------------------------------------------------------------------------------------------------------------------------------
/*
		4.Write a SELECT statement that returns the InvoiceNumber and balance due for every invoice with a non-zero balance 
		and an InvoiceDueDate that’s less than 30 days from today.
		
		***Side Note From Blake*** 
		There are no InvoiceDueDate's that are "less than 30 days from today", They are all within the year of 2016.
*/
SELECT Invoices.InvoiceNumber AS [Invoice Number],
		Invoices.InvoiceTotal AS [Balance],
		Invoices.InvoiceDueDate AS [Due Date]
FROM Invoices
WHERE Invoices.InvoiceTotal > 0
/*
Invoice Number                                     Balance               Due Date
-------------------------------------------------- --------------------- -----------------------
989319-457                                         3813.33               2016-01-08 00:00:00
263253241                                          40.20                 2016-01-10 00:00:00
963253234                                          138.75                2016-01-13 00:00:00
2-000-2993                                         144.70                2016-01-16 00:00:00
963253251                                          15.50                 2016-01-16 00:00:00
963253261                                          42.75                 2016-01-16 00:00:00
*/
	

---------------------------------------------------------------------------------------------------------------------------------------------
/*
		5.Modify the search expression for InvoiceDueDate from the solution for exercise 4. 
		Rather than 30 days from today, return invoices due before the last day of the current month.

		***Side Note From Blake*** 
		There are no InvoiceDueDate's that are "less than 30 days from today", They are all within the year of 2016.
*/
SELECT Invoices.InvoiceNumber AS [Invoice Number],
		Invoices.InvoiceTotal AS [Balance],
		Invoices.InvoiceDueDate AS [Due Date]
FROM Invoices
WHERE Invoices.InvoiceTotal > 0
/*
Invoice Number                                     Balance               Due Date
-------------------------------------------------- --------------------- -----------------------
989319-457                                         3813.33               2016-01-08 00:00:00
263253241                                          40.20                 2016-01-10 00:00:00
963253234                                          138.75                2016-01-13 00:00:00
2-000-2993                                         144.70                2016-01-16 00:00:00
963253251                                          15.50                 2016-01-16 00:00:00
963253261                                          42.75                 2016-01-16 00:00:00
*/


---------------------------------------------------------------------------------------------------------------------------------------------
/*
		6.Write a summary query WITH CUBE that returns LineItemSum (which is the sum of InvoiceLineItemAmount) 
		grouped by Account (an alias for AccountDescription) and State (an alias for VendorState). 
		Use the CASE and GROUPING function to substitute the literal value “*ALL*” for the summary rows with null values.
*/

-------------- I need more instruction on "WITH CUBE" usage with the "CASE" and "GROUPING" function
-------------- I still can't get it to work and can't spend another day stuck on this chapter 

---------------------------------------------------------------------------------------------------------------------------------------------
/*
		7.(If you have access to the Examples database) 
		Modify the third SELECT statement shown in figure 8-11 of the text to return a middle name, if present. 
		Add a third column, Middle, which is null if no middle name is present.
*/
USE Examples

-------------- There is no figure 8-11 of any text that I can find, either in the textbook or on the Lab Assignment 