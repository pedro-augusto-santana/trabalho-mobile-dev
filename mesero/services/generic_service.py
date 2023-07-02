import abc
from repositories.generic_repository import GenericRepository

class GenericService:
    @abc.abstractmethod
    def __init__(self, repository: GenericRepository):
        self.repository = repository

