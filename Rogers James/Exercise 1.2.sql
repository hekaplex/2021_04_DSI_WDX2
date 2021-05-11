Use AP
GO

SELECT InvoiceNumber AS Number, InvoiceTotal AS Total, PaymentTotal + CreditTotal AS Credits, InvoiceTotal - (PaymentTotal + CreditTotal) AS Balance
FROM Invoices
ORDER BY Balance DESC