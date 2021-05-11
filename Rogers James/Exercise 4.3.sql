Select InvoiceId, InvoiceNumber, InvoiceTotal 
from Invoices
where PaymentTotal >= ALL (select TOP 50 PERCENT PaymentTotal from Invoices ); 