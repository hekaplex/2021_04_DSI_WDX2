Use AP
GO

SELECT CONCAT(VendorContactLName, ', ', VendorContactFName) AS FullName 
FROM Vendors
ORDER BY VendorContactLName ASC, VendorContactFName ASC;