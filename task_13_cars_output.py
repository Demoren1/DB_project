import psycopg2
import matplotlib.pyplot as plt

# Подключение к базе данных
conn = psycopg2.connect(
    database="test_db",
    user="postgres",
    password="postgres",
    host="127.0.0.1",
    port="5432",
)

# Создание курсора для выполнения SQL-запросов
cur = conn.cursor()

# Получение данных о состоянии машин из таблицы Car
cur.execute("SELECT cond, COUNT(*) FROM project.Car GROUP BY cond ORDER BY cond")
results = cur.fetchall()

# Разделение результатов на состояния и их количества
conditions = [result[0] for result in results]
counts = [result[1] for result in results]

# Список цветов для каждого столбца
colors = ['skyblue', 'salmon', 'lightgreen', 'orange', 'lightblue']

# Построение гистограммы с разными цветами для столбцов
plt.bar(conditions, counts, color=colors)
plt.xlabel('Состояние', fontsize=12)
plt.ylabel('Количество', fontsize=12)
plt.title('Распределение состояний машин', fontsize=12)
plt.xticks(range(1, 6))
plt.show()

# Закрытие курсора и соединения
cur.close()
conn.close()