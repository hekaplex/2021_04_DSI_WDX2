SELECT InvoiceNumber , InvoiceTotal-PaymentTotal as BalanceDue
from Invoices 
where InvoiceDueDate <  DATEADD(DD, -30, GETDATE()) 
and InvoiceTotal-PaymentTotal <> 0;