from sqlite3 import Connection, IntegrityError

import pymysql
from database import DBConnection
from entities.user import User
from exceptions import UniqueConstraintViolation
from repositories.generic_repository import GenericRepository

class UserRepository(GenericRepository):
    """
    """
    def __init__(self):
        self.conn = DBConnection.getDB()

    def persist(self, user: User):
        cursor = self.conn.cursor()
        try:
            cursor.execute("INSERT INTO `users` (`username`, `hash`) VALUES (%s, %s)", (user.name, user.hash))
            self.conn.commit()
        except pymysql.err.IntegrityError:
            # in case there is another username
            raise UniqueConstraintViolation
        except Exception as e:
            raise Exception(e)
        finally:
            cursor.close()
        return True

    def match_credential_pair(self, user: User):
        cursor = self.conn.cursor()
        rows = []
        try:
            cursor.execute('SELECT * FROM `users` WHERE `username` = %s', (user.name,))
            rows = cursor.fetchone()
        except Exception as e:
            raise Exception(e)
        finally:
            cursor.close()
        return rows

    def list(self, id: int):
        cursor = self.conn.cursor()
        rows = []
        try:
            cursor.execute('SELECT * FROM `users` WHERE `id` = %s', (id,))
            rows = cursor.fetchone()
        except Exception as e:
            raise Exception(e)
        finally:
            cursor.close()
        return rows




