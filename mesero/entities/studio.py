from dataclasses import dataclass
from typing import Any
from entities.generic import GenericEntity


@dataclass
class Studio(GenericEntity):
    id: int
    name: str
    founded_in: int
    picture: Any

