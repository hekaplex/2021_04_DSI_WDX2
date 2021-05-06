/*
1. Write a SELECT statement that returns three columns from the Vendors table: VendorContactFName, VendorContactLName, and VendorName. Sort the result set by last name, then by first name. 
*/

SELECT VendorContactFName, VendorContactLName, VendorName
FROM Vendors
ORDER BY VendorContactLName, VendorContactFName;


/*
Jamari                                             Raven                                              Vision Envelope & Printing
Abe                                                Regging                                            Malloy Lithographing Inc
Carlee                                             Rodolfo                                            Reiter's Scientific & Pro Books
Anders                                             Rohansen                                           California Business Machines
Jaime                                              Ronaldsen                                          Zylka Design
*/


/*
2. Write a SELECT statement that returns four columns from the Invoices table, named Number, Total, Credits, and Balance: 

Number	Column alias for the InvoiceNumber column Total	Column alias for the InvoiceTotal column 

Credits	Sum of the PaymentTotal and CreditTotal columns 

Balance	InvoiceTotal minus the sum of PaymentTotal and CreditTotal 

Use the AS keyword to assign column aliases. 

Use the = assignment operator to assign column aliases. 
*/

/*2A*/

SELECT InvoiceNumber AS Number,
       InvoiceTotal AS Total,
       PaymentTotal + CreditTotal AS Credits,
       InvoiceTotal - (PaymentTotal + CreditTotal) AS Balance
FROM Invoices;

/*
Number                                             Total                 Credits               Balance
-------------------------------------------------- --------------------- --------------------- ---------------------
989319-457                                         3813.33               3813.33               0.00
263253241                                          40.20                 40.20                 0.00
963253234                                          138.75                138.75                0.00
2-000-2993                                         144.70                144.70                0.00
963253251                                          15.50                 15.50                 0.00
*/

/*2B*/

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

/*
3. Write a SELECT statement that returns one column from the Vendors table named Full Name. Create this column from the VendorContactFName and VendorContactLName columns. Format it as follows: last name, comma, first name (for example, “Doe, John”). Sort the result set by last name, then by first name. 
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
Alondra, Zev
Angelica, Nashalie
Antavius, Troy
Anthoni, Kaitlyn
Anum, Trisha
Aranovitch, Robert
Armando, Jan
*/


/*
4. Write a SELECT statement that returns three columns: InvoiceTotal	From the Invoices table 

10%	10% of the value of InvoiceTotal Plus 10%	The value of InvoiceTotal plus 10% 

(For example, if InvoiceTotal is 100.0000, 10% is 10.0000, and Plus 10% is 110.0000.) 
Only return those rows with a balance due greater than 1000. Sort the result set by InvoiceTotal, with the largest invoice first. 
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

(2 rows affected)


Completion time: 2021-05-02T14:30:58.2769465-05:00
*/


/*
Modify the solution to exercise 2a to filter for invoices with an InvoiceTotal that’s greater than or equal to $500 but less than or equal to $10,000. 
*/


SELECT InvoiceNumber AS Number,
       InvoiceTotal AS Total,
       PaymentTotal + CreditTotal AS Credits,
       InvoiceTotal - (PaymentTotal + CreditTotal) AS Balance
FROM Invoices
WHERE InvoiceTotal BETWEEN 500 AND 10000;
--Also acceptable:
--WHERE InvoiceTotal >= 500 AND InvoiceTotal <= 10000;



/*
Number                                             Total                 Credits               Balance
-------------------------------------------------- --------------------- --------------------- ---------------------
989319-457                                         3813.33               3813.33               0.00
97/488                                             601.95                601.95                0.00
I77271-O01                                         662.00                662.00                0.00
P02-88D77S7                                        856.92                856.92                0.00
10843                                              4901.26               4901.26               0.00
77290                                              1750.00               1750.00               0.00
P02-3772                                           7125.34               7125.34               0.00
97/486                                             953.10                953.10                0.00
RTR-72-3662-X                                      1600.00               1600.00               0.00
97/465                                             565.15                565.15                0.00
*/


/*
6.Modify the solution to exercise 3 to filter for contacts whose last name begins with the letter A, B, C, or E. 
*/



SELECT VendorContactLName + ', ' + VendorContactFName AS [Full Name]
FROM Vendors
WHERE VendorContactLName LIKE '[A-C,E]%'
--Also acceptable:
--WHERE VendorContactLName LIKE '[A-E]%' AND
--      VendorContactLName NOT LIKE 'D%'
ORDER BY VendorContactLName, VendorContactFName;


/*
Full Name
------------------------------------------------------------------------------------------------------
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
*/


/*
Write a SELECT statement that determines whether the PaymentDate column of the Invoices table has any invalid values. 
To be valid, PaymentDate must be a null value if there’s a balance due and a non-null value if there’s no balance due.
Code a compound condition in the WHERE clause that tests for these conditions. 
*/


SELECT *
FROM Invoices
WHERE ((InvoiceTotal - PaymentTotal - CreditTotal <= 0) AND
      PaymentDate IS NULL) OR
      ((InvoiceTotal - PaymentTotal - CreditTotal > 0) AND
      PaymentDate IS NOT NULL);

	  /*
	  InvoiceID   VendorID    InvoiceNumber                                      InvoiceDate             InvoiceTotal          PaymentTotal          CreditTotal           TermsID     InvoiceDueDate          PaymentDate
----------- ----------- -------------------------------------------------- ----------------------- --------------------- --------------------- --------------------- ----------- ----------------------- -----------------------

(0 rows affected)
*/
