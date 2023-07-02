from dataclasses import dataclass
from typing import Any
from entities.generic import GenericEntity

@dataclass
class Movie(GenericEntity):
    id: int
    name: str
    director: int
    studio: int
    year: int
    cover: Any

