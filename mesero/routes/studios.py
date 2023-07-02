from flask import Blueprint
from controllers.studio_controller import StudioController
from database import DBConnection
from repositories.studio_repository import StudioRepository
from services.studio_service import StudioService

studios = Blueprint('studios', __name__)

@studios.get('/studios/')
def get_studios():
    return StudioController().list_all()

@studios.get("/studios/<id>")
def studio_by_id(id: int):
    return StudioController().by_id(id)

