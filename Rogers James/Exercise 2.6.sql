Select V1.VendorID, V1.VendorName, concat(V1.VendorContactFName, concat(' ', V1.VendorContactLName)) as "Name"
FROM Vendors V1 
inner join Vendors V2  
ON V1.VendorContactFName = V2.VendorContactFName 
and V1.VendorID <> V2.VendorID 
order by Name; 