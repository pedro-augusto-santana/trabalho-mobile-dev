from flask import Response, json
from controllers.generic_controller import GenericController
from entities.user import User
from exceptions import IncorrectCredentialsException, MissingParameterException, UsernameNotFoundException
from repositories.user_repository import UserRepository
from services.auth_service import AuthService


class AuthController(GenericController):

    def __init__(self):
        self.service = AuthService()

    def register(self, user: User):
        try:
            registration_response = self.service.persist(user)
            if not registration_response.get('error'):
                return Response(json.dumps({'response': 'user was created'}),
                                status=201, mimetype="application/json")
            response_body = json.dumps(
                    {'response': registration_response.get('reason')})
            return Response(response_body, status=409, mimetype="application/json")
        except MissingParameterException:
            response_body = json.dumps(
                    {'response': "username or password fields can't be empty"})
            return Response(response_body, status=400, mimetype="application/json")

    def login(self, user: User, credentials: dict):
        try:
            user = self.service.login(user, credentials) #type: ignore
            return Response(json.dumps({'response': 'Login successful', 'user': user}),
                            status=200, mimetype="application/json")
        except MissingParameterException:
            return Response(json.dumps({'response': f'Missing required fields.'}),
                            status=400, mimetype="application/json")

        except UsernameNotFoundException:
            return Response(json.dumps({'response': 'User not found.'}),
                            status=404, mimetype="application/json")

        except IncorrectCredentialsException:
            return Response(json.dumps({'response': 'Incorrect username or password.'}),
                            status=401, mimetype="application/json")
        except Exception as e:
            return Response(json.dumps(
                {'response': f'Server error. Error: {Exception(e)}'}),
                            status=500,
                            mimetype="application/json")
