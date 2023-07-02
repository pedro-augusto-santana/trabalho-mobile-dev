from entities.review import Review
from repositories.review_repository import ReviewRepository
from services.generic_service import GenericService
from services.movie_service import MovieService


class ReviewService(GenericService):
    """
    """

    def __init__(self):
        self.repository = ReviewRepository()

    def by_id(self, id: int):
        review = self.repository.list(id)
        if review is None:
            return None
        return review

    def post_review(self, review: Review):
        try:
            self.repository.persist(review)
        except Exception as e:
            raise Exception(e)

    def reviews_from_movie(self, movie_id: int, user_id: int = -1):
        response: list[dict] = []
        for review in self.repository.reviews_from_movie(movie_id, user_id):
            response.append(dict(review))
        return response

    def reviews_from_user(self, user_id: int):
        response: list[dict] = []
        for review in self.repository.reviews_from_user(user_id):
            response.append(dict(review))
        return response

    def score_from_movie(self, movie_id: int):
        return self.repository.score_from_movie(movie_id)

    def score_from_studio(self, studio_id: int):
        return self.repository.score_from_studio(studio_id)

    def score_from_director(self, director_id: int):
        return self.repository.score_from_director(director_id)

    def by_movie_and_user(self, movie_id, user_id):
        return self.repository.by_movie_and_user(movie_id, user_id)
