Select distinct V1.VendorName, V1.VendorCity, V1.VendorState 
from Vendors V1 
WHERE V1.VendorCity NOT IN (Select VendorCity from Vendors V2 where V2.VendorID <> V1.VendorID) 
and V1.VendorState NOT IN (Select VendorState from Vendors V3 where V3.VendorID <> V1.VendorID); 