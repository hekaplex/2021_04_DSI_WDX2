select
cast(invoicetotal as decimal(10,2)) as Column_1,
cast(invoicetotal as varchar(10)) as Column_2,
convert(decimal(10,2),invoicetotal) as Column_3,
convert(varchar(10),invoicetotal) as Column_4
from invoices;