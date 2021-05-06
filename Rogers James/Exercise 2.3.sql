Select V.VendorName, V.DefaultAccountNo, GL.AccountDescription
FROM Vendors V INNER JOIN GLAccounts GL ON V.DefaultAccountNo = GL.AccountNo
ORDER BY GL.AccountDescription, V.VendorName

