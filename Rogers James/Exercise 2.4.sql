SELECT VendorName, InvoiceNumber, InvoiceDate, InvoiceTotal - (PaymentTotal + CreditTotal) AS Balance 
From Vendors v, Invoices i
WHERE v.VendorID = i.VendorID
AND InvoiceTotal - (PaymentTotal + CreditTotal) > 0
ORDER BY VendorName ASC;