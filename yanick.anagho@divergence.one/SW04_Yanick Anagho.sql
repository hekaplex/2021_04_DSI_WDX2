

/*
	2021-04-DSI-WDX2
	NAME: Yanick A. Anagho
	EXERCISE: SW04-How to retrieve data from Two or more tables
*/


/*
1.	Write a SELECT statement that returns all columns from the Vendors 
	table inner- joined with the Invoices table.
*/

	USE AP
	GO

	SELECT *
	FROM Vendors V
	INNER JOIN  Invoices I
	ON V.VendorID = I.VendorID
	/*
	First 10 rows
	================================================================================
	VendorID    VendorName                                         VendorAddress1                                     VendorAddress2                                     VendorCity                                         VendorState VendorZipCode        VendorPhone                                        VendorContactLName                                 VendorContactFName                                 DefaultTermsID DefaultAccountNo InvoiceID   VendorID    InvoiceNumber                                      InvoiceDate             InvoiceTotal          PaymentTotal          CreditTotal           TermsID     InvoiceDueDate          PaymentDate
	----------- -------------------------------------------------- -------------------------------------------------- -------------------------------------------------- -------------------------------------------------- ----------- -------------------- -------------------------------------------------- -------------------------------------------------- -------------------------------------------------- -------------- ---------------- ----------- ----------- -------------------------------------------------- ----------------------- --------------------- --------------------- --------------------- ----------- ----------------------- -----------------------
	34          IBM                                                PO Box 61000                                       NULL                                               San Francisco                                      CA          94161                (800) 555-4426                                     Camron                                             Trentin                                            1              160              19          34          QP58872                                            2016-01-07 00:00:00     116.54                116.54                0.00                  1           2016-01-17 00:00:00     2016-01-19 00:00:00
	34          IBM                                                PO Box 61000                                       NULL                                               San Francisco                                      CA          94161                (800) 555-4426                                     Camron                                             Trentin                                            1              160              52          34          Q545443                                            2016-02-09 00:00:00     1083.58               1083.58               0.00                  1           2016-02-19 00:00:00     2016-02-23 00:00:00
	37          Blue Cross                                         PO Box 9061                                        NULL                                               Oxnard                                             CA          93031                (800) 555-0912                                     Eliana                                             Nikolas                                            3              510              46          37          547481328                                          2016-02-03 00:00:00     224.00                224.00                0.00                  3           2016-03-03 00:00:00     2016-03-04 00:00:00
	37          Blue Cross                                         PO Box 9061                                        NULL                                               Oxnard                                             CA          93031                (800) 555-0912                                     Eliana                                             Nikolas                                            3              510              50          37          547479217                                          2016-02-07 00:00:00     116.00                116.00                0.00                  3           2016-03-07 00:00:00     2016-03-07 00:00:00
	37          Blue Cross                                         PO Box 9061                                        NULL                                               Oxnard                                             CA          93031                (800) 555-0912                                     Eliana                                             Nikolas                                            3              510              113         37          547480102                                          2016-04-01 00:00:00     224.00                0.00                  0.00                  3           2016-04-30 00:00:00     NULL
	48          Fresno County Tax Collector                        PO Box 1192                                        NULL                                               Fresno                                             CA          93715                (559) 555-3482                                     Brenton                                            Kila                                               3              574              15          48          P02-88D77S7                                        2016-01-03 00:00:00     856.92                856.92                0.00                  3           2016-02-02 00:00:00     2016-01-30 00:00:00
	72          Data Reproductions Corp                            4545 Glenmeade Lane                                NULL                                               Auburn Hills                                       MI          48326                (810) 555-3700                                     Arodondo                                           Cesar                                              3              400              43          72          40318                                              2016-02-01 00:00:00     21842.00              21842.00              0.00                  3           2016-03-01 00:00:00     2016-02-28 00:00:00
	72          Data Reproductions Corp                            4545 Glenmeade Lane                                NULL                                               Auburn Hills                                       MI          48326                (810) 555-3700                                     Arodondo                                           Cesar                                              3              400              89          72          39104                                              2016-03-10 00:00:00     85.31                 0.00                  0.00                  3           2016-04-09 00:00:00     NULL
	80          Cardinal Business Media, Inc.                      P O Box 7247-7844                                  NULL                                               Philadelphia                                       PA          19170                (215) 555-1500                                     Eulalia                                            Kelsey                                             2              540              110         80          134116                                             2016-03-28 00:00:00     90.36                 0.00                  0.00                  2           2016-04-17 00:00:00     NULL
	80          Cardinal Business Media, Inc.                      P O Box 7247-7844                                  NULL                                               Philadelphia                                       PA          19170                (215) 555-1500                                     Eulalia                                            Kelsey                                             2              540              69          80          133560                                             2016-02-22 00:00:00     175.00                175.00                0.00                  2           2016-03-12 00:00:00     2016-03-16 00:00:00
	================================================================================
	*/

/*
2.	Write a SELECT statement that returns four columns: 
	VendorName	From the Vendors table 
	InvoiceNumber From the Invoices table 
	InvoiceDate From the Invoices table
	Balance	InvoiceTotal minus the sum of PaymentTotal and CreditTotal
	The result set should have one row for each invoice with a non-zero balance. 
	Sort the result set by VendorName in ascending order.

*/

	USE AP
	GO

	SELECT VendorName, InvoiceNumber, InvoiceDate, 
		InvoiceTotal - (PaymentTotal + CreditTotal) as Balance 
	FROM Vendors V
	INNER JOIN  Invoices I
	ON V.VendorID = I.VendorID
	WHERE InvoiceTotal - (PaymentTotal + CreditTotal) != 0
	ORDER BY VendorName
	/*
	rows
	================================================================================
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
	================================================================================
	*/

/*
3.	Write a SELECT statement that returns three columns: 
		VendorName	From the Vendors table 
		DefaultAccountNo	From the Vendors table 
		AccountDescription	From the GLAccounts table
	The result set should have one row for each vendor, with 
	the account number and account description for that 
	vendor’s default account number. Sort the result set by 
	AccountDescription, then by VendorName.
*/

	USE AP
	GO

	SELECT VendorName, DefaultAccountNo, AccountDescription
	FROM Vendors V
	INNER JOIN GLAccounts G
	ON V.DefaultAccountNo = G.AccountNo
	ORDER BY AccountDescription, VendorName
	/*
	First 10 rows
	================================================================================
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
	================================================================================
	*/

/*
4.	Generate the same result set described in exercise 2, 
	but use the implicit join syntax.
*/

	USE AP
	GO

	SELECT VendorName, InvoiceNumber, InvoiceDate, 
		InvoiceTotal - (PaymentTotal + CreditTotal) as Balance 
	FROM Vendors V, Invoices I
	WHERE V.VendorID = I.VendorID
	AND InvoiceTotal - (PaymentTotal + CreditTotal) != 0
	ORDER BY VendorName

	/*
	rows
	================================================================================
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
	================================================================================
	*/

/*
5.	Write a SELECT statement that returns five columns from three tables, all using column aliases:
		Vendor	VendorName column 
		Date	InvoiceDate column 
		Number	InvoiceNumber column 
		#	InvoiceSequence column
		LineItem	InvoiceLineItemAmount column 
	Assign the following correlation names to the tables:
		Vend	Vendors table
		Inv	Invoices table 
		LineItem	InvoiceLineItems table
	Sort the final result set by Vendor, Date, Number, and #.
*/

	USE AP
	GO

	SELECT VendorName AS Vendor, InvoiceDate as [Date], 
		   InvoiceNumber as Number, InvoiceSequence as [#],
		   InvoiceLineItemAmount as LineItem
	FROM Vendors Vend
	INNER JOIN  Invoices Inv
	ON Vend.VendorID = Inv.VendorID
	INNER JOIN InvoiceLineItems LineItem
	ON Inv.InvoiceID = LineItem.InvoiceID

	/*
	First 10 rows
	===============================================================================
	Vendor                                             Date                    Number                                             #      LineItem
	-------------------------------------------------- ----------------------- -------------------------------------------------- ------ ---------------------
	United Parcel Service                              2015-12-08 00:00:00     989319-457                                         1      3813.33
	Federal Express Corporation                        2015-12-10 00:00:00     263253241                                          1      40.20
	Federal Express Corporation                        2015-12-13 00:00:00     963253234                                          1      138.75
	Federal Express Corporation                        2015-12-16 00:00:00     2-000-2993                                         1      144.70
	Federal Express Corporation                        2015-12-16 00:00:00     963253251                                          1      15.50
	Federal Express Corporation                        2015-12-16 00:00:00     963253261                                          1      42.75
	Federal Express Corporation                        2015-12-21 00:00:00     963253237                                          1      172.50
	Evans Executone Inc                                2015-12-24 00:00:00     125520-1                                           1      95.00
	Zylka Design                                       2015-12-24 00:00:00     97/488                                             1      601.95
	Federal Express Corporation                        2015-12-24 00:00:00     263253250                                          1      42.67
	===============================================================================
	*/

/*
6.	Write a SELECT statement that returns three columns: 
	VendorID From the Vendors table
	VendorName	From the Vendors table
	Name	A concatenation of VendorContactFName and VendorContactLName, 
	with a space in between
	The result set should have one row for each vendor whose contact 
	has the same first name as another vendor’s contact. Sort the final 
	result set by Name.
	Hint: Use a self-join.
*/

	USE AP
	GO

	SELECT A.VendorID, A.VendorName, (A.VendorContactFName + ' ' + A.VendorContactLName) AS [Name]
	FROM Vendors A, Vendors B
	WHERE A.VendorContactFName = B.VendorContactFName
	ORDER BY (A.VendorContactFName + ' ' + A.VendorContactLName)

	/*
	First 11 rows
	===============================================================================
	VendorID    VendorName                                         Name
	----------- -------------------------------------------------- -----------------------------------------------------------------------------------------------------
	30          Costco                                             Aaron Jaquan
	110         Malloy Lithographing Inc                           Abe Regging
	23          Yale Industrial Trucks-Fresno                      Alexandro Alexis
	93          AT&T                                               Alisha Wesley
	101         California Business Machines                       Anders Rohansen
	86          Computerworld                                      Angel Lloyd
	2           National Information Data Ctr                      Ania Irvin
	107         Franchise Tax Board                                Anita Prado
	70          Fresno Credit Bureau                               Anne Braydon
	6           California Chamber Of Commerce                     Anton Mauro
	10          Robbins Mobile Lock And Key                        Bill Leigh
	===============================================================================
	*/

/*
7.	Write a SELECT statement that returns two columns 
	from the GLAccounts table: 
	AccountNo and AccountDescription. The result set should have 
	one row for each account number that has never been used. 
	Sort the final result set by AccountNo.
	Hint: Use an outer join to the InvoiceLineItems table.
*/
	
	USE AP
	GO

	SELECT DISTINCT G.AccountNo, AccountDescription
	FROM GLAccounts G
	LEFT OUTER JOIN InvoiceLineItems I
	ON G.AccountNo = I.AccountNo
	WHERE I.InvoiceID IS NOT NULL
	ORDER BY G.AccountNo

	/*
	rows
	===============================================================================
	AccountNo   AccountDescription
	----------- --------------------------------------------------
	150         Furniture
	160         Computer Equipment
	170         Other Equipment
	400         Book Printing Costs
	403         Book Production Costs
	507         UCI
	510         Group Insurance
	520         Building Lease
	521         Utilities
	522         Telephone
	523         Building Maintenance
	540         Direct Mail Advertising
	552         Postage
	553         Freight
	570         Office Supplies
	572         Books, Dues, and Subscriptions
	574         Business Licenses and Taxes
	580         Meals
	582         Travel and Accomodations
	589         Outside Services
	591         Accounting
	===============================================================================
	*/

/*
8.	Use the UNION operator to generate a result set consisting 
	of two columns from the Vendors table: 
	VendorName and VendorState. 
	If the vendor is in California, the VendorState value should 
	be “CA”; otherwise, the VendorState value should be “Outside CA.” 
	Sort the final result set by VendorName. 
*/

	USE AP
	GO

	SELECT *
	FROM (
	SELECT VendorName,
		   CASE WHEN VendorState = 'CA' THEN VendorState
				ELSE 'Outside CA'
				END AS VendorState
	FROM Vendors
	UNION
	SELECT VendorName,
		   CASE WHEN VendorState = 'CA' THEN VendorState
				ELSE 'Outside CA'
				END AS VendorState
	FROM Vendors
	) A
	ORDER BY A.VendorName

	/*
	10 rows
	===============================================================================
	VendorName                                         VendorState
	-------------------------------------------------- -----------
	Abbey Office Furnishings                           CA
	American Booksellers Assoc                         Outside CA
	American Express                                   CA
	ASC Signs                                          CA
	Ascom Hasler Mailing Systems                       Outside CA
	AT&T                                               Outside CA
	Aztek Label                                        CA
	Baker & Taylor Books                               Outside CA
	Bertelsmann Industry Svcs. Inc                     CA
	BFI Industries                                     CA
	===============================================================================
	*/