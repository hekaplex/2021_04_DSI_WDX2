Select InvoiceId, InvoiceNumber, InvoiceTotal 
from Invoices
where PaymentTotal > (select avg(PaymentTotal) from Invoices); 
