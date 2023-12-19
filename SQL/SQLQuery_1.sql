--1
SELECT * FROM FLO
--2
SELECT Distinct COUNT(master_id) AS KacFarkliMusteri From FLO
--3
SELECT SUM(order_num_total_ever_online)+SUM(order_num_total_ever_offline) as TopAlisverisAdedi, SUM(customer_value_total_ever_online)+SUM(customer_value_total_ever_offline) AS TopCiro FROM FLO
--4
SELECT (SUM(customer_value_total_ever_online)+SUM(customer_value_total_ever_offline))/(SUM(order_num_total_ever_online)+SUM(order_num_total_ever_offline)) AS AlisBasOrtCiro FROM FLO
--5
SELECT SUM(order_num_total_ever_offline) as TopAlisverisAdediOffline, SUM(customer_value_total_ever_offline) AS TopCiroOffline FROM FLO WHERE last_order_channel='Offline' 
SELECT SUM(order_num_total_ever_online) as TopAlisverisAdediOnline, SUM(customer_value_total_ever_online) AS TopCiroOnline FROM FLO WHERE NOT last_order_channel='Offline'
--6

--7
SELECT last_order_channel, CAST((SUM(customer_value_total_ever_online)+SUM(customer_value_total_ever_offline))/(SUM(order_num_total_ever_online)+SUM(order_num_total_ever_offline))as int) AS Ortalama FROM FLO GROUP BY last_order_channel
--8

--9
SELECT master_id,order_channel FROM FLO
--10
SELECT * FROM FLO WHERE NOT last_order_channel='Offline'
--11
SELECT master_id,SUM(customer_value_total_ever_online) AS BuyukBin FROM FLO WHERE NOT last_order_channel='Offline' GROUP BY master_id HAVING SUM(customer_value_total_ever_online)>1000
SELECT * FROM FLO WHERE NOT last_order_channel='Offline' AND customer_value_total_ever_online > 1000
--12
SELECT SUM(customer_value_total_ever_online)+SUM(customer_value_total_ever_offline) as MobileCiro  FROM FLO WHERE order_channel='Mobile'
--13
SELECT interested_in_categories_12 FROM FLO WHERE interested_in_categories_12 LIKE '%SPOR%'
--14
SELECT customer_value_total_ever_offline FROM FLO WHERE customer_value_total_ever_offline BETWEEN 0 and 10000
--15
SELECT interested_in_categories_12,order_channel, SUM(order_num_total_ever_online) as TopOnline,COUNT(order_num_total_ever_online) as AdetOn FROM FLO GROUP BY interested_in_categories_12,order_channel ORDER BY TopOnline
--16
SELECT interested_in_categories_12,last_order_channel, COUNT(order_num_total_ever_online) as AdetOn FROM FLO GROUP BY interested_in_categories_12,last_order_channel ORDER BY AdetOn ASC
--17
SELECT TOP 50 master_id, SUM(order_num_total_ever_online)+SUM(order_num_total_ever_offline) AS TopSiparis FROM FLO GROUP BY master_id ORDER BY 2 DESC
--18 
SELECT first_order_date FROM FLO
--19
SELECT last_order_date FROM FLO WHERE YEAR(last_order_date)='2020'
--20
SELECT master_id,interested_in_categories_12,order_channel FROM FLO WHERE interested_in_categories_12='[AKTIFSPOR]'
--21
SELECT master_id,interested_in_categories_12,order_channel FROM FLO WHERE interested_in_categories_12 LIKE '%AKTIFSPOR%'
--22
SELECT MONTH(first_order_date) as AY,YEAR(first_order_date) AS YIL,COUNT(first_order_date) AS ADET FROM FLO WHERE YEAR(first_order_date) BETWEEN 2018 AND 2019 GROUP BY YEAR(first_order_date),MONTH(first_order_date) ORDER BY  YEAR(first_order_date),MONTH(first_order_date) ASC
--23
SELECT order_channel FROM FLO WHERE order_channel='Mobile' OR order_channel='Desktop'
--24
SELECT order_channel,interested_in_categories_12 FROM FLO WHERE interested_in_categories_12 NOT LIKE '%AKTIFSPOR%' AND (order_channel='Mobile' OR order_channel='Desktop') 
--25
SELECT TOP 15 MONTH(first_order_date) AS AY,YEAR(first_order_date) AS YIL,SUM(customer_value_total_ever_online)+SUM(customer_value_total_ever_offline) AS Tops FROM FLO GROUP BY MONTH(first_order_date),YEAR(first_order_date) ORDER BY SUM(customer_value_total_ever_online) DESC
--- NORTHWIND DATABASE ---  
--26   
SELECT * from Customers
SELECT * from Orders  
SELECT * from Customers INNER JOIN Orders ON customers.CustomerID=orders.CustomerID  
--27  
SELECT * from Customers LEFT JOIN Orders ON customers.CustomerID=orders.CustomerID  
--28  
SELECT * from Customers RIGHT JOIN Orders ON customers.CustomerID=orders.CustomerID
