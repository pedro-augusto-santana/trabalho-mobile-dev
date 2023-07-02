from flask import Blueprint
from controllers.movie_controller import MovieController
from database import DBConnection
from repositories.movie_repository import MovieRepository
from services.movie_service import MovieService

movies = Blueprint('movies', __name__)
@movies.get('/movies/')
def get_movies():
    return MovieController().list_all()

@movies.get("/movies/<movie_id>")
def get_movie_by_id(movie_id: int):
    return MovieController().by_id(movie_id)

@movies.get("/movies/from/director/", defaults={'director_id': -1})
@movies.get("/movies/from/director/<director_id>")
def get_movie_by_director(director_id: int):
    return MovieController().from_director(director_id)

@movies.get("/movies/from/studio/<studio_id>")
def get_movie_by_studio(studio_id: int):
    return MovieController().from_studio(studio_id)

