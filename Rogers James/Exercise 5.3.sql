SET IDENTITY_INSERT VendorCopy ON;
INSERT INTO VendorCopy(VendorID ,VendorName,VendorAddress1,VendorAddress2,VendorCity,VendorState,VendorZipCode,VendorPhone,
      VendorContactLName,VendorContactFName,DefaultTermsID,DefaultAccountNo)
SELECT * FROM Vendors
WHERE VendorState <> 'CA'; 