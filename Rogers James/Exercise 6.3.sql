SELECT CONCAT(VendorContactFName, CONCAT(' ', CONCAT(substring(VendorContactLName, 1,1), '.'))) as contact,
substring(VendorPhone, 7, 8) as Phone
from Vendors  where substring(VendorPhone, 2,3 ) = 559;