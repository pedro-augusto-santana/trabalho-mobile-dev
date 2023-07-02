from dataclasses import dataclass
from typing import Any
from entities.generic import GenericEntity


@dataclass
class Director(GenericEntity):
    id: int
    name: str
    dob: int
    dod: int
    picture: Any # type this later
