from typing import Union
import base64
import helpers
from repositories.director_repository import DirectorRepository
from services.generic_service import GenericService


class DirectorService(GenericService):
    """
    """

    def __init__(self):
        self.repository = DirectorRepository()

    def director_by_id(self, id: int) -> Union[dict, None]:
        director = self.repository.list(id)
        if director is None:
            return None
        director = helpers.blob_to_64(director, 'picture')
        return dict(director)

    def list_all(self):
        response: list[dict] = []
        for _director in self.repository.list_all():
            response.append(helpers.blob_to_64(_director, 'picture'))
        return response
