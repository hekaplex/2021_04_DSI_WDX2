SELECT AccountNo, sum(InvoiceLineItemAmount) AS Amounts
from InvoiceLineItems
group by ROLLUP(AccountNo)