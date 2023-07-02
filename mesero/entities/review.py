from dataclasses import dataclass
from typing import Any, Optional
from entities.generic import GenericEntity


@dataclass
class Review(GenericEntity):
    user: int
    movie: int
    score: int
    content: Optional[str] = ""
    title: Optional[str] = ""
    id: Optional[int] = None


