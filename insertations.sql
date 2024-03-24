DROP TABLE IF EXISTS project.Ord CASCADE;
DROP TABLE IF EXISTS project.Tariff CASCADE;
DROP TABLE IF EXISTS project.Car CASCADE;
DROP TABLE IF EXISTS project.Driver CASCADE;
DROP TABLE IF EXISTS project.Loyalty_card CASCADE;
DROP TABLE IF EXISTS project.Client CASCADE;

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
    ID_driver INT,
    car_number VARCHAR(16),
    full_name VARCHAR(255),
    phone_number INT,
    basic_fee INT,
    email VARCHAR(50),
    start_date DATE NOT NULL,
    end_date DATE DEFAULT '9999-12-31',
    version_number INT DEFAULT 1,
    is_current BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (ID_driver, start_date),
    FOREIGN KEY (car_number) REFERENCES project.Car(num)
);

CREATE TABLE project.Loyalty_card (
  card_number INT PRIMARY KEY,
  bonus INTEGER NOT NULL,
  create_date DATE NOT NULL
);

CREATE TABLE project.Client (
  ID_user INT PRIMARY KEY,
  FOREIGN KEY card_number INT REFERENCES project.Loyalty_card(card_number),
  full_name VARCHAR(255) NOT NULL,
  phone_number INT NOT NULL,
  email VARCHAR(64) NOT NULL
);

CREATE TABLE project.Ord (
  ID_ord INT PRIMARY KEY,
  FOREIGN KEY ID_user INTEGER REFERENCES project.Client(ID_user),
  FOREIGN KEY ID_driver INTEGER REFERENCES project.Driver(ID_driver),
  FOREIGN KEY car_number VARCHAR(16) REFERENCES project.Car(num),
  FOREIGN KEY tariff_name VARCHAR(64) REFERENCES project.Tariff(tf_name),
  start_address VARCHAR(255) NOT NULL,
  end_address VARCHAR(255) NOT NULL,
  start_time TIMESTAMP NOT NULL,
  end_time TIMESTAMP NOT NULL,
  status VARCHAR(64) NOT NULL
);


