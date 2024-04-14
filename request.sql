--1. Найдем самый популярный тариф

SELECT tariff_name, COUNT(*) AS total_orders
FROM project.Ord
GROUP BY tariff_name
ORDER BY total_orders DESC
LIMIT 1;


--2. Количество минут, в течении которых машина перевозила клиентов
SELECT car_number, TRUNC(SUM(extract(epoch from (end_time - start_time)) / 60)) AS total_minutes
FROM project.Ord
GROUP BY car_number
ORDER BY total_minutes DESC;


--3. Выведем текущие автомобили водителей.

SELECT
	d.full_name,
	car.num,
	car.model
FROM 
	project.Driver AS d
JOIN
	project.Car AS car ON d.car_number = car.num
WHERE
	d.is_current = true;

--4. Найдем среднюю стоимость поездки по разным способам оплаты

SELECT
    DISTINCT payment_method,
    TRUNC(AVG(total_payment) OVER (PARTITION BY payment_method)) AS avg_payment
FROM
    project.Payment;

--5.Найдем клиентов, у которых бонусы превышают среднее значение бонусов по всем клиентам

SELECT 
	c.full_name, 
	l.bonus
FROM 
	project.Client as c
JOIN 
	project.Loyalty_card l ON c.card_number = l.card_number
WHERE l.bonus > (SELECT AVG(bonus) FROM project.Loyalty_card);

--6 Подсчитать сумму зароботка со всех поездок, оплаченных с картой лояльности.

SELECT SUM(p.total_payment) AS total_sum
FROM project.Payment p
JOIN project.Loyalty_card l ON p.card_number = l.card_number
WHERE l.card_number IS NOT NULL;

--7 Выведем все автомобили, которые находятся в отличном состоянии

SELECT model, num FROM project.Car WHERE cond = 5;

--8 Найдём водителей, совершивших хотя бы одну поездку.

SELECT d.full_name as DriverName, COUNT(o.ID_driver) as TotalTrips
FROM project.Driver d
LEFT JOIN project.Ord o ON d.ID_driver = o.ID_driver
GROUP BY d.full_name
HAVING COUNT(o.ID_driver) > 0; 

--9 Выведем тариф, по которому был самый высокий платёж с кредитки.

SELECT o.tariff_name, p.total_payment
FROM project.Ord o
JOIN project.Payment p ON o.ID_ord = p.ID_order
WHERE p.payment_method = 'Кредитная карта'
ORDER BY p.total_payment DESC
LIMIT 1;

--10 Найдём водителей, которые возили пассажиров с определённым оператором связи (начало номера +9)
SELECT DISTINCT d.full_name, c.full_name
FROM project.Driver d
INNER JOIN project.Ord o ON d.ID_driver = o.ID_driver
INNER JOIN project.Client c ON o.ID_user = c.ID_user
WHERE c.phone_number LIKE '+9%';

