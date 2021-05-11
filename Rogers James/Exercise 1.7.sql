Use AP
GO

SELECT PaymentDate, InvoiceTotal 
FROM Invoices
WHERE ((PaymentDate Is Not Null) And (InvoiceTotal = 0)) OR ((PaymentDate Is Null) And (InvoiceTotal > 0))
	  
	  
