USE AP;
GO

/*
1.	Write a SELECT statement that returns all columns from the Vendors table inner- joined with the Invoices table.
*/

/*
SELECT *
FROM Vendors JOIN Invoices
  ON Vendors.VendorID = Invoices.VendorID;


  VendorID    VendorName                                         VendorAddress1                                     VendorAddress2                                     VendorCity                                         VendorState VendorZipCode        VendorPhone                                        VendorContactLName                                 VendorContactFName                                 DefaultTermsID DefaultAccountNo InvoiceID   VendorID    InvoiceNumber                                      InvoiceDate             InvoiceTotal          PaymentTotal          CreditTotal           TermsID     InvoiceDueDate          PaymentDate
----------- -------------------------------------------------- -------------------------------------------------- -------------------------------------------------- -------------------------------------------------- ----------- -------------------- -------------------------------------------------- -------------------------------------------------- -------------------------------------------------- -------------- ---------------- ----------- ----------- -------------------------------------------------- ----------------------- --------------------- --------------------- --------------------- ----------- ----------------------- -----------------------
34          IBM                                                PO Box 61000                                       NULL                                               San Francisco                                      CA          94161                (800) 555-4426                                     Camron                                             Trentin                                            1              160              19          34          QP58872                                            2016-01-07 00:00:00     116.54                116.54                0.00                  1           2016-01-17 00:00:00     2016-01-19 00:00:00
34          IBM                                                PO Box 61000                                       NULL                                               San Francisco                                      CA          94161                (800) 555-4426                                     Camron                                             Trentin                                            1              160              52          34          Q545443                                            2016-02-09 00:00:00     1083.58               1083.58               0.00                  1           2016-02-19 00:00:00     2016-02-23 00:00:00
37          Blue Cross                                         PO Box 9061                                        NULL                                               Oxnard                                             CA          93031                (800) 555-0912                                     Eliana                                             Nikolas                                            3              510              46          37          547481328                                          2016-02-03 00:00:00     224.00                224.00                0.00                  3           2016-03-03 00:00:00     2016-03-04 00:00:00
37          Blue Cross                                         PO Box 9061                                        NULL                                               Oxnard                                             CA          93031                (800) 555-0912                                     Eliana                                             Nikolas                                            3              510              50          37          547479217                                          2016-02-07 00:00:00     116.00                116.00                0.00                  3           2016-03-07 00:00:00     2016-03-07 00:00:00
37          Blue Cross                                         PO Box 9061                                        NULL                                               Oxnard                                             CA          93031                (800) 555-0912                                     Eliana                                             Nikolas                                            3              510              113         37          547480102                                          2016-04-01 00:00:00     224.00                0.00                  0.00                  3           2016-04-30 00:00:00     NULL

*/
----------------------------------------------------------------------------------------------------------------------



/*
2.	Write a SELECT statement that returns four columns: VendorName	From the Vendors table InvoiceNumber
From the Invoices table InvoiceDateFrom the Invoices table
Balance	InvoiceTotal minus the sum of PaymentTotal and CreditTotal
The result set should have one row for each invoice with a non-zero balance.
Sort the result set by VendorName in ascending order.
*/


SELECT VendorName, InvoiceNumber, InvoiceDate,
       InvoiceTotal - PaymentTotal - CreditTotal AS Balance
FROM Vendors JOIN Invoices
  ON Vendors.VendorID = Invoices.VendorID
WHERE InvoiceTotal - PaymentTotal - CreditTotal > 0
ORDER BY VendorName;

/*
VendorName                                         InvoiceNumber                                      InvoiceDate             Balance
-------------------------------------------------- -------------------------------------------------- ----------------------- ---------------------
Blue Cross                                         547480102                                          2016-04-01 00:00:00     224.00
Cardinal Business Media, Inc.                      134116                                             2016-03-28 00:00:00     90.36
Data Reproductions Corp                            39104                                              2016-03-10 00:00:00     85.31
Federal Express Corporation                        963253264                                          2016-03-18 00:00:00     52.25
Federal Express Corporation                        263253268                                          2016-03-21 00:00:00     59.97
Federal Express Corporation                        263253270                                          2016-03-22 00:00:00     67.92
Federal Express Corporation                        263253273                                          2016-03-22 00:00:00     30.75
Ford Motor Credit Company                          9982771                                            2016-03-24 00:00:00     503.20
Ingram                                             31361833                                           2016-03-21 00:00:00     579.42
Malloy Lithographing Inc                           0-2436                                             2016-03-31 00:00:00     10976.06
Malloy Lithographing Inc                           P-0608                                             2016-03-23 00:00:00     19351.18
*/ 

----------------------------------------------------------------------------------------------------------------------------------------------------



/*
3.	Write a SELECT statement that returns three columns: VendorName	From the Vendors table
DefaultAccountNo	From the Vendors table AccountDescription	From the GLAccounts table
The result set should have one row for each vendor, with the account number and account 
description for that vendor’s default account number. Sort the result set by AccountDescription, 
then by VendorName.
*/

SELECT VendorName, DefaultAccountNo, AccountDescription
FROM Vendors JOIN GLAccounts
  ON Vendors.DefaultAccountNo = GLAccounts.AccountNo
ORDER BY AccountDescription, VendorName;

/*
VendorName                                         DefaultAccountNo AccountDescription
-------------------------------------------------- ---------------- --------------------------------------------------
Dristas Groom & McCormick                          591              Accounting
DMV Renewal                                        568              Auto License Fee
Newbrige Book Clubs                                394              Book Club Royalties
Bertelsmann Industry Svcs. Inc                     400              Book Printing Costs
Courier Companies, Inc                             400              Book Printing Costs
Crown Printing                                     400              Book Printing Costs
Data Reproductions Corp                            400              Book Printing Costs
Diversified Printing & Pub                         400              Book Printing Costs
Malloy Lithographing Inc                           400              Book Printing Costs
Fresno Photoengraving Company                      403              Book Production Costs
Register of Copyrights                             403              Book Production Costs
Shields Design                                     403              Book Production Costs
Zylka Design                                       403              Book Production Costs
*/
--------------------------------------------------------------------------------------------------------------------------------------
/*
4.	Generate the same result set described in exercise 2, but use the implicit join syntax.
*/


SELECT VendorName, InvoiceNumber, InvoiceDate,
       InvoiceTotal - PaymentTotal - CreditTotal AS Balance
FROM Vendors, Invoices
WHERE Vendors.VendorID = Invoices.VendorID
  AND InvoiceTotal - PaymentTotal - CreditTotal > 0
ORDER BY VendorName;

/*
VendorName                                         InvoiceNumber                                      InvoiceDate             Balance
-------------------------------------------------- -------------------------------------------------- ----------------------- ---------------------
Blue Cross                                         547480102                                          2016-04-01 00:00:00     224.00
Cardinal Business Media, Inc.                      134116                                             2016-03-28 00:00:00     90.36
Data Reproductions Corp                            39104                                              2016-03-10 00:00:00     85.31
Federal Express Corporation                        963253264                                          2016-03-18 00:00:00     52.25
Federal Express Corporation                        263253268                                          2016-03-21 00:00:00     59.97
Federal Express Corporation                        263253270                                          2016-03-22 00:00:00     67.92
Federal Express Corporation                        263253273                                          2016-03-22 00:00:00     30.75
Ford Motor Credit Company                          9982771                                            2016-03-24 00:00:00     503.20
Ingram                                             31361833                                           2016-03-21 00:00:00     579.42
Malloy Lithographing Inc                           0-2436                                             2016-03-31 00:00:00     10976.06
Malloy Lithographing Inc                           P-0608                                             2016-03-23 00:00:00     19351.18
*/
--------------------------------------------------------------------------------------------------------------------------------------------

/*
5.	Write a SELECT statement that returns five columns from three tables, all using column aliases:
Vendor	VendorName column Date	InvoiceDate column Number	InvoiceNumber column #	InvoiceSequence column
LineItem	InvoiceLineItemAmount column Assign the following correlation names to the tables:
Vend	Vendors table
Inv	Invoices table LineItem	InvoiceLineItems table
Sort the final result set by Vendor, Date, Number, and #.
*/


SELECT VendorName AS Vendor, InvoiceDate AS Date,
       InvoiceNumber AS Number, InvoiceSequence AS [#],
       InvoiceLineItemAmount AS LineItem
FROM Vendors AS v JOIN Invoices AS i
  ON v.VendorID = i.VendorID
 JOIN InvoiceLineItems AS li
   ON i.InvoiceID = li.InvoiceID
ORDER BY Vendor, Date, Number, [#];


/*

Vendor                                             Date                    Number                                             #      LineItem
-------------------------------------------------- ----------------------- -------------------------------------------------- ------ ---------------------
Abbey Office Furnishings                           2016-03-05 00:00:00     203339-13                                          1      17.50
Bertelsmann Industry Svcs. Inc                     2016-02-18 00:00:00     509786                                             1      6940.25
Blue Cross                                         2016-02-03 00:00:00     547481328                                          1      224.00
Blue Cross                                         2016-02-07 00:00:00     547479217                                          1      116.00
Blue Cross                                         2016-04-01 00:00:00     547480102                                          1      224.00
*/
------------------------------------------------------------------------------------------------------------------------
/*
6.	Write a SELECT statement that returns three columns: VendorID From the Vendors table
VendorName	From the Vendors table
Name	A concatenation of VendorContactFName and
VendorContactLName, with a space in between
*/

SELECT DISTINCT v1.VendorID, v1.VendorName,
       v1.VendorContactFName + ' ' + v1.VendorContactLName AS Name
FROM Vendors AS v1 JOIN Vendors AS v2
ON (v1.VendorID <> v2.VendorID) AND
   (v1.VendorContactFName = v2.VendorContactFName)
ORDER BY Name;

/*
VendorID    VendorName                                         Name
----------- -------------------------------------------------- -----------------------------------------------------------------------------------------------------
123         Federal Express Corporation                        Charlie Bucket
120         Dataforms/West                                     Charlie Church
118         Unocal                                             Rachael Bluzinski
73          Executive Office Products                          Rachael Danielson
113         Pollstar                                           Robert Aranovitch
81          Wang Laboratories, Inc.                            Robert Kapil

*/

-----------------------------------------------------------------------------------------------------------------------------------------------------
/*
7.	Write a SELECT statement that returns two columns from the GLAccounts table: AccountNo and AccountDescription. 
The result set should have one row for each account number that has never been used. Sort the final result set by AccountNo.
Hint: Use an outer join to the InvoiceLineItems table.
*/



SELECT GLAccounts.AccountNo, AccountDescription
FROM GLAccounts LEFT JOIN InvoiceLineItems
  ON GLAccounts.AccountNo = InvoiceLineItems.AccountNo
WHERE InvoiceLineItems.AccountNo IS NULL
ORDER BY GLAccounts.AccountNo;


/*
AccountNo   AccountDescription
----------- --------------------------------------------------
100         Cash
110         Accounts Receivable
120         Book Inventory
162         Capitalized Lease
167         Software
181         Book Development
200         Accounts Payable
205         Royalties Payable
*/
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
8.	Use the UNION operator to generate a result set consisting of two columns from the Vendors table: VendorName and VendorState.
If the vendor is in California, the VendorState value should be “CA”; otherwise, the VendorState value should be “Outside CA.”
Sort the final result set by VendorName. 
*/

 SELECT VendorName, VendorState
  FROM Vendors
  WHERE VendorState = 'CA'
UNION
  SELECT VendorName, 'Outside CA'
  FROM Vendors
  WHERE VendorState <> 'CA'
ORDER BY VendorName;


/*
VendorName                                         VendorState
-------------------------------------------------- -----------
Abbey Office Furnishings                           CA
American Booksellers Assoc                         Outside CA
American Express                                   CA
ASC Signs                                          CA
Ascom Hasler Mailing Systems                       Outside CA
AT&T                                               Outside CA
Aztek Label                                        CA
*/
-----------------------------------------------------------------------------------------------------------------------------