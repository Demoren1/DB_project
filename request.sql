--1. Найдем самый популярный тариф

SELECT tariff_name, COUNT(*) AS total_orders
FROM project.Ord
GROUP BY tariff_name
ORDER BY total_orders DESC
LIMIT 1;


--2. Количество минут, в течении которых машина перевозила клиентов
SELECT car_number, model, TRUNC(SUM(extract(epoch from (end_time - start_time)) / 60)) AS total_minutes
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



