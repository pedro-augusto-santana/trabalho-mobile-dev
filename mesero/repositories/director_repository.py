from database import DBConnection
from entities.director import Director
from entities.movies import Movie
from repositories.generic_repository import GenericRepository

class DirectorRepository(GenericRepository):
    """
    """
    def __init__(self):
        self.conn = DBConnection.getDB()

    def persist(self, director: Director):
        raise NotImplementedError

    def list(self, id: int):
        cursor = self.conn.cursor()
        rows = []
        try:
            cursor.execute('SELECT * FROM directors where id = %s', (id,))
            rows = cursor.fetchone()
        finally:
            cursor.close()
        return rows

    def list_all(self, *args):
        cursor = self.conn.cursor()
        rows = []
        try:
            cursor.execute('SELECT * FROM `directors`')
            rows = cursor.fetchall()
        finally:
            cursor.close()
        return rows


