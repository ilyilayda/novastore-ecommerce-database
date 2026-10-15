USE NovaStoreDB;
GO

-- Query 06: Order Date Analysis
-- Calculate the number of days since each order.
-- DATEDIFF and GETDATE are used for date calculations.

SELECT
    o.OrderID AS [Siparis ID],
    c.FullName AS [Musteri Adi],
    o.OrderDate AS [Siparis Tarihi],
    DATEDIFF(
        DAY,
        o.OrderDate,
        GETDATE()
    ) AS [Gecen Gun Sayisi]
FROM dbo.Orders AS o
INNER JOIN dbo.Customers AS c
    ON o.CustomerID = c.CustomerID
ORDER BY o.OrderDate DESC;
