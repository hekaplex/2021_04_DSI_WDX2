select
cast(InvoiceDate as varchar(30)) as Column_1,  
convert(Varchar(10),InvoiceDate, 1) as Column_2, 
convert(Varchar(10),InvoiceDate, 10) as Column_3, 
cast(InvoiceDate as real) as Column_4 
from invoices;