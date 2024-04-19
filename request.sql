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

-- 11.Выведем информацию о водителях и их текущих автомобилях

SELECT d.full_name, c.model, c.num
FROM project.Driver d
JOIN project.Car c ON d.car_number = c.num
WHERE d.is_current = TRUE;

-- 12. Посчитаем среднюю сумму заказа для каждого клиента

SELECT c.full_name, AVG(p.total_payment) AS average_payment
FROM project.Client c
JOIN project.Ord o ON c.ID_user = o.ID_user
JOIN project.Payment p ON o.ID_ord = p.ID_order
GROUP BY c.full_name;

-- 13. Найти автомобили с пробегом больше определенного значения

SELECT num, model, mileage
FROM project.Car
WHERE mileage > 100000;

-- 14. Найдем клиентов с бонусами на карте лояльности выше определенного порога

SELECT c.full_name, lc.bonus
FROM project.Client c
JOIN project.Loyalty_card lc ON c.card_number = lc.card_number
WHERE lc.bonus > 500;


-- 15. Определим водителей, которые работали в компании дольше всего:

SELECT full_name, start_date
FROM project.Driver
ORDER BY start_date
LIMIT 5;

-- 16. Найдем заказы, выполненные определенным водителем

SELECT o.ID_ord, c.full_name, o.start_time, o.end_time
FROM project.Ord o
JOIN project.Driver d ON o.ID_driver = d.ID_driver
JOIN project.Client c ON o.ID_user = c.ID_user
WHERE d.full_name = 'Иванов Иван Иванович';

-- 17. Выведем список заказов, отсортированных по расстоянию и стоимости

SELECT ID_ord, start_address, end_address, distance_km, p.total_payment
FROM project.Ord o
JOIN project.Payment p ON o.ID_ord = p.ID_order
ORDER BY distance_km DESC, p.total_payment DESC;

-- 18. Выведем информацию о водителях, их текущих автомобилях и количестве выполненных заказов:

SELECT d.full_name, c.model, c.num, COUNT(o.ID_ord) AS total_orders
FROM project.Driver d
JOIN project.Car c ON d.car_number = c.num
LEFT JOIN project.Ord o ON d.ID_driver = o.ID_driver
WHERE d.is_current = TRUE
GROUP BY d.full_name, c.model, c.num
ORDER BY total_orders DESC;

-- 19. Определим самый прибыльный тариф, учитывая количество заказов и стоимость

SELECT tf_name, COUNT(*) AS number_of_orders, SUM(p.total_payment) AS total_revenue
FROM project.Ord o
JOIN project.Tariff t ON o.tariff_name = t.tf_name
JOIN project.Payment p ON o.ID_ord = p.ID_order
GROUP BY tf_name
ORDER BY total_revenue DESC
LIMIT 1;

-- 20. Выведем среднюю сумму заказа для каждого тарифа

SELECT t.tf_name, AVG(p.total_payment) AS average_payment
FROM project.Tariff t
JOIN project.Ord o ON t.tf_name = o.tariff_name
JOIN project.Payment p ON o.ID_ord = p.ID_order
GROUP BY t.tf_name;