# Following tutorial from http://www.mysqltutorial.org/python-mysql/

from mysql.connector import MySQLConnection, Error
from py_my_dbconfig import read_db_config

def connect():
    """Connect to MySQL database

        none -> none"""
    db_config = read_db_config()
    try:
        print('Connecting to MySQL database...')
        conn = MySQLConnection(**db_config)
        if conn.is_connected():
            print('Connection established.')
        else:
            print('Connection failed.')
    except Error as e:
        print(e)
    finally:
        conn.close()
        print('Connection closed.')

    # This does not return anything.



if __name__ == '__main__':
    connect()
