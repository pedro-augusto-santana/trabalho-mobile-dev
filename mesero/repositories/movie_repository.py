from database import DBConnection
from entities.movies import Movie
from repositories.generic_repository import GenericRepository


class MovieRepository(GenericRepository):
    """
    """

    def __init__(self):
        self.conn = DBConnection.getDB()

    def persist(self, movie: Movie):
        raise NotImplementedError

    def list(self, id: int):
        cursor = self.conn.cursor()
        try:
            cursor.execute('SELECT * FROM `movies` WHERE `id` = %s', (id,))
            rows = cursor.fetchone()
        finally:
            cursor.close()
        return rows

    def list_all(self):
        cursor = self.conn.cursor()
        rows =  []
        try:
            cursor.execute(
                    """
                    SELECT m.*, AVG(r.score) as score FROM movies m
                    LEFT JOIN reviews r ON r.movie = m.id
                    GROUP BY m.id
                    ORDER BY ISNULL(AVG(r.score)), AVG(r.score) DESC, m.year DESC;
                    """)
            rows = cursor.fetchall()
        finally:
            cursor.close()
        return rows

    def from_studio(self, studio_id: int):
        cursor = self.conn.cursor()
        rows = []
        try:
            cursor.execute(
                """
                SELECT m.*, AVG(r.score) as score FROM movies m
                LEFT JOIN reviews r ON r.movie = m.id
                WHERE m.studio = %s
                GROUP BY m.id
                ORDER BY ISNULL(AVG(r.score)), AVG(r.score) DESC, m.year DESC;
                """, (studio_id,))
            rows = cursor.fetchall()
        finally:
            cursor.close()
        return rows

    def from_director(self, director_id: int):
        cursor = self.conn.cursor()
        rows = []
        try:
            cursor.execute(
                """
                SELECT m.*, AVG(r.score) as score FROM movies m
                LEFT JOIN reviews r ON r.movie = m.id
                WHERE m.director = %s
                GROUP BY m.id
                ORDER BY ISNULL(AVG(r.score)), AVG(r.score) DESC, m.year DESC;
                """, (director_id,))
            rows = cursor.fetchall()
        finally:
            cursor.close()
        return rows
