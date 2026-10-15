-- Once C:\Yedek SQL Server makinesinde mevcut ve yazilabilir olmali.
USE master;
GO
BACKUP DATABASE [NovaStoreDB] TO DISK = N'C:\Yedek\NovaStoreDB.bak' WITH INIT, CHECKSUM, STATS = 10;
GO
RESTORE VERIFYONLY FROM DISK = N'C:\Yedek\NovaStoreDB.bak' WITH CHECKSUM;
GO
