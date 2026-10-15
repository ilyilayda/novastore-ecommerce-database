USE NovaStoreDB;
GO

-- Query 07: Order Summary View
-- Display customer, order, product and quantity data.
-- Sort the results by order date, newest first.

SELECT *
FROM dbo.vw_SiparisOzet
ORDER BY SiparisTarihi DESC;
