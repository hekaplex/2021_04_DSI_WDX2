Select Case when AccountDescription is NULL then 'ALL' else AccountDescription end as Account,
Case when  VendorState is NULL then 'ALL' else VendorState end as State, 
sum(InvoiceLineItemAmount)    as LineItemSum
from GLAccounts GL inner join InvoiceLineItems IL on GL.AccountNo = IL.AccountNo
inner join Invoices I ON I.InvoiceID = IL.InvoiceID 
inner join Vendors V ON V.VendorID = I.VendorID
group by CUBE(AccountDescription, VendorState)