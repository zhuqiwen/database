# Following tutorial from http://www.mysqltutorial.org/python-mysql/
# Adapted the example code for my own needs (still incomplete)

from mysql.connector import MySQLConnection, Error
from py_my_dbconfig import *

def main():
    books = [('Statistical Inference II', '9789449338082'),
             ('Advanced Statistics II', '9789096645436')]
    insert_books(books)

def insert_books(books):
    """Adds rows to database

        str -> none"""
    query = "INSERT INTO books(title,isbn) VALUES(%s,%s)"
    try:
        db_config = read_db_config()
        conn = MySQLConnection(**db_config)
        cursor = conn.cursor(buffered=True)
        count0 = cursor.rowcount
        cursor.executemany(query, books)
        conn.commit()
        count1 = cursor.rowcount
        print('Rows added:', str(count1 - count0))

    except Error as e:
        print('Error:', e)

    finally:
        cursor.close()
        conn.close()

    # This works but it doesn't tell me whether it was successful or not
    # I want to display a before and after count as a test:
        # print('Total Row(s):', cursor.rowcount)
    # Function calculated 3 added rows rather than 2
    # To avoid duplicate entry error, change books variable for each call

if __name__ == '__main__':
    main()

