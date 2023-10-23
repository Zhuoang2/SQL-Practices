import mysql.connector

connection = mysql.connector.connect(host = '',
                                     port = '',
                                     user = '',
                                     password = '',
                                     database = '')

cursor = connection.cursor()
# cursor.execute("create database `create_new_database`;")
# cursor.execute("show databases;")
# record = cursor.fetchall()
# for r in record:
#     print(r)
# cursor.execute("use sql_practice;")

# cursor.execute("select * from `branch`;")
# record = cursor.fetchall()
# for r in record:
#     print(r)

cursor.close()
# conncection.commit()
connection.close()