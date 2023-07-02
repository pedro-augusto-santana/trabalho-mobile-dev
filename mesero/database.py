from os import path
import pymysql.cursors
from flask import g

DATABASE = path.join(path.curdir, 'mesero.sqlite')

class DBConnection:
    """
    """
    conn = None
    @classmethod
    def getDB(cls):
        if cls.conn == None:
            cls.conn = pymysql.connect(
                    host='localhost',
                    user='pedro',
                    password='password',
                    database='mesero',
                    cursorclass=pymysql.cursors.DictCursor
                    )
        else: cls.conn.ping()
        return cls.conn

