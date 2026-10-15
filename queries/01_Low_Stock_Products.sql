USE NovaStoreDB;
GO

-- Query 01: Low Stock Products
SELECT ProductName AS [Urun Adi],
       Stock AS [Stok Miktari]
FROM dbo.Products
WHERE Stock < 20
ORDER BY Stock DESC;