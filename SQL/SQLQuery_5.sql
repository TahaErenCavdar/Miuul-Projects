-- 1. Employees tablosunda, her çalışanın yöneticisini ve çalışanın adını listeyin.
SELECT
    e.EmployeeID AS 'Çalışan ID',
    e.FirstName + ' ' + e.LastName AS 'Çalışan Adı',
    (
        SELECT
            m.FirstName + ' ' + m.LastName
        FROM
            Employees m
        WHERE
            m.EmployeeID = e.Reportsto
    ) AS 'Yönetici Adı'
FROM
    Employees e;
-- 2. Bir 'TopCustomers' adında geçici bir tablo oluşturun ve her müşterinin toplam harcamasını içersin. Daha sonra bu tabloyu drop edin.
CREATE VIEW [TopCustomers_Eren] AS
SELECT Customers.ContactName,SUM([Order Details].Quantity*[Order Details].Quantity) AS TopHarcama FROM Customers 
LEFT JOIN Orders ON Orders.CustomerID=Customers.CustomerID 
LEFT JOIN [Order Details] ON [Order Details].OrderID=Orders.OrderID 
GROUP BY Customers.ContactName

SELECT * FROM [TopCustomers_Eren]
DROP VIEW [TopCustomers_Eren]
-- 3. Her müşterinin verdiği sipariş sayısını bulun.
SELECT Customers.ContactName,COUNT(Distinct [Orders].OrderID) AS SipSayisi FROM Customers 
LEFT  JOIN Orders ON Orders.CustomerID=Customers.CustomerID 
LEFT JOIN [Order Details] ON [Order Details].OrderID=Orders.OrderID
GROUP BY Customers.ContactName ORDER BY 2 DESC
-- 4. Siparişlerin kargo statülerini belirleyen sorguyu yazınız.
SELECT O.OrderID,KargoStatu FROM (Select OrderID, 
Case 
When RequiredDate = ShippedDate Then 'Zamanında'
When RequiredDate < ShippedDate Then 'GeçKalındı'
When RequiredDate > ShippedDate Then 'ErkenTeslim'
When ShippedDate IS NULL Then 'TeslimEdilemedi'
End AS KargoStatu
FROM Orders
)O
--4 Ekstra
select OrderID,
CASE 
    WHEN ShippedDate>RequiredDate THEN cast(DATEDIFF(Day,RequiredDate,ShippedDate) as varchar)+' '+'Gün Geç Ulaştı'
    WHEN ShippedDate<RequiredDate then cast(DATEDIFF(Day,ShippedDate,RequiredDate) as varchar)+' '+'Gün Erken Ulaştı'
    WHEN ShippedDate=RequiredDate then cast(DATEDIFF(Day,ShippedDate,RequiredDate) as varchar)+' '+'Tam Zamanında'
    WHEN ShippedDate is NULL then 'Kargo Yolda'
END
AS Kargo_durumu
FROM Orders
-- 5. Tedarikçi ve Müşterilerin Şehirlerini Birleştiren sorguyu yazınız.
SELECT Suppliers.ContactName AS Tedarikçi,Customers.ContactName AS Musteri,Suppliers.City FROM Suppliers 
INNER JOIN Customers ON Customers.City=Suppliers.City
-- 6. Her müşteriye göre siparişlerin sıralı bir numarasını atayan sorguyu yazınız.
SELECT Customers.ContactName,Orders.OrderID,Orders.OrderDate,
ROW_NUMBER() OVER(PARTITION BY Customers.ContactName ORDER BY Orders.OrderDate) AS SiparisSira 
FROM Customers 
LEFT JOIN Orders ON Orders.CustomerID=Customers.CustomerID
