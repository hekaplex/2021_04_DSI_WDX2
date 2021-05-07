Select VendorName, InvoiceNumber, InvoiceDate, InvoiceTotal
from Invoices
INNER JOIN Vendors on Vendors.VendorID = Invoices.VendorID 
where InvoiceDate = (Select MIN(InvoiceDate) from Invoices I   WHERE I.VendorID = Invoices.VendorID group by VendorID); 