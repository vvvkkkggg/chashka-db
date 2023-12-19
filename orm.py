import psycopg2
from sqlalchemy import create_engine
from secrets import database_token

# Подключение к базе данных с помощью psycopg2
conn = psycopg2.connect(**database_token)

engine = create_engine('postgresql+psycopg2://your_username:your_password@your_remote_host/your_dbname')

# используем файл, сделанный в 5 задании
with open('crud.sql', 'r') as file:
    sql_queries = file.read()

# используем файл, сделанный в 6 задании
with open('analytics_queries.sql', 'r') as file:
    analytics_queries = file.read()

result = ''
with conn.cursor() as cursor:
    cursor.execute(sql_queries)
    cursor.execute(analytics_queries)
    result = cursor.fetchall()

with open('analytics_report.txt', 'w') as file:
    for row in result:
        file.write(str(row))

conn.close()