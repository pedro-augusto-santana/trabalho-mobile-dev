from database import DBConnection
from entities.studio import Studio
from entities.movies import Movie
from repositories.generic_repository import GenericRepository

class StudioRepository(GenericRepository):
    """
    """
    def __init__(self):
        self.conn = DBConnection.getDB()

    def persist(self, studio: Studio):
        raise NotImplementedError

    def list(self, id: int):
        cursor = self.conn.cursor()
        rows =  []
        try:
            cursor.execute('SELECT * FROM studios s where s.id = %s', (id,))
            rows = cursor.fetchone()
        finally:
            cursor.close()
        return rows

    def list_all(self, *args):
        cursor = self.conn.cursor()
        rows = []
        try:
            cursor.execute('SELECT * FROM studios')
            rows = cursor.fetchall()
        finally:
            cursor.close()
        return rows


