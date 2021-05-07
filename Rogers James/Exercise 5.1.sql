DROP TABLE  IF EXISTS AP.VendorCopy;
go
DROP TABLE  IF EXISTS AP.InvoiceCopy;
go
Select * into VendorCopy from Vendors; 
go
Select * into InvoiceCopy from Invoices;
go