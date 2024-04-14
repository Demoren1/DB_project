import psycopg2
from faker import Faker
import random
import csv

# Establish database connection
conn = psycopg2.connect(
    database="test_db",
    user="postgres",
    password="postgres",
    host="127.0.0.1",
    port="5432",
)
cur = conn.cursor()

# Instantiate Faker
fake = Faker("ru_RU")

cars_models = []
with open('cars.csv', 'r') as f:
    reader = csv.reader(f, delimiter=';')
    for line in reader:
        cars_models.append(line[0] + " " + line[1])

# Generate 100 cars
for _ in range(100):
    car_number = fake.license_plate()
    model = random.choice(cars_models)
    condition = random.randint(1, 5)
    mileage = random.randint(10000, 500000)

    cur.execute(
        "INSERT INTO project.Car (num, model, cond, mileage) VALUES (%s, %s, %s, %s)",
        (car_number, model, condition, mileage),
    )

conn.commit()
cur.close()
conn.close()
