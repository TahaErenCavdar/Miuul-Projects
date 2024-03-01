SELECT * FROM Orders
--1
SELECT AVG([GünFarki]) as 'Ortalama' FROM (Select DATEDIFF(DAY,ShippedDate,RequiredDate) AS GünFarki FROM Orders WHERE DATEDIFF(DAY,ShippedDate,RequiredDate)<0) OrtGecikme
--2
SELECT AVG([GünFarki]) as 'Ortalama' FROM (Select DATEDIFF(DAY,ShippedDate,RequiredDate) AS GünFarki FROM Orders WHERE DATEDIFF(DAY,ShippedDate,RequiredDate)>0) OrtGecikme
--3
SELECT Customer_ID,cast(SUM(Quantity*Price)as int) AS Monetary FROM retail_2010_2011 GROUP BY Customer_ID ORDER BY 2 DESC
--4
Select Customer_ID,DATEDIFF(Day,MAX(InvoiceDate),'2011.12.30') as 'Recency' FROM retail_2010_2011 GROUP BY Customer_ID
--5
Select Country,[Description],UrunFazla,CAST(TopCiro as int) AS TopCiro FROM (Select Country,[Description],SUM(Quantity) AS UrunFazla,SUM(Quantity*Price) AS TopCiro, 
ROW_NUMBER() OVER( Partition BY Country ORDER BY SUM(Quantity) DESC) AS rowNumber
FROM retail_2010_2011
GROUP BY Country,[Description]
) Eren
WHERE rowNumber = 1
ORDER BY TopCiro DESC
