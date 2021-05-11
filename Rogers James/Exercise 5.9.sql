DELETE FROM VendorCopy where VendorState not in 
(SELECT DISTINCT VendorState from VendorCopy where VendorID NOT IN (Select distinct VendorID from InvoiceCopy));