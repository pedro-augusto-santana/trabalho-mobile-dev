from flask import Response, json
from controllers.generic_controller import GenericController
from entities.review import Review
from repositories.review_repository import ReviewRepository
from services.auth_service import AuthService
from services.director_service import DirectorService
from services.movie_service import MovieService
from services.review_service import ReviewService
from services.studio_service import StudioService


class ReviewController(GenericController):
    def __init__(self):
        self.service = ReviewService()

    def by_id(self, id: int):
        review = self.service.by_id(id)
        if review is None:
            return Response(json.dumps({'response': f'Review <{id}> not found.'}),
                            status=404, mimetype="application/json")
        return Response(json.dumps({**review}),
                        status=200, mimetype="application/json")

    def post_review(self, review: Review):
        response = self.service.post_review(review)
        return Response(json.dumps(response), status=201, mimetype="application/json")

    def reviews_from_movie(self, movie_id: int, user_id: int = -1):
        response = self.service.reviews_from_movie(movie_id, user_id)
        if len(response) == 0:
            return Response(json.dumps({'response': []}),
                            status=204, mimetype="application/json")
        for review in response:
            movie = MovieService().by_id(review["movie"])
            user = AuthService().get_user(review["user"])
            director = DirectorService().director_by_id(movie["director"]) #type: ignore
            studio = StudioService().studio_by_id(movie["studio"]) #type: ignore
            review.update({"movie_id": movie["id"], #type: ignore
                           "movie": movie["name"],  #type: ignore
                           "user": user["username"], #type: ignore
                           "director": director["name"], #type:ignore
                           "studio": studio["name"]}) #type: ignore

        return Response(json.dumps({'reviews': [*response]}),
                        status=200, mimetype="application/json")


    def reviews_from_user(self, user_id: int):
        response = self.service.reviews_from_user(user_id)
        if len(response) == 0:
            return Response(json.dumps({'response': []}),
                            status=204, mimetype="application/json")
        for review in response:
            movie = MovieService().by_id(review["movie"])
            user = AuthService().get_user(review["user"])
            review.update({"movie_id": movie["id"], #type: ignore
                           "movie": movie["name"],  #type: ignore
                           "user": user["username"]})   #type: ignore

        return Response(json.dumps({'reviews': [*response]}),
                        status=200, mimetype="application/json")

    def get_by_movie_and_user(self, movie_id, user_id):
        response = self.service.by_movie_and_user(movie_id, user_id)
        if response == None:
            return Response(None, status=404, mimetype="application/json")

        return Response(json.dumps({'review': response}),
                        status=200, mimetype="application/json")

