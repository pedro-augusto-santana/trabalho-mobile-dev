import abc
from services.generic_service import GenericService


class GenericController:
    """
    """
    @abc.abstractmethod
    def __init__(self, service: GenericService):
        self.service = service
