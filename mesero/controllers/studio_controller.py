from flask import Response, json
from controllers.generic_controller import GenericController
from controllers.review_controller import ReviewController
from exceptions import EntityNotFound
from repositories.studio_repository import StudioRepository
from services.review_service import ReviewService
from services.studio_service import StudioService


class StudioController(GenericController):
    def __init__(self):
        self.service = StudioService()

    def list_all(self):
        studio_list = self.service.list_all()
        if len(studio_list) == 0:
            return Response(json.dumps({'response': []}),
                            status=204, mimetype="application/json")
        for studio in studio_list:
            reviews = ReviewService().score_from_studio(studio['id'])
            studio.update({
                'reviews': reviews['reviews'],
                'score': reviews['score']
                })
            #studio.pop('picture')
        return Response(json.dumps({'studios': [*studio_list]}),
                        status=200, mimetype="application/json")

    def by_id(self, id: int):
        studio = self.service.studio_by_id(id)
        if studio is None:
            return Response(json.dumps({'response': f'Studio <{id}> not found.'}),
                            status=404, mimetype="application/json")
        response = ReviewService().score_from_studio(id)
        return Response(json.dumps({**studio, **response}),
                        status=200, mimetype="application/json")
