from dataclasses import dataclass
from typing import Any, Optional
from entities.generic import GenericEntity

@dataclass
class User(GenericEntity):
    name: str
    hash: str
    id: Optional[int] = None
    registered: Optional[int] = None
    profile_picture: Optional[Any] = None

