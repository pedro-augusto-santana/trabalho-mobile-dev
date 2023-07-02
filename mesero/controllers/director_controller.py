from flask import Response, json
from controllers.generic_controller import GenericController
from controllers.review_controller import ReviewController
from exceptions import EntityNotFound
from repositories.director_repository import DirectorRepository
from services.director_service import DirectorService
from services.review_service import ReviewService


class DirectorController(GenericController):
    def __init__(self):
        self.service = DirectorService()

    def list_all(self):
        director_list = self.service.list_all()
        if len(director_list) == 0:
            return Response(json.dumps({'directors': []}),
                            status=204, mimetype="application/json")
        for director in director_list:
            response = ReviewService().score_from_director(director["id"])
            director.update({'score': response.get('score', None),
                             'reviews': response.get('reviews', 0)})

        return Response(json.dumps({'directors': [*director_list]}),
                        status=200, mimetype="application/json")

    def by_id(self, id: int):
        director = self.service.director_by_id(id)
        if director is None:
            return Response(json.dumps({'response': f'Director <{id}> not found.'}),
                            status=404, mimetype="application/json")

        response = ReviewService().score_from_director(id)
        director.update({'score': response.get('score', None),
                         'reviews': response.get('reviews', 0)})
        return Response(json.dumps({**director}),
                        status=200, mimetype="application/json")
