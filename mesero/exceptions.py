class EntityNotFound(Exception):
    """The provided ID was not found on the database."""

class InsertionFailedException(Exception):
    """Failed to insert the data as provided"""

class UniqueConstraintViolation(Exception):
    """Unique constraint was violated"""

class MissingParameterException(Exception):
    """Missing required parameter on request body"""

class UsernameNotFoundException(Exception):
    """The user is not registered"""

class IncorrectCredentialsException(Exception):
    """Invalid credentials"""
