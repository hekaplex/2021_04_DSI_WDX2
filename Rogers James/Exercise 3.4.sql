SELECT GL.AccountDescription,COUNT(IL.AccountNo) AS LineItemCount, SUM(IL.InvoiceLineItemAmount) AS LineItemSum 
FROM InvoiceLineItems IL
INNER JOIN GLAccounts GL ON IL.AccountNo = GL.AccountNo 
GROUP BY GL.AccountDescription
HAVING COUNT(IL.AccountNo)>1  
ORDER BY LineItemCount DESC ;