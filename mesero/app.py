from flask import jsonify
from flask import Flask

from routes.movies import movies
from routes.directors import directors
from routes.studios import studios
from routes.auth import auth
from routes.reviews import reviews

app = Flask('mesero')

ROUTE_OPTIONS = {"url_prefix": "/api"}

app.register_blueprint(movies, **ROUTE_OPTIONS)
app.register_blueprint(directors, **ROUTE_OPTIONS)
app.register_blueprint(studios, **ROUTE_OPTIONS)
app.register_blueprint(auth, **ROUTE_OPTIONS)
app.register_blueprint(reviews, **ROUTE_OPTIONS)

if __name__ == '__main__':
    app.run('127.0.0.1', 5000)
