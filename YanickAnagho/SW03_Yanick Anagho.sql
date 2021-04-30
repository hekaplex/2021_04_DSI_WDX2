USE AP
GO

/*
	2021-04-DSI-WDX2
	NAME: Yanick A. Anagho
	EXERCISE: SW03-How to retrieve data from a single table
*/



/*	1
	Write a SELECT statement that returns three columns from 
	the Vendors table: VendorContactFName, VendorContactLName, 
	and VendorName. Sort the result set by last name, then by 
	first name.
*/

	USE AP
	GO

	SELECT VendorContactFName, VendorContactLName, VendorName
	FROM vendors
	ORDER BY VendorContactLName, VendorContactFName
	/*
	First 10 rows
	================================================================================
	VendorContactFName	VendorContactLName	VendorName
	Thom			    Aaronsen		    Dristas Groom & McCormick
	Joan			    Aileen			    Internal Revenue Service
	Francesco		    Alberto			    US Postal Service
	Alexandro		    Alexis			    Yale Industrial Trucks-Fresno
	Zev				    Alondra			    Leslie Company
	Nashalie		    Angelica		    American Booksellers Assoc
	Troy			    Antavius		    Courier Companies, Inc
	Kaitlyn			    Anthoni			    Pacific Gas & Electric
	Trisha			    Anum			    Lou Gentile's Flower Basket
	Robert			    Aranovitch		    Pollstar
	================================================================================
	*/

/*	2
	Write a SELECT statement that returns four columns from the 
	Invoices table, named Number, Total, Credits, and Balance:
		Number	Column alias for the InvoiceNumber column 
		Total	Column alias for the InvoiceTotal column
		Credits	Sum of the PaymentTotal and CreditTotal columns
		Balance	InvoiceTotal minus the sum of PaymentTotal and CreditTotal

	Use the AS keyword to assign column aliases.
	Use the = assignment operator to assign column aliases.

*/
	USE AP
    GO

	SELECT InvoiceNumber as Number, InvoiceTotal as Total, 
		   (PaymentTotal + CreditTotal) as Credits,
		   Balance = (InvoiceTotal - (PaymentTotal + CreditTotal))
	FROM invoices

	/*
	10 rows
	================================================================================
	Number		Total	Credits	Balance
	989319-457	3813.33	3813.33	0.00
	263253241	40.20	40.20	0.00
	963253234	138.75	138.75	0.00
	2-000-2993	144.70	144.70	0.00
	963253251	15.50	15.50	0.00
	963253261	42.75	42.75	0.00
	963253237	172.50	172.50	0.00
	125520-1	95.00	95.00	0.00
	97/488		601.95	601.95	0.00
	263253250	42.67	42.67	0.00
	================================================================================
	*/

/*	3
	Write a SELECT statement that returns one column from the Vendors 
	table named Full Name. Create this column from the VendorContactFName
	and VendorContactLName columns. Format it as follows: 
	last name, comma, first name (for example, “Doe, John”). 
	Sort the result set by last name, then by first name.
*/
	USE AP
	GO

	SELECT VendorContactLName + ', ' + VendorContactFName AS [Full Name]
	FROM vendors
	ORDER BY VendorContactLName, VendorContactFName
	/*
	10 rows
	================================================================================
	Full Name
	Aaronsen, Thom
	Aileen, Joan
	Alberto, Francesco
	Alexis, Alexandro
	Alondra, Zev
	Angelica, Nashalie
	Antavius, Troy
	Anthoni, Kaitlyn
	Anum, Trisha
	Aranovitch, Robert
	================================================================================
	*/

/*	4
	Write a SELECT statement that returns three columns:
		InvoiceTotal	From the Invoices table
		10%	 10% of the value of InvoiceTotal 
		Plus 10%	The value of InvoiceTotal plus 10%
	(For example, if InvoiceTotal is 100.0000, 10% is 10.0000, and Plus 10% is 110.0000.) 
	Only return those rows with a balance due greater than 1000. 
	Sort the result set by InvoiceTotal, with the largest invoice first.
*/
	USE AP
	GO

	SELECT InvoiceTotal, (InvoiceTotal * .10) as [10%], (InvoiceTotal * 1.10) as [Plus 10%]
	FROM invoices
	WHERE (InvoiceTotal - (PaymentTotal + CreditTotal)) > 1000
	ORDER BY InvoiceTotal DESC
	/*
	rows
	================================================================================
	InvoiceTotal	10%			Plus 10%
	20551.18	    2055.118000	22606.298000
	10976.06	    1097.606000	12073.666000
	================================================================================
	*/

/*	5
	Modify the solution to exercise 2a to filter for invoices with an 
	InvoiceTotal that’s greater than or equal to $500 but less than 
	or equal to $10,000.
*/
	USE AP
    GO

	SELECT InvoiceNumber as Number, InvoiceTotal as Total, 
		   (PaymentTotal + CreditTotal) as Credits,
		   Balance = (InvoiceTotal - (PaymentTotal + CreditTotal))
	FROM invoices
	WHERE InvoiceTotal BETWEEN 500 AND 10000

	/*
	10 rows
	================================================================================
	Number			Total	Credits	Balance
	989319-457		3813.33	3813.33	0.00
	97/488			601.95	601.95	0.00
	I77271-O01		662.00	662.00	0.00
	P02-88D77S7		856.92	856.92	0.00
	10843			4901.26	4901.26	0.00
	77290			1750.00	1750.00	0.00
	P02-3772		7125.34	7125.34	0.00
	97/486			953.10	953.10	0.00
	RTR-72-3662-X	1600.00	1600.00	0.00
	97/465			565.15	565.15	0.00
	================================================================================
*/

/*	6
	Modify the solution to exercise 3 to filter for contacts whose
	last name begins with the letter A, B, C, or E.
*/
	USE AP
	GO

	SELECT VendorContactLName + ', ' + VendorContactFName AS [Full Name]
	FROM vendors
	WHERE VendorContactLName LIKE 'A%' OR 
		  VendorContactLName LIKE 'B%' OR
		  VendorContactLName LIKE 'C%' OR
		  VendorContactLName LIKE 'E%' 
	ORDER BY VendorContactLName, VendorContactFName
	/*
	rows
	================================================================================
	Full Name
	Aaronsen, Thom
	Aileen, Joan
	Alberto, Francesco
	Alexis, Alexandro
	Alondra, Zev
	Angelica, Nashalie
	Antavius, Troy
	Anthoni, Kaitlyn
	Anum, Trisha
	Aranovitch, Robert
	Armando, Jan
	Arodondo, Cesar
	Articunia, Mercedez
	Aryn, Leroy
	Baylee, Dakota
	Beauregard, Violet
	Bernard, Lucy
	Bernardo, Brittnee
	Blanca, Korah
	Bluzinski, Rachael
	Bradlee, Daniel
	Bragg, Walter
	Braydon, Anne
	Brenton, Kila
	Brooklynn, Keely
	Bucket, Charlie
	Camron, Trentin
	Carrollton, Priscilla
	Carson, Julian
	Chaddick, Derek
	Cheyenne, Kaylea
	Church, Charlie
	Clifford, Jillian
	Colette, Dusty
	Colton, Leah
	Edgardo, Salina
	Eliana, Nikolas
	Elmert, Ron
	Essence, Marjorie
	Eulalia, Kelsey
	Evan, Emily
	================================================================================
	*/

/*	7
	Write a SELECT statement that determines whether the PaymentDate 
	column of the Invoices table has any invalid values. To be valid, 
	PaymentDate must be a null value if there’s a balance due and a non-null 
	value if there’s no balance due. Code a compound condition in the WHERE 
	clause that tests for these conditions.
*/
	USE AP
	GO
	SELECT *
	FROM invoices
	WHERE (InvoiceTotal - (PaymentTotal + CreditTotal)) = 0 AND PaymentDate IS NOT NULL
		  OR (PaymentDate IS NULL AND (InvoiceTotal - (PaymentTotal + CreditTotal)) > 0.0)
	/*
	rows
	========================================================================================================================================================
	InvoiceID	VendorID	InvoiceNumber	InvoiceDate			InvoiceTotal	PaymentTotal	CreditTotal	TermsID	InvoiceDueDate		PaymentDate
	1			122			989319-457		2015-12-08 00:00:00	3813.33			3813.33			0.00		3		2016-01-08 00:00:00	2016-01-07 00:00:00
	2			123			263253241		2015-12-10 00:00:00	40.20			40.20			0.00		3		2016-01-10 00:00:00	2016-01-14 00:00:00
	3			123			963253234		2015-12-13 00:00:00	138.75			138.75			0.00		3		2016-01-13 00:00:00	2016-01-09 00:00:00
	4			123			2-000-2993		2015-12-16 00:00:00	144.70			144.70			0.00		3		2016-01-16 00:00:00	2016-01-12 00:00:00
	5			123			963253251		2015-12-16 00:00:00	15.50			15.50			0.00		3		2016-01-16 00:00:00	2016-01-11 00:00:00
	6			123			963253261		2015-12-16 00:00:00	42.75			42.75			0.00		3		2016-01-16 00:00:00	2016-01-21 00:00:00
	7			123			963253237		2015-12-21 00:00:00	172.50			172.50			0.00		3		2016-01-21 00:00:00	2016-01-22 00:00:00
	8			89			125520-1		2015-12-24 00:00:00	95.00			95.00			0.00		1		2016-01-04 00:00:00	2016-01-01 00:00:00
	9			121			97/488			2015-12-24 00:00:00	601.95			601.95			0.00		3		2016-01-24 00:00:00	2016-01-21 00:00:00
	10			123			263253250		2015-12-24 00:00:00	42.67			42.67			0.00		3		2016-01-24 00:00:00	2016-01-22 00:00:00
	========================================================================================================================================================
	*/





