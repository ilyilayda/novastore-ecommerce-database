/*
 NOVASTORE | E-TICARET VERI YONETIM SISTEMI
 Teslim: Ilayda_Dinckulah_NovaStore_Proje.sql
 SQL Server / SSMS (T-SQL) | UTF-8
 Tek seferde calistirin (Execute / F5). VAR OLAN NovaStoreDB SILINMEZ.
 DIKKAT: NovaStoreDB zaten varsa script hata verir; mevcut veriyi korur.
 Backup komutu altta YORUM ICINDEDIR. Once C:\Yedek klasorunu olusturup
 SQL Server hizmet hesabina yazma izni verin, sonra backup scriptini calistirin.
*/
USE [master];
GO
IF DB_ID(N'NovaStoreDB') IS NOT NULL
    THROW 50001, 'NovaStoreDB zaten mevcut. Mevcut veriyi korumak icin kurulum durduruldu.', 1;
GO
CREATE DATABASE [NovaStoreDB];
GO
USE [NovaStoreDB];
GO
-- BOLUM 1: DDL / 5 TABLO VE ILISKILER
CREATE TABLE dbo.Categories (
 CategoryID INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Categories PRIMARY KEY,
 CategoryName VARCHAR(50) NOT NULL
);
CREATE TABLE dbo.Customers (
 CustomerID INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Customers PRIMARY KEY,
 FullName VARCHAR(50) NOT NULL,
 City VARCHAR(20) NULL,
 Email VARCHAR(100) NOT NULL CONSTRAINT UQ_Customers_Email UNIQUE
);
CREATE TABLE dbo.Products (
 ProductID INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Products PRIMARY KEY,
 ProductName VARCHAR(100) NOT NULL,
 Price DECIMAL(10,2) NOT NULL CONSTRAINT CK_Products_Price CHECK (Price >= 0),
 Stock INT NOT NULL CONSTRAINT DF_Products_Stock DEFAULT(0) CONSTRAINT CK_Products_Stock CHECK (Stock >= 0),
 CategoryID INT NOT NULL CONSTRAINT FK_Products_Categories FOREIGN KEY REFERENCES dbo.Categories(CategoryID)
);
CREATE TABLE dbo.Orders (
 OrderID INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Orders PRIMARY KEY,
 CustomerID INT NOT NULL CONSTRAINT FK_Orders_Customers FOREIGN KEY REFERENCES dbo.Customers(CustomerID),
 OrderDate DATETIME NOT NULL CONSTRAINT DF_Orders_OrderDate DEFAULT(GETDATE()),
 TotalAmount DECIMAL(10,2) NOT NULL CONSTRAINT CK_Orders_TotalAmount CHECK (TotalAmount >= 0)
);
CREATE TABLE dbo.OrderDetails (
 DetailID INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_OrderDetails PRIMARY KEY,
 OrderID INT NOT NULL CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY REFERENCES dbo.Orders(OrderID),
 ProductID INT NOT NULL CONSTRAINT FK_OrderDetails_Products FOREIGN KEY REFERENCES dbo.Products(ProductID),
 Quantity INT NOT NULL CONSTRAINT CK_OrderDetails_Quantity CHECK (Quantity > 0)
);
GO
-- BOLUM 2: DML / 5 KATEGORI, 15 URUN, 6 MUSTERI, 12 SIPARIS, 25 DETAY

INSERT INTO dbo.Categories (CategoryName) VALUES
 ('Elektronik'),
 ('Giyim'),
 ('Kitap'),
 ('Kozmetik'),
 ('Ev ve Yasam');

INSERT INTO dbo.Customers (FullName,City,Email) VALUES
 ('Ahmet Yilmaz','Istanbul','ahmet.yilmaz@example.com'),
 ('Ayse Demir','Ankara','ayse.demir@example.com'),
 ('Mehmet Kaya','Izmir','mehmet.kaya@example.com'),
 ('Elif Celik','Kayseri','elif.celik@example.com'),
 ('Zeynep Arslan','Bursa','zeynep.arslan@example.com'),
 ('Can Yildiz','Antalya','can.yildiz@example.com');

INSERT INTO dbo.Products (ProductName,Price,Stock,CategoryID) VALUES
 ('Kablosuz Kulaklik', 1299.00, 14, 1),
 ('Bluetooth Hoparlor', 1899.00, 30, 1),
 ('Mekanik Klavye', 2299.00, 8, 1),
 ('Pamuk Tisort', 349.00, 45, 2),
 ('Kot Pantolon', 899.00, 18, 2),
 ('Spor Ayakkabi', 1699.00, 11, 2),
 ('Python Programlama Kitabi', 499.00, 22, 3),
 ('Veri Bilimi Rehberi', 599.00, 9, 3),
 ('Nemlendirici Krem', 279.00, 15, 4),
 ('Gunes Kremi', 399.00, 35, 4),
 ('Masa Lambasi', 749.00, 16, 5),
 ('Termos', 449.00, 50, 5),
 ('Seramik Kupa', 229.00, 7, 5),
 ('Akilli Saat', 3299.00, 12, 1),
 ('Sac Bakim Serumu', 529.00, 27, 4);

-- Siparis tutarlari detay satirlarinin urun fiyati x adet toplamidir.

INSERT INTO dbo.Orders (CustomerID,OrderDate,TotalAmount) VALUES (1, '2026-06-03T11:30:00', 2696.00); -- Siparis 1

INSERT INTO dbo.OrderDetails (OrderID,ProductID,Quantity) VALUES (1,1,1), (1,7,2), (1,10,1);

INSERT INTO dbo.Orders (CustomerID,OrderDate,TotalAmount) VALUES (2, '2026-06-15T13:45:00', 977.00); -- Siparis 2

INSERT INTO dbo.OrderDetails (OrderID,ProductID,Quantity) VALUES (2,4,2), (2,9,1);

INSERT INTO dbo.Orders (CustomerID,OrderDate,TotalAmount) VALUES (3, '2026-07-01T10:00:00', 3048.00); -- Siparis 3

INSERT INTO dbo.OrderDetails (OrderID,ProductID,Quantity) VALUES (3,3,1), (3,11,1);

INSERT INTO dbo.Orders (CustomerID,OrderDate,TotalAmount) VALUES (4, '2026-07-12T15:20:00', 2298.00); -- Siparis 4

INSERT INTO dbo.OrderDetails (OrderID,ProductID,Quantity) VALUES (4,6,1), (4,8,1);

INSERT INTO dbo.Orders (CustomerID,OrderDate,TotalAmount) VALUES (5, '2026-08-02T09:10:00', 2797.00); -- Siparis 5

INSERT INTO dbo.OrderDetails (OrderID,ProductID,Quantity) VALUES (5,2,1), (5,12,2);

INSERT INTO dbo.Orders (CustomerID,OrderDate,TotalAmount) VALUES (1, '2026-08-15T17:00:00', 4097.00); -- Siparis 6

INSERT INTO dbo.OrderDetails (OrderID,ProductID,Quantity) VALUES (6,14,1), (6,10,2);

INSERT INTO dbo.Orders (CustomerID,OrderDate,TotalAmount) VALUES (6, '2026-09-04T12:40:00', 1815.00); -- Siparis 7

INSERT INTO dbo.OrderDetails (OrderID,ProductID,Quantity) VALUES (7,5,1), (7,13,4);

INSERT INTO dbo.Orders (CustomerID,OrderDate,TotalAmount) VALUES (2, '2026-09-17T14:25:00', 1828.00); -- Siparis 8

INSERT INTO dbo.OrderDetails (OrderID,ProductID,Quantity) VALUES (8,1,1), (8,15,1);

INSERT INTO dbo.Orders (CustomerID,OrderDate,TotalAmount) VALUES (3, '2026-09-30T18:15:00', 1546.00); -- Siparis 9

INSERT INTO dbo.OrderDetails (OrderID,ProductID,Quantity) VALUES (9,7,1), (9,4,3);

INSERT INTO dbo.Orders (CustomerID,OrderDate,TotalAmount) VALUES (4, '2026-10-05T16:35:00', 1307.00); -- Siparis 10

INSERT INTO dbo.OrderDetails (OrderID,ProductID,Quantity) VALUES (10,11,1), (10,9,2);

INSERT INTO dbo.Orders (CustomerID,OrderDate,TotalAmount) VALUES (5, '2026-10-09T13:15:00', 1647.00); -- Siparis 11

INSERT INTO dbo.OrderDetails (OrderID,ProductID,Quantity) VALUES (11,8,2), (11,12,1);

INSERT INTO dbo.Orders (CustomerID,OrderDate,TotalAmount) VALUES (1, '2026-10-11T20:00:00', 2757.00); -- Siparis 12

INSERT INTO dbo.OrderDetails (OrderID,ProductID,Quantity) VALUES (12,3,1), (12,13,2);

GO
-- BOLUM 3 / SORGU 1: Stok < 20, azalan stok sirasi
SELECT ProductName AS [Urun Adi], Stock AS [Stok Miktari]
FROM dbo.Products WHERE Stock < 20 ORDER BY Stock DESC, ProductName ASC;

-- BOLUM 3 / SORGU 2: Musteri + tarih + sehir + tutar (INNER JOIN)
SELECT c.FullName AS [Musteri Adi], c.City AS [Sehir],
       o.OrderDate AS [Siparis Tarihi], o.TotalAmount AS [Toplam Tutar]
FROM dbo.Customers AS c INNER JOIN dbo.Orders AS o ON o.CustomerID=c.CustomerID
ORDER BY o.OrderDate DESC;

-- BOLUM 3 / SORGU 3: Ahmet Yilmaz'in aldigi urunler (5 tablo JOIN)
SELECT c.FullName AS [Musteri], p.ProductName AS [Urun Adi],
       p.Price AS [Fiyat], ca.CategoryName AS [Kategori], od.Quantity AS [Adet]
FROM dbo.Customers AS c
INNER JOIN dbo.Orders AS o ON c.CustomerID=o.CustomerID
INNER JOIN dbo.OrderDetails AS od ON od.OrderID=o.OrderID
INNER JOIN dbo.Products AS p ON p.ProductID=od.ProductID
INNER JOIN dbo.Categories AS ca ON ca.CategoryID=p.CategoryID
WHERE c.FullName = 'Ahmet Yilmaz'
ORDER BY o.OrderDate, p.ProductName;

-- BOLUM 3 / SORGU 4: Kategori bazinda urun sayisi (LEFT JOIN + COUNT)
SELECT ca.CategoryName AS [Kategori], COUNT(p.ProductID) AS [Urun Sayisi]
FROM dbo.Categories AS ca LEFT JOIN dbo.Products AS p ON p.CategoryID=ca.CategoryID
GROUP BY ca.CategoryID, ca.CategoryName
ORDER BY [Urun Sayisi] DESC, ca.CategoryName;

-- BOLUM 3 / SORGU 5: Musteri bazinda toplam ciro (SUM + GROUP BY)
SELECT c.FullName AS [Musteri Adi],
       CAST(COALESCE(SUM(o.TotalAmount),0) AS DECIMAL(12,2)) AS [Toplam Ciro]
FROM dbo.Customers AS c LEFT JOIN dbo.Orders AS o ON o.CustomerID=c.CustomerID
GROUP BY c.CustomerID, c.FullName
ORDER BY [Toplam Ciro] DESC, c.FullName;

-- BOLUM 3 / SORGU 6: Siparisten bugune gecen gun (DATEDIFF + GETDATE)
SELECT OrderID AS [Siparis No], OrderDate AS [Siparis Tarihi],
       DATEDIFF(DAY,OrderDate,GETDATE()) AS [Gecen Gun]
FROM dbo.Orders ORDER BY OrderDate DESC;
GO
-- BOLUM 4 / GOREV 1: CREATE VIEW - musteri, tarih, urun, adet
CREATE VIEW dbo.vw_SiparisOzet AS
SELECT c.FullName AS MusteriAdi, o.OrderDate AS SiparisTarihi,
       p.ProductName AS UrunAdi, od.Quantity AS Adet
FROM dbo.Customers AS c
INNER JOIN dbo.Orders AS o ON o.CustomerID=c.CustomerID
INNER JOIN dbo.OrderDetails AS od ON od.OrderID=o.OrderID
INNER JOIN dbo.Products AS p ON p.ProductID=od.ProductID;
GO
-- VIEW KONTROL
SELECT * FROM dbo.vw_SiparisOzet ORDER BY SiparisTarihi DESC, UrunAdi;
GO
-- EK: Ornek veri ve tutarlilik kontrolleri
SELECT 'Categories' AS Tablo,COUNT(*) AS KayitSayisi FROM dbo.Categories
UNION ALL SELECT 'Products', COUNT(*) FROM dbo.Products
UNION ALL SELECT 'Customers', COUNT(*) FROM dbo.Customers
UNION ALL SELECT 'Orders', COUNT(*) FROM dbo.Orders
UNION ALL SELECT 'OrderDetails', COUNT(*) FROM dbo.OrderDetails;

SELECT o.OrderID, o.TotalAmount AS KayitliTutar,
       SUM(CAST(p.Price * od.Quantity AS DECIMAL(12,2))) AS DetayToplami
FROM dbo.Orders AS o
INNER JOIN dbo.OrderDetails AS od ON od.OrderID=o.OrderID
INNER JOIN dbo.Products AS p ON p.ProductID=od.ProductID
GROUP BY o.OrderID, o.TotalAmount
HAVING o.TotalAmount <> SUM(p.Price * od.Quantity);
-- Bu son kontrol 0 satir donmelidir.
GO
/*
 BOLUM 4 / GOREV 2: YEDEKLEME
 Klasoru SQL Server'in calistigi MAKINEDE olusturun: C:\Yedek
 SQL Server servis hesabinin yazma yetkisi olmalidir.
 Backup islemini kurulumdan SONRA ayrica calistirin:
 BACKUP DATABASE [NovaStoreDB]
 TO DISK = N'C:\Yedek\NovaStoreDB.bak'
 WITH INIT, CHECKSUM, STATS = 10;
*/
