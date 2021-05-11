SELECT GL.AccountDescription,COUNT(IL.AccountNo) AS LineItemCount, SUM(IL.InvoiceLineItemAmount) AS LineItemSum 
FROM InvoiceLineItems IL
INNER JOIN GLAccounts GL ON IL.AccountNo = GL.AccountNo 
INNER JOIN Invoices I on I.InvoiceID = IL.InvoiceID 
WHERE InvoiceDate >= '2002-01-01' and InvoiceDate <= '2002-03-31'
GROUP BY GL.AccountDescription
HAVING COUNT(IL.AccountNo)>1  
ORDER BY LineItemCount DESC ;