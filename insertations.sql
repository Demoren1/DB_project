DROP TABLE IF EXISTS project.Ord;
DROP TABLE IF EXISTS project.Tariff;
DROP TABLE IF EXISTS project.Car;
DROP TABLE IF EXISTS project.Driver;
DROP TABLE IF EXISTS project.Loyalty_card;
DROP TABLE IF EXISTS Client;

CREATE TABLE project.Tariff (
  tf_name VARCHAR(64) PRIMARY KEY,
  price_for_km INT NOT NULL,
  basic_cost INT NOT NULL,
  modifier INT NOT NULL
);

CREATE TABLE project.Car (
  num VARCHAR(16) PRIMARY KEY,
  model VARCHAR(64) NOT NULL,
  cond INT NOT NULL
);

CREATE TABLE project.Driver (
  ID_driver INT PRIMARY KEY,
  car_number VARCHAR(16) REFERENCES project.Car(num),
  full_name VARCHAR(255) NOT NULL,
  phone_number INT NOT NULL,
  email VARCHAR(50) NOT NULL
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
  phone_number INT NOT NULL,
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
