Select VendorName as "Vendor",InvoiceDate as "Date", InvoiceNumber as "Number", InvoiceSequence as "#", InvoiceLineItemAmount as "LineItem"
FROM Vendors  Vend 
INNER JOIN Invoices   Inv ON Vend.VendorID = Inv.VendorID 
INNER JOIN InvoiceLineItems  LineItem  ON LineItem.InvoiceID = Inv.InvoiceID 
order by Vendor, Date, Number, #;