from flask import Blueprint, request
from controllers.review_controller import ReviewController
from database import DBConnection
from entities.review import Review
from repositories.review_repository import ReviewRepository
from services.review_service import ReviewService


reviews = Blueprint('reviews', __name__)


@reviews.get('/reviews/<id>')
def by_id(id: int):
    return ReviewController().by_id(id)

@reviews.get('/reviews/movie/<id>')
def reviews_from_movie(id: int):
    args = request.args.to_dict()
    return ReviewController().reviews_from_movie(id,
                                                 int(args.get('user') or -1)) #type: ignore


@reviews.get('/reviews/user/<id>')
def reviews_from_user(id: int):
    return ReviewController().reviews_from_user(id)


@reviews.post('/reviews/new/')
def post_review():
    data: dict = request.get_json()
    review = Review(data.get('user', 0),
                    data.get('movie', 0),
                    data.get('score', 0),
                    data.get('content', ''),
                    data.get('title', ''))
    return ReviewController().post_review(review)

@reviews.get('/reviews/userandmovie/')
def get_review_post():
    args = request.args.to_dict()
    return ReviewController().get_by_movie_and_user(args['movie'], args['user'])
