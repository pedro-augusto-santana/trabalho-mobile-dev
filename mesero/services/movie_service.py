import helpers
from repositories.movie_repository import MovieRepository
from services.generic_service import GenericService

class MovieService(GenericService):
    """
    """
    def __init__(self):
        self.repository = MovieRepository()

    def get_movie_score(self, id: int):
        ...

    def by_id(self, id: int):
        movie = self.repository.list(id)
        if movie is None:
            return None
        movie = helpers.blob_to_64(dict(movie), 'cover')
        return dict(movie)

    def get_movie_reviews(self, id: int):
        pass

    def list_all(self):
        response: list[dict] = []
        for movie in self.repository.list_all():
            response.append(helpers.blob_to_64(movie, 'cover'))
        return response

    def from_studio(self, studio_id: int):
        response: list[dict] = []
        for movie in self.repository.from_studio(studio_id):
            response.append(helpers.blob_to_64(movie, 'cover'))
        return response

    def from_director(self, director_id: int):
        response: list[dict] = []
        for movie in self.repository.from_director(director_id):
            response.append(helpers.blob_to_64(movie, 'cover'))
        return response

