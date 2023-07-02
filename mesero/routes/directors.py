from flask import Blueprint
from controllers.director_controller import DirectorController
from database import DBConnection
from repositories.director_repository import DirectorRepository
from services.director_service import DirectorService

directors = Blueprint('directors', __name__)

@directors.get('/directors/')
def get_directors():
    controller = DirectorController()
    return controller.list_all()

@directors.get("/directors/<id>")
def get_director(id: int):
    controller = DirectorController()
    return controller.by_id(id)

