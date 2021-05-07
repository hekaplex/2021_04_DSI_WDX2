Select sum(UnpaidVendor.LargestUnpaidAmount) as SumOfLargestUnpaidAmount 
FROM
(Select VendorID, MAX(InvoiceTotal) as LargestUnpaidAmount from Invoices where PaymentDate Is NULL group by VendorID) UnpaidVendor;