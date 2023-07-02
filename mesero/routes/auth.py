from flask import Blueprint, request
from werkzeug.security import generate_password_hash
from controllers.auth_controller import AuthController
from database import DBConnection
from entities.user import User

from repositories.user_repository import UserRepository
from services.auth_service import AuthService

auth = Blueprint('auth', __name__)


@auth.post('/auth/login/')
def user_login():
    data: dict = request.get_json()
    user = User(name=data.get('username', ''),
                hash=generate_password_hash(data.get('password', '')))
    return AuthController().login(user, data)


@auth.post("/auth/register/")
def user_new():
    data: dict = request.get_json()
    user = User(name=data.get('username', ''),
                hash=generate_password_hash(data.get('password', '')))
    registration_response = AuthController().register(user)
    if registration_response.status_code == 201:
        return AuthController().login(user, data)
    return registration_response
