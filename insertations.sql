DROP TABLE IF EXISTS project.Ord CASCADE;
DROP TABLE IF EXISTS project.Tariff CASCADE;
DROP TABLE IF EXISTS project.Car CASCADE;
DROP TABLE IF EXISTS project.Driver CASCADE;
DROP TABLE IF EXISTS project.Loyalty_card CASCADE;
DROP TABLE IF EXISTS project.Client CASCADE;
DROP TABLE IF EXISTS project.Payment CASCADE;


CREATE TABLE project.Tariff (
  tf_name VARCHAR(64) PRIMARY KEY,
  price_for_km float NOT NULL,
  basic_cost float NOT NULL,
  modifier float NOT NULL
);

CREATE TABLE project.Car (
  num VARCHAR(16) PRIMARY KEY,
  model VARCHAR(64) NOT NULL,
  cond INT NOT NULL
);

CREATE TABLE project.Driver (
    ID_driver INT PRIMARY KEY,
    car_number VARCHAR(16),
    full_name VARCHAR(255) NOT NULL,
    phone_number VARCHAR(32) NOT NULL,
    basic_fee INT NOT NULL,
    email VARCHAR(50) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE DEFAULT '9999-12-31',
    version_number INT DEFAULT 1,
    is_current BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (car_number) REFERENCES project.Car(num)
);

CREATE TABLE project.Loyalty_card (
  card_number INT PRIMARY KEY,
  bonus INTEGER NOT NULL,
  create_date DATE NOT NULL
);

CREATE TABLE project.Client (
  ID_user INT PRIMARY KEY,
  card_number INT REFERENCES project.Loyalty_card(card_number),
  full_name VARCHAR(255) NOT NULL,
  phone_number VARCHAR(32) NOT NULL,
  email VARCHAR(64) NOT NULL
);

CREATE TABLE project.Ord (
  ID_ord INT PRIMARY KEY,
  ID_user INTEGER REFERENCES project.Client(ID_user),
  ID_driver INTEGER REFERENCES project.Driver(ID_driver),
  car_number VARCHAR(16) REFERENCES project.Car(num),
  tariff_name VARCHAR(64) REFERENCES project.Tariff(tf_name),
  start_address VARCHAR(255) NOT NULL,
  end_address VARCHAR(255) NOT NULL,
  start_time TIMESTAMP NOT NULL,
  end_time TIMESTAMP NOT NULL,
  status VARCHAR(64) NOT NULL
);

CREATE TABLE Payment (
  ID_payment int PRIMARY KEY,
  card_number INTEGER REFERENCES Loyalty_card(card_number),
  ID_order INTEGER REFERENCES Order(ID_order),
  total_payment DECIMAL(10,2) NOT NULL,
  date DATE NOT NULL,
  payment_method VARCHAR(50) NOT NULL
);

INSERT INTO project.Tariff (tf_name, price_for_km, basic_cost, modifier)
VALUES
('Эконом', 70, 50, 1),
('Стандарт', 100, 60, 1),
('Премиум', 200, 100, 2),
('Бизнес', 150, 75, 1.5),
('Суперэконом', 50, 30, 0.9),
('Ночной', 50, 50, 1),
('Выходной', 100, 100, 1.5),
('Корпоративный', 125, 75, 1),
('Продолжительный', 65, 20, 1),
('Междугородний', 150, 10, 1),
('Долгосрочный', 50, 10, 1),
('Городской', 150, 20, 1),
('Тариф с фиксированной стоимостью', 100, 0, 1),
('Раритетный автомобиль', 300, 200, 1),
('Вечерний', 200, 130, 11);

INSERT INTO project.Car (num, model, cond) VALUES
('ABC123', 'Toyota Camry', 4),
('DEF456', 'Honda Accord', 3),
('GHI789', 'Ford Fusion', 2),
('JKL101', 'Nissan Altima', 5),
('MNO234', 'Hyundai Sonata', 4),
('PQR567', 'Chevrolet Malibu', 3),
('STU890', 'Kia Optima', 2),
('VWX123', 'Volkswagen Jetta', 5),
('YZA456', 'Mazda3', 4),
('BCD789', 'Subaru Legacy', 3),
('CDE101', 'Mitsubishi Lancer', 2),
('EFG234', 'BMW 3 Series', 5),
('GHI567', 'Mercedes-Benz C-Class', 4),
('IJK890', 'Audi A4', 3),
('KLM123', 'Lexus ES', 2),
('NOP456', 'Toyota Camry', 3),
('QRS789', 'Honda Accord', 2),
('TUV012', 'Ford Focus', 4),
('XYZ345', 'Chevrolet Malibu', 5),
('ABC678', 'Toyota Camry', 1),
('DEF901', 'Honda Accord', 3),
('GHI234', 'Ford Focus', 2),
('JKL567', 'Chevrolet Malibu', 5),
('MNO890', 'Toyota Camry', 4),
('PQR123', 'Honda Accord', 1),
('STU456', 'Ford Focus', 3),
('VWX789', 'Chevrolet Malibu', 2),
('YZA012', 'Toyota Camry', 5),
('IJK345', 'Honda Accord', 4),
('BCD678', 'Ford Focus', 1);


INSERT INTO project.Driver (ID_driver, car_number, full_name, phone_number, basic_fee, email, start_date) VALUES
(1, 'ABC123', 'John Doe', '+1234567890', 100, 'johndoe@example.com', '2024-01-01'),
(2, 'DEF456', 'Alice Smith', '+9876543210', 120, 'alicesmith@example.com', '2024-02-15'),
(3, 'GHI789', 'Bob Johnson', '+1122334455', 110, 'bjohnson@example.com', '2024-03-10'),
(4, 'JKL101', 'Emma Brown', '+9988776655', 130, 'emmabrown@example.com', '2024-04-20'),
(5, 'MNO234', 'Michael Davis', '+5544332211', 115, 'mdavis@example.com', '2024-05-05'),
(6, 'PQR567', 'Sarah Wilson', '+7766554433', 105, 'sarahwilson@example.com', '2024-06-30'),
(7, 'STU890', 'David Garcia', '+8877665544', 125, 'dgarcia@example.com', '2024-07-15'),
(8, 'VWX123', 'Sophia Martinez', '+1234432156', 140, 'smartinez@example.com', '2024-08-10'),
(9, 'YZA456', 'James Lee', '+6598741230', 100, 'jameslee@example.com', '2024-09-25'),
(10, 'IJK890', 'Olivia White', '+1234567890', 135, 'oliviawhite@example.com', '2024-10-05'),
(11, 'BCD789', 'William Johnson', '+9876543210', 120, 'wjohnson@example.com', '2024-11-20'),
(12, 'CDE101', 'Emily Garcia', '+1122334455', 110, 'egarcia@example.com', '2024-12-15'),
(13, 'EFG234', 'Daniel Brown', '+9988776655', 130, 'dbrown@example.com', '2025-01-30'),
(14, 'GHI567', 'Ava Davis', '+5544332211', 115, 'avadavis@example.com', '2025-02-10'),
(15, 'KLM123', 'Isabella Martinez', '+7766554433', 105, 'imartinez@example.com', '2025-03-25');

INSERT INTO project.Driver (ID_driver, car_number, full_name, phone_number, basic_fee, email, start_date, end_date, is_current) VALUES
(16, 'NOP456', 'John Doe', '+9876543210', 100, 'johndoe@example.com', '2022-01-01', '2022-12-31', FALSE),
(17, 'QRS789', 'Alice Smith', '+1122334455', 120, 'alicesmith@example.com', '2022-02-15', '2022-12-31', FALSE),
(18, 'TUV012', 'Bob Johnson', '+9988776655', 110, 'bjohnson@example.com', '2022-03-10', '2022-12-31', FALSE),
(19, 'XYZ345', 'Emma Brown', '+5544332211', 130, 'emmabrown@example.com', '2022-04-20', '2022-12-31', FALSE),
(20, 'ABC678', 'Michael Davis', '+7766554433', 115, 'mdavis@example.com', '2022-05-05', '2022-12-31', FALSE),
(21, 'DEF901', 'Sarah Wilson', '+8877665544', 105, 'sarahwilson@example.com', '2022-06-30', '2022-12-31', FALSE),
(22, 'GHI234', 'David Garcia', '+1234432156', 125, 'dgarcia@example.com', '2022-07-15', '2022-12-31', FALSE),
(23, 'JKL567', 'Sophia Martinez', '+6598741230', 140, 'smartinez@example.com', '2022-08-10', '2022-12-31', FALSE),
(24, 'MNO890', 'James Lee', '+1234567890', 100, 'jameslee@example.com', '2022-09-25', '2022-12-31', FALSE),
(25, 'PQR123', 'Olivia White', '+9876543210', 135, 'oliviawhite@example.com', '2022-10-05', '2022-12-31', FALSE),
(26, 'STU456', 'William Johnson', '+1122334455', 120, 'wjohnson@example.com', '2022-11-20', '2022-12-31', FALSE),
(27, 'VWX789', 'Emily Garcia', '+9988776655', 110, 'egarcia@example.com', '2022-12-15', '2022-12-31', FALSE),
(28, 'YZA012', 'Daniel Brown', '+5544332211', 130, 'dbrown@example.com', '2023-01-30', '2023-12-31', FALSE),
(29, 'IJK345', 'Ava Davis', '+7766554433', 115, 'avadavis@example.com', '2023-02-10', '2023-12-31', FALSE),
(30, 'BCD678', 'Isabella Martinez', '+8877665544', 105, 'imartinez@example.com', '2023-03-25', '2023-12-31', FALSE);

INSERT INTO project.Loyalty_card (card_number, bonus, create_date) VALUES
(1001, 500, '2023-01-01'),
(1002, 750, '2023-02-05'),
(1003, 300, '2023-03-10'),
(1004, 1000, '2023-04-15'),
(1005, 800, '2023-05-20'),
(1006, 400, '2023-06-25'),
(1007, 900, '2023-07-30'),
(1008, 600, '2023-08-05'),
(1009, 1200, '2023-09-10'),
(1010, 950, '2023-10-15'),
(1011, 700, '2023-11-20'),
(1012, 1100, '2023-12-25'),
(1013, 850, '2024-01-01'),
(1014, 550, '2024-02-05'),
(1015, 1050, '2024-03-10');

INSERT INTO project.Client (ID_user, card_number, full_name, phone_number, email) VALUES
(1, 1001, 'Иван Иванов', '+1234567890', 'ivanov@example.com'),
(2, 1002, 'Алексей Смирнов', '+9876543210', 'smirnov@example.com'),
(3, 1003, 'Мария Петрова', '+1122334455', 'petrova@example.com'),
(4, 1004, 'Елена Кузнецова', '+9988776655', 'kuznetsova@example.com'),
(5, 1005, 'Александр Соколов', '+5544332211', 'sokolov@example.com'),
(6, 1006, 'Ольга Михайлова', '+7766554433', 'mikhailova@example.com'),
(7, 1007, 'Дмитрий Новиков', '+8877665544', 'novikov@example.com'),
(8, 1008, 'Наталья Волкова', '+1234432156', 'volkova@example.com'),
(9, 1009, 'Андрей Козлов', '+6598741230', 'kozlov@example.com'),
(10, 1010, 'Екатерина Лебедева', '+1234567890', 'lebedeva@example.com'),
(11, 1011, 'Анна Семенова', '+9876543210', 'semenova@example.com'),
(12, 1012, 'Павел Егоров', '+1122334455', 'egorov@example.com'),
(13, 1013, 'Валентина Павлова', '+9988776655', 'pavlova@example.com'),
(14, 1014, 'Ирина Федорова', '+5544332211', 'fedorova@example.com'),
(15, 1015, 'Сергей Николаев', '+7766554433', 'nikolaev@example.com');



