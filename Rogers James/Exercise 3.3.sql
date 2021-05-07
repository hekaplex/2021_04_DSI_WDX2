SELECT Vend.VendorName, count(Inv.InvoiceID) as InvoiceCount, sum(Inv.InvoiceTotal) as InvoiceSum
FROM Vendors  Vend  
INNER JOIN Invoices   Inv ON Vend.VendorID = Inv.VendorID 
group by VendorName
order by 2 desc;


