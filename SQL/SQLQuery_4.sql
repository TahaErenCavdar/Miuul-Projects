--1
Select TOP 5 SUM([Order Details].Quantity) AS Adet,Products.ProductName FROM [Order Details] LEFT JOIN [Products] ON Products.ProductID=[Order Details].ProductID 
GROUP BY Products.ProductName ORDER BY 1 DESC
--2
Select Customers.[ContactName],SUM(Quantity*UnitPrice) AS TopHarc,SUM(Quantity) AS SipSay FROM Customers LEFT JOIN Orders ON Customers.CustomerID=Orders.CustomerID LEFT JOIN [Order Details] ON Orders.OrderID=[Order Details].OrderID GROUP BY Customers.ContactName
--3
SELECT CategoryID,
ProductName,
Maks
FROM (Select Products.ProductName,Products.CategoryID,MAX(UnitPrice) AS Maks,
ROW_NUMBER() OVER(Partition By CategoryID ORDER BY MAX(UnitPrice) DESC) AS Topik
FROM Products
GROUP BY Products.CategoryID,Products.ProductName) Eren
WHERE Topik = 1
ORDER BY CategoryID
--4
SELECT Employees.EmployeeID,[Order Details].OrderID AS Siparis,AVG(UnitPrice*Quantity) AS OrtSatis FROM Employees 
LEFT JOIN Orders ON  Orders.EmployeeID=Employees.EmployeeID 
LEFT JOIN [Order Details] ON [Order Details].OrderID=Orders.OrderID GROUP BY Employees.EmployeeID,[Order Details].OrderID
--5
SELECT Country,COUNT(Customers.CustomerID) AS Sayi,SUM([Order Details].Quantity) AS TopSip FROM Customers 
LEFT JOIN Orders ON Orders.CustomerID=Customers.CustomerID 
LEFT JOIN [Order Details] ON [Order Details].[OrderID]=Orders.OrderID
GROUP BY Country
--Soru 6: Stok Miktarına Göre Ürünlerin Durumunu Sınıflandırma Yapacağınız Sorguyu Yazın.
SELECT UnitsInStock,ProductName,
    CASE
    WHEN UnitsInStock = 0 THEN 'UrunBitti'
    Else 'UrunVar'
    END  AS UrunVarligi
FROM Products
--Soru 7: Her Çalışanın Son 6 Ay İçinde Yaptığı Toplam Satış Miktarını Bulacağınız Sorguyu Yazın. 1998.05.06
DECLARE @MaxOrderDate DATE;
SET @MaxOrderDate = (SELECT MAX(OrderDate) FROM Orders);

SELECT
    Employees.EmployeeID,
    Employees.FirstName,
    Employees.LastName,
    SUM([Order Details].Quantity * [Order Details].UnitPrice) AS SatisMiktari
FROM
    Employees
LEFT JOIN
    Orders ON Orders.EmployeeID = Employees.EmployeeID
LEFT JOIN
    [Order Details] ON [Order Details].OrderID = Orders.OrderID
WHERE
    Orders.OrderDate > DATEADD(MONTH, -6, @MaxOrderDate)
GROUP BY
    Employees.EmployeeID, Employees.FirstName, Employees.LastName
ORDER BY
    SatisMiktari DESC;
--8 Her Müşteri İçin İlk ve Son Sipariş Tarihleri Bulacağınız Sorguyu Yazın.
SELECT Customers.ContactName,MAX(Orders.OrderDate) AS SonSip,MIN(Orders.OrderDate) AS IlkSip FROM Customers 
LEFT JOIN Orders ON Orders.CustomerID=Customers.CustomerID
GROUP BY Customers.ContactName
--9 En Çok Sipariş Verilen 5 Şehri ve Bu Şehirlerdeki Toplam Sipariş Sayısını Bulacağınız Sorguyu Yazın.
SELECT TOP 5 Customers.City,COUNT(*) AS TopSip
FROM Customers 
LEFT JOIN Orders ON Orders.CustomerID=Customers.CustomerID 
LEFT JOIN [Order Details] ON [Order Details].OrderID=Orders.OrderID
GROUP BY Customers.City
ORDER BY COUNT(*) DESC
--10 Ürünlerin Kategorilere Göre Ortalama Fiyatlarını Bulacağınız Sorguyu Yazın.
SELECT CategoryID,AVG(UnitPrice) AS OrtFiyat FROM Products GROUP BY CategoryID