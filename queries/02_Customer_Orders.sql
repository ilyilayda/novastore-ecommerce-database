USE NovaStoreDB;
GO

-- Query 02: Customer Orders
-- List customers with their order dates and total amounts.

SELECT
    c.FullName AS [Musteri Adi],
    c.City AS [Sehir],
    o.OrderDate AS [Siparis Tarihi],
    o.TotalAmount AS [Toplam Tutar]
FROM dbo.Customers AS c
INNER JOIN dbo.Orders AS o
    ON c.CustomerID = o.CustomerID
ORDER BY o.OrderDate DESC;
