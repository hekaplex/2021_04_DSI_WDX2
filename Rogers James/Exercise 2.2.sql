SELECT VendorName, InvoiceNumber, InvoiceDate, InvoiceTotal - (PaymentTotal + CreditTotal) AS Balance 
From Vendors INNER JOIN Invoices ON Vendors.VendorID = Invoices.VendorID
WHERE InvoiceTotal - (PaymentTotal + CreditTotal) > 0
ORDER BY VendorName ASC;