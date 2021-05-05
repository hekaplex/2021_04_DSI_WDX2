Use AP
GO

SELECT CONCAT(VendorContactLName, ', ', VendorContactFName) AS FullName 
FROM Vendors
WHERE VendorContactLName LIKE 'A%' OR VendorContactLName LIKE 'B%'
   OR VendorContactLName LIKE 'C%' OR VendorContactLName LIKE 'E%'
ORDER BY VendorContactLName ASC, VendorContactFName ASC;