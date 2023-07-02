from sqlite3 import IntegrityError

import pymysql
from database import DBConnection
from entities.review import Review
from exceptions import UniqueConstraintViolation
from repositories.generic_repository import GenericRepository


class ReviewRepository(GenericRepository):
    """
    """

    def __init__(self):
        self.conn = DBConnection.getDB()

    def list(self, id: int):
        cursor = self.conn.cursor()
        try:
            cursor.execute('SELECT * FROM `reviews` WHERE `id` = %s', (id,))
            rows = cursor.fetchall()
        finally:
            cursor.close()
        return rows

    def persist(self, review: Review):
        cursor = self.conn.cursor()
        try:
            # first, checks for existing reviews
            cursor.execute(
                """
                    SELECT r.id FROM reviews r
                    WHERE r.user = %s
                    AND r.movie = %s
                    """,
                ([review.user, review.movie])
            )
            _review = cursor.fetchone()
            # there will always be only one review per user
            # so if it is not null, it already exists
            review_id = None
            if _review:
                review_id = dict(_review).get('id')

            cursor.execute(
                """
                REPLACE INTO reviews (id, user, movie, content, score, title)
                VALUES (%s, %s, %s, %s, %s, %s)
                """,
                ([review_id, review.user, review.movie, review.content, review.score, review.title])
            )
            self.conn.commit()
            if _review:
                return 200
            return 201

        except pymysql.err.IntegrityError:
            # in case there is another username
            raise UniqueConstraintViolation
        except Exception as e:
            raise Exception(e)
        finally:
            cursor.close()

    def score_from_movie(self, movie_id: int):
        cursor = self.conn.cursor()
        rows = []
        try:
            cursor.execute(
                """
                    SELECT AVG(score) as score, COUNT(*) as reviews FROM reviews r
                    JOIN movies m ON m.id=r.movie
                    WHERE r.movie = %s
                    """, [movie_id])
            rows = cursor.fetchone()
        finally:
            cursor.close()
        return rows

    def reviews_from_movie(self, movie_id: int, user_id: int):
        cursor = self.conn.cursor()
        rows = []
        try:
            cursor.execute(
                """
                SELECT * FROM reviews
                WHERE movie = %s
                ORDER BY CASE WHEN user = %s
                THEN 1 ELSE 2 END,
                `timestamp` DESC;
                """, (movie_id, user_id))
            rows = cursor.fetchall()
        finally:
            cursor.close()
        return rows

    def reviews_from_user(self, user_id: int):
        cursor = self.conn.cursor()
        rows = []
        try:
            cursor.execute(
                """
                    SELECT * FROM reviews r
                    WHERE r.user = %s
                    """, (user_id,))
            rows = cursor.fetchall()
        finally:
            cursor.close()
        return rows

    def score_from_studio(self, studio_id: int):
        cursor = self.conn.cursor()
        rows = []
        try:
            cursor.execute(
                """
                    SELECT AVG(score) as score, COUNT(*) as reviews FROM reviews r
                    JOIN movies m ON m.id=r.movie
                    WHERE m.studio = %s
                    """, (studio_id,))
            rows = cursor.fetchone()
        finally:
            cursor.close()
        return rows

    def score_from_director(self, director_id: int):
        cursor = self.conn.cursor()
        rows  = []
        try:
            cursor.execute(
                """
                    SELECT AVG(score) as score, COUNT(*) as reviews FROM reviews r
                    JOIN movies m ON m.id=r.movie
                    WHERE m.director = %s
                    """, (director_id,))
            rows = cursor.fetchone()
        finally:
            cursor.close()
        return rows

    def by_movie_and_user(self, movie_id, user_id):
        cursor = self.conn.cursor()
        rows = []
        try:
            cursor.execute(
                """
                    SELECT r.* FROM reviews r
                    JOIN movies m ON m.id=r.movie
                    WHERE r.movie = %s
                    AND r.user = %s
                    """, [movie_id, user_id])
            rows = cursor.fetchone()
        finally:
            cursor.close()
        return rows

