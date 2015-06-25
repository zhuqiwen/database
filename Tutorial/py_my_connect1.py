# Following tutorial from http://www.mysqltutorial.org/python-mysql/

import mysql.connector
from mysql.connector import Error


def connect():
    """Connect to MySQL database

        none -> none"""
    try:
        conn = mysql.connector.connect(host='localhost',
                                       database='python_mysql',
                                       user='root',
                                       password='')
        # conn is a MySQLConnection object
        if conn.is_connected():
            print('Connected to MySQL database')

    except Error as e:
        print(e)

    finally:
        conn.close()

    # We don't like this because credentials are saved in the function def

if __name__ == '__main__':
    connect()
