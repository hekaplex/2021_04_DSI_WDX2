select TOP 10  V.VendorName, sum(I.PaymentTotal) PaymentSum 
from   Vendors  V  
INNER JOIN Invoices   I ON V.VendorID = I.VendorID  
group by V.VendorName 
order by sum(PaymentTotal) desc ;

