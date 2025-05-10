-- Veri Doðrulama: CHECK, UNIQUE, DEFAULT Kýsýtlamalarý hakkýn da örnek SQL kodlarý:

--1. CHECK ile yaþ doðrulamasý örneði:
CREATE TABLE Ogrenci (
    OgrenciID INT IDENTITY(1,1) PRIMARY KEY,
    Ad NVARCHAR(50),
    Yas INT CHECK (Yas >= 17)
);

--2. UNIQUE ile öðrenci numarasý kontrolü örneði:
CREATE TABLE Kayit (
    KayitID INT IDENTITY(1,1) PRIMARY KEY,
    OgrenciNo NVARCHAR(20) UNIQUE
);

--3. DEFAULT ile kayýt tarihi tanýmlama örneði:
CREATE TABLE Basvuru (
    BasvuruID INT IDENTITY(1,1) PRIMARY KEY,
    BasvuruTarihi DATE DEFAULT GETDATE()
);

--4. CHECK ile maaþ doðrulamasý örneði:
CREATE TABLE Personel (
    PersonelID INT IDENTITY(1,1) PRIMARY KEY,
    AdSoyad NVARCHAR(100),
    Maas INT CHECK (Maas BETWEEN 8500 AND 100000)
);

--5. UNIQUE ile telefon numarasý eþsizliði örneði:
CREATE TABLE Musteri (
    MusteriID INT IDENTITY(1,1) PRIMARY KEY,
    Telefon NVARCHAR(15) UNIQUE
);

--6. DEFAULT ile varsayýlan kullanýcý rolü örneði:
CREATE TABLE Kullanici (
    KullaniciID INT IDENTITY(1,1) PRIMARY KEY,
    KullaniciAdi NVARCHAR(50),
    Rol NVARCHAR(20) DEFAULT 'Uye'
);

--7. CHECK ile not aralýðý kontrolü örneði:
CREATE TABLE Notlar (
    NotID INT IDENTITY(1,1) PRIMARY KEY,
    Vize INT CHECK (Vize BETWEEN 0 AND 100),
    Final INT CHECK (Final BETWEEN 0 AND 100)
);

--8. DEFAULT ile varsayýlan aktiflik durumu örneði:
CREATE TABLE Abone (
    AboneID INT IDENTITY(1,1) PRIMARY KEY,
    AdSoyad NVARCHAR(100),
    Aktif BIT DEFAULT 1
);

--9. UNIQUE ile kimlik numarasý kontrolü örneði:
CREATE TABLE Vatandas (
    TCKN CHAR(11) UNIQUE,
    AdSoyad NVARCHAR(100)
);

--10. CHECK ile e-posta uzunluk kontrolü örneði:
CREATE TABLE Iletisim (
    IletisimID INT IDENTITY(1,1) PRIMARY KEY,
    Eposta NVARCHAR(100) CHECK (LEN(Eposta) >= 5)
);


--OrderServiceImpl sýnýfýna ait stored procedure iþlemleri:

--1- Ürün stok adedini kontrol:
CREATE PROCEDURE CheckStock
    @ProductID INT
AS
BEGIN
    SELECT Stock FROM Products WHERE ProductID = @ProductID;
END;

--2- Ürün satýldýktan sonra stok miktarýný azaltan:
CREATE PROCEDURE ReduceStock
    @ProductID INT,
    @Quantity INT
AS
BEGIN
    UPDATE Products
    SET Stock = Stock - @Quantity
    WHERE ProductID = @ProductID AND Stock >= @Quantity;
END;


--3- Sipariþ oluþturulduysa notification bilgisini çýkaran:
CREATE PROCEDURE OrderNotification
    @OrderID INT
AS
BEGIN
    DECLARE @UserID INT;
    SELECT @UserID = UserID FROM Orders WHERE OrderID = @OrderID;

    IF @UserID IS NOT NULL
        PRINT 'Order created. Notification sent to user.';
    ELSE
        PRINT 'Order not found.';
END;


