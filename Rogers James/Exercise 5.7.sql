UPDATE InvoiceCopy Set TermsID = 2 WHERE VendorID = (Select  VendorID from VendorCopy where DefaultTermsID = 2);