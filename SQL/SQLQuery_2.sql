--1
SELECT YEAR(OrderDate) AS YIL,MONTH(OrderDate) AS AY,COUNT(CustomerID) AS KacTane FROM Orders GROUP BY YEAR(OrderDate),MONTH(OrderDate) ORDER BY 1,2
--2
SELECT TOP 5 Orders.CustomerID,SUM([Order Details].[UnitPrice]*[Order Details].[Quantity]) AS TopMiktar FROM Orders 
Left JOIN [Order Details] ON Orders.OrderID=[Order Details].[OrderID]
GROUP BY Orders.CustomerID ORDER BY 2 DESC
--3
SELECT ProductID,AVG(UnitPrice) AS OrtFiyat FROM [Order Details] GROUP BY ProductID ORDER BY 1,2 
--4
Select CategoryID,COUNT(*) AS UrunSayisi FROM Products GROUP BY CategoryID ORDER BY 1,2
--5
SELECT EmployeeID,COUNT(*) AS TopSipSay FROM Orders GROUP BY EmployeeID
--6
SELECT ProductID,SUM(Quantity) AS Miktar FROM [Order Details] GROUP BY ProductID ORDER BY 2 DESC
--7
SELECT Customers.CustomerID,SUM([Order Details].[Quantity]*[Order Details].[UnitPrice]) AS Miktar,AVG([Order Details].Quantity*[Order Details].UnitPrice) AS OrtSip 
FROM Customers LEFT JOIN Orders ON Customers.CustomerID=Orders.CustomerID LEFT JOIN [Order Details] ON Orders.OrderID=[Order Details].OrderID GROUP BY Customers.CustomerID
--8
SELECT Country,COUNT(CustomerID) AS MusSayi FROM Customers GROUP BY Country ORDER BY 2 
--9
SELECT UnitsInStock,SUM(UnitsInStock*UnitPrice) AS Toplam FROM Products GROUP BY UnitsInStock
--10
SELECT Employees.EmployeeID,COUNT(Orders.CustomerID) AS Miktar FROM Employees LEFT JOIN Orders on Orders.EmployeeID=Employees.EmployeeID GROUP BY Employees.EmployeeID
--11
SELECT Categories.CategoryName,MAX([Products].UnitPrice) AS MaksMiktar FROM Categories LEFT JOIN Products on Products.CategoryID=Categories.CategoryID GROUP BY Categories.CategoryName
--12
SELECT Customers.ContactName,MAX(OrderDate) AS SonSip,MIN(Orderdate) AS İlkSip  FROM Customers LEFT JOIN Orders on Orders.CustomerID=Customers.CustomerID GROUP BY Customers.ContactName
--13
SELECT YEAR(Orders.OrderDate) AS YIL,SUM([Order Details].Quantity) AS TopLamSatis,AVG([Order Details].Quantity*[Order Details].UnitPrice) AS OrtMik FROM Orders 
LEFT JOIN [Order Details] on [Order Details].[OrderID]=Orders.OrderID GROUP BY YEAR(Orders.OrderDate) ORDER BY YIL
--14
SELECT Products.ProductName,MAX(OrderDate) AS SonSip FROM Products LEFT Join [Order Details] on [Order Details].[ProductID]=Products.ProductID LEFT JOIN Orders on Orders.OrderID=[Order Details].[OrderID] GROUP BY Products.ProductName
--15
SELECT Customers.ContactName,Products.ProductName,MAX([Order Details].Quantity) AS MaksMik FROM Customers 
LEFT JOIN Orders on Orders.CustomerID=Customers.CustomerID LEFT JOIN [Order Details] ON Orders.OrderID=[Order Details].OrderID LEFT JOIN Products ON Products.ProductID=[Order Details].ProductID 
GROUP BY Customers.ContactName,Products.ProductName
ORDER BY 3 DESC