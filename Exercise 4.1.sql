SELECT DISTINCT VendorName 
FROM Vendors , Invoices
WHERE Vendors.VendorID = Invoices.VendorID 
ORDER BY VendorName;