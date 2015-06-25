# Following tutorial from http://www.mysqltutorial.org/python-mysql/
# This tutorial section demonstrates the Cursor class and some of its methods
# Adapted the example code for my own needs

from mysql.connector import MySQLConnection, Error
from py_my_dbconfig import *

def query_row(table):
    """Returns the next row of a query result set or None

        str -> tuple"""
    try:
        dbconfig = read_db_config() #returns a dict of connection parameters
        print('Connecting ' + dbconfig['user'] + ' to ' +
              dbconfig['database'] + '...')
        conn = MySQLConnection(**dbconfig)
        if conn.is_connected():
            print('Connection established.')
        else:
            print('Connection failed')

        cursor = conn.cursor(buffered=True)
        sql_command = 'SELECT * FROM ' + table
        print('Executed command: ' + sql_command + '.')
        cursor.execute(sql_command)

        row = cursor.fetchone()
        return row

        # The fetchall method is similar but memory-consuming
        # rows = cursor.fetchall()
        # print('Total rows:', cursor.rowcount)
        # return rows

    except Error as e:
        print(e)
    finally:
        cursor.close()
        conn.close()

# We can query several rows at a time with fetchmany to save memory

# Create a generator (used by 'for' in a loop) based on fetchmany
def iter_row(cursor, size = 10):
    """Chunks database into a series of rows

    Cursor object, int -> generator object"""
    while True:
        rows = cursor.fetchmany(size)
        if not rows:
            break
        for row in rows:
            yield row

def query_with_fetchmany():
    #Copied from the tutorial; I don't like it but included it for reference
    #Table name should be a variable rather than embedded in the function
    try:
        dbconfig = read_db_config()
        conn = MySQLConnection(**dbconfig)
        cursor = conn.cursor(buffered=True)

        cursor.execute('SELECT * FROM books')

        for row in iter_row(cursor, 10):
            print(row)
    except Error as e:
        print(e)
    finally:
        cursor.close()
        conn.close()

if __name__ == '__main__':
    row1 = query_row('books')
    print(row1)
    print(type(row1))
    query_with_fetchmany()
