SELECT InvoiceNumber , InvoiceTotal-PaymentTotal as BalanceDue
from Invoices 
where InvoiceDueDate <  EOMONTH(GETDATE()) 
and InvoiceTotal-PaymentTotal <> 0;