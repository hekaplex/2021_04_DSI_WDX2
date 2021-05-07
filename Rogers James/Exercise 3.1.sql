Select I.VendorID, Sum(I.PaymentTotal) as PaymentSum
from Invoices I
group by I.VendorID;