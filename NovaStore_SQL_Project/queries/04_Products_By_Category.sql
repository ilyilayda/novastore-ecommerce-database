
USE NovaStoreDB;
GO

-- Query 04: Products by Category
-- Count the total number of products in each category.
-- LEFT JOIN includes categories without any products.

SELECT
    c.CategoryName AS [Kategori],
    COUNT(p.ProductID) AS [Urun Sayisi]
FROM dbo.Categories AS c
LEFT JOIN dbo.Products AS p
    ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryID, c.CategoryName
ORDER BY [Urun Sayisi] DESC, [Kategori] ASC;
