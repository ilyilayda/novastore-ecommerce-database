USE NovaStoreDB;
GO

-- Query 03: Customer Purchased Products
-- List products purchased by Ahmet Yilmaz,
-- including product prices and categories.

SELECT
    c.FullName AS [Musteri Adi],
    p.ProductName AS [Urun Adi],
    p.Price AS [Birim Fiyat],
    cat.CategoryName AS [Kategori],
    od.Quantity AS [Adet]
FROM dbo.Customers AS c
INNER JOIN dbo.Orders AS o
    ON c.CustomerID = o.CustomerID
INNER JOIN dbo.OrderDetails AS od
    ON o.OrderID = od.OrderID
INNER JOIN dbo.Products AS p
    ON od.ProductID = p.ProductID
INNER JOIN dbo.Categories AS cat
    ON p.CategoryID = cat.CategoryID
WHERE c.FullName = 'Ahmet Yilmaz'
ORDER BY p.ProductName;
