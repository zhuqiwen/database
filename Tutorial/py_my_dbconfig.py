# Following tutorial from http://www.mysqltutorial.org/python-mysql/

from configparser import ConfigParser

def read_db_config(filename='config.ini', section='mysql'):
    """Returns parameters from database configuration file

    str, str -> dict"""
    parser = ConfigParser()
    parser.read(filename)
    db = {}
    if parser.has_section(section):
        items = parser.items(section)
        for item in items:
            db[item[0]] = item[1]
    else:
        raise Exception('{0} not found in the {1} file'.format(section,
                                                               filename))
    return db
