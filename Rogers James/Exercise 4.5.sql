Select Vend.VendorName, LineItem.InvoiceID, LineItem.InvoiceSequence,  LineItem.InvoiceLineItemAmount
 FROM Vendors  Vend 
INNER JOIN Invoices   Inv ON Vend.VendorID = Inv.VendorID 
INNER JOIN InvoiceLineItems  LineItem  ON LineItem.InvoiceID = Inv.InvoiceID 
where LineItem.InvoiceID IN 
(Select InvoiceID from InvoiceLineItems group by InvoiceID having count(InvoiceSequence) > 1) 