Use AP
GO

SELECT InvoiceTotal, (InvoiceTotal * 0.10) as Tenpercent,  (InvoiceTotal * 1.10) as PlusTenPercent
FROM Invoices
WHERE InvoiceTotal > 1000
ORDER BY InvoiceTotal DESC