import abc
from entities.generic import GenericEntity

class GenericRepository:
    @abc.abstractmethod
    def persist(self, entity: GenericEntity):
        raise NotImplemented

    @abc.abstractmethod
    def list(self, id: int):
        raise NotImplemented

    @abc.abstractmethod
    def list_all(self, *args):
        raise NotImplemented

    @abc.abstractmethod
    def update(self, entity: GenericEntity):
        raise NotImplemented

