SELECT V.VendorName, GL.AccountDescription, COUNT(*) AS LineItemCount, SUM(IL.InvoiceLineItemAmount) AS LineItemSum 
FROM InvoiceLineItems IL
INNER JOIN GLAccounts GL ON IL.AccountNo = GL.AccountNo 
INNER JOIN Invoices I on I.InvoiceID = IL.InvoiceID 
INNER JOIN Vendors V on V.VendorID = I.VendorID
GROUP BY V.VendorName, GL.AccountDescription 
ORDER BY V.VendorName, GL.AccountDescription;