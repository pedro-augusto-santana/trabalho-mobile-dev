from werkzeug.security import check_password_hash
from entities.user import User
from exceptions import IncorrectCredentialsException, MissingParameterException, UniqueConstraintViolation, UsernameNotFoundException
from repositories.user_repository import UserRepository
from services.generic_service import GenericService


class AuthService(GenericService):
    """
    """

    def __init__(self):
        self.repository = UserRepository()

    def persist(self, user: User):
        try:
            if (not user.name or not user.hash):
                raise MissingParameterException
            self.repository.persist(user)
            return { 'error': False }
        except UniqueConstraintViolation:
            return {'error': True, 'reason': f'The username "{user.name}" is already taken.'}
        except Exception as e:
            raise Exception(e)

    def login(self, user: User, credentials: dict):
        if (credentials.get('username') == '' or credentials.get('password') == ''):
            raise MissingParameterException

        response = self.repository.match_credential_pair(user)
        if response == None:
            raise UsernameNotFoundException

        try:
            response = dict(response)
            success = check_password_hash(response.get(
                'hash'), credentials.get('password'))  # type:ignore
            if not success:
                raise IncorrectCredentialsException
            return response

        except IncorrectCredentialsException:
            raise IncorrectCredentialsException
        except Exception as e:
            raise Exception(e)

    def get_user(self, user_id: int):
        return dict(self.repository.list(user_id))
