from flask import Response, json
from controllers.generic_controller import GenericController
from services.director_service import DirectorService
from services.studio_service import StudioService
from services.movie_service import MovieService
from services.review_service import ReviewService


class MovieController(GenericController):
    """
    """

    def __init__(self):
        self.service = MovieService()

    def list_all(self):
        movies: list = self.service.list_all()
        for movie in movies:
            reviews = ReviewService().score_from_movie(movie["id"])
            director = DirectorService().director_by_id(movie["director"])
            studio = StudioService().studio_by_id(movie["studio"])
            movie.update({'score': reviews.get('score', None), #type: ignore
                          'reviews': reviews.get('reviews', 0), #type: ignore
                          'director': director.get('name', director['name']), # type:ignore
                          'studio': studio.get('name', movie['name']) # type:ignore
                          })

        return Response(json.dumps({'movies': [*movies]}),
                        status=200, mimetype="application/json")

    def by_id(self, id: int):
        movie = self.service.by_id(id)
        if movie is None:
            return Response(json.dumps({'response': f'Movie <{id}> not found.'}),
                            status=404, mimetype="application/json")

        reviews = ReviewService().score_from_movie(movie["id"])
        director = DirectorService().director_by_id(movie["director"])
        studio = StudioService().studio_by_id(movie["studio"])
        movie.update({'score': reviews.get('score', None), #type: ignore
                      'reviews': reviews.get('reviews', 0), #type: ignore
                      'director': director.get('name', director['name']), # type:ignore
                      'studio': studio.get('name', movie['name']) # type:ignore
                      })
        return Response(json.dumps({**movie}),
                        status=200, mimetype="application/json")

    def from_studio(self, studio_id: int):
        movies = self.service.from_studio(studio_id)
        if len(movies) == 0:
            return Response(json.dumps({'movies': []}),
                            status=204, mimetype="application/json")

        for movie in movies:
            reviews = ReviewService().score_from_movie(movie["id"])
            director = DirectorService().director_by_id(movie["director"])
            studio = StudioService().studio_by_id(movie["studio"])
            movie.update({'score': reviews.get('score', None),
                          'reviews': reviews.get('reviews', 0),
                          'director': director.get('name', movie['director']), # type:ignore
                          'studio': studio.get('name', movie['studio']) # type:ignore
                          })

        return Response(json.dumps({'movies': [*movies]}),
                        status=200, mimetype="application/json")

    def from_director(self, director_id: int):
        if (director_id == -1):
            return Response(json.dumps({'response': 'A valid Director was not provided.'}),
                            status=422, mimetype="application/json")

        movies = self.service.from_director(director_id)
        if len(movies) == 0:
            return Response(json.dumps({'movies': []}),
                            status=204, mimetype="application/json")
        for movie in movies:
            reviews = ReviewService().score_from_movie(movie["id"])
            director = DirectorService().director_by_id(movie["director"])
            studio = StudioService().studio_by_id(movie["studio"])
            movie.update({'score': reviews.get('score', None),
                          'reviews': reviews.get('reviews', 0),
                          'director': director.get('name', movie['director']), # type:ignore
                          'studio': studio.get('name', movie['studio']) # type:ignore
                          })

        return Response(json.dumps({'movies': [*movies]}),
                        status=200, mimetype="application/json")

