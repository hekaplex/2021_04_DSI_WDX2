SELECT VendorName, count(distinct LineItem.AccountNo )  as NumberOfAccounts
FROM Vendors  Vend 
INNER JOIN Invoices   Inv ON Vend.VendorID = Inv.VendorID 
INNER JOIN InvoiceLineItems  LineItem  ON LineItem.InvoiceID = Inv.InvoiceID 
group by VendorName
having count(distinct LineItem.AccountNo) > 1 ; 