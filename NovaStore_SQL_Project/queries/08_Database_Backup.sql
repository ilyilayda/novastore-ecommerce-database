USE master;
GO

-- NovaStore Database Backup
-- Backup location: C:\Yedek\NovaStoreDB.bak

BACKUP DATABASE [NovaStoreDB]
TO DISK = N'C:\Yedek\NovaStoreDB.bak'
WITH INIT, CHECKSUM, STATS = 10;
GO
