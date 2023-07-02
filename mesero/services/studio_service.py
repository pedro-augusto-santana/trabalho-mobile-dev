from typing import Union
import base64
import helpers
from repositories.studio_repository import StudioRepository
from services.generic_service import GenericService


class StudioService(GenericService):
    """
    """

    def __init__(self):
        self.repository = StudioRepository()

    def get_studio_score(self, id: int):
        ...

    def studio_by_id(self, id: int) -> Union[dict, None]:
        studio = self.repository.list(id)
        if studio is None:
            return None
        studio = helpers.blob_to_64(studio, 'picture')
        return dict(studio)

    def studio_movies(self, id: int):
        pass

    def list_all(self):
        # NOTE: this is fucking atrocious
        # performance sucks
        # legibility sucks
        # would like be better with separate queries for each one
        # but this is not a problem for now
        response: list[dict] = []
        for _studio in self.repository.list_all():
            response.append(helpers.blob_to_64(_studio, 'picture'))
        return response
