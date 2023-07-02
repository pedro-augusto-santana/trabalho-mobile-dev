# this software generates random users and they post a random
# number of random reviews on randon movies
import math
import requests
import json
import random
from time import sleep

PLACEHOLDERAMT = 50 # placeholder amount
API_ADDR = 'http://localhost:5000/api'

available_movies = json.loads(requests.get(f'{API_ADDR}/movies/')
                              .content
                              .decode())

# generates PLACEHOLDERAMT of users with random credentials
users_resp = json.loads(requests.get(f'https://randomuser.me/api/?inc=login&results={PLACEHOLDERAMT}')
                  .content
                  .decode())

movies = [{'movie': a.get('id'), 'bias': random.randint(0, 100)} for a in dict(available_movies)['movies']]
users = [{ 'login': a['login']['username'], 'password': a['login']['password'] }
         for a in dict(users_resp)['results']]
words = []

# I'm not proud of this
with open('/usr/share/dict/words', 'r') as f:
    words = [str(word).strip() for word in f.readlines()]


# where the magic happens
for a in range(PLACEHOLDERAMT):
    user = random.sample(users, 1)[0]
    users.remove(user)
    print(f'[users] now has {len(users)} users on pool.')
    registration_response = requests.post(f"{API_ADDR}/auth/register/", json={'username': user['login'],
                                                     'password': user['password']})
    if registration_response.status_code != 200:
        print(f'[user] failed to create user with credentials: {user["login"]} + {user["password"]}. skipping.')
        continue

    print(f"[user] user {user['login']} registered with password {user['password']}")

    login_response = requests.post(f'{API_ADDR}/auth/login/', json={'username': user['login'],
                                                                  'password': user['password']})
    if login_response.status_code != 200:
        print('[user] failed to log user. aborting.')
        break
    user_info = json.loads(login_response.content.decode())
    review_count = random.randint(1, random.randint(2, len(movies)))
    print(f'[review] user {user["login"]} will post {review_count} reviews.')
    movies_to_review = random.sample(movies, review_count)

    for movie in movies_to_review:
        # this section calculates the movie's quality
        # simulating a bias towards the reviews
        # and adds a bit of randomness with the 0 and 100 scores
        bias = movie["bias"] # the "quality" itself from 0 to 100

        # the influence the "quality" of the movie
        # will have on each reviewer
        influence = random.uniform(1.25, 1.8)

        raw_score = random.random() * 100
        mix = random.random() * influence
        score = round(raw_score * (1 - mix) + bias * mix)
        if random.random() < 0.15:
            print('[review] movie gets 100 automatically')
            score = 100
        elif random.random() > 0.975:
            print('[review] movie gets 0 automatically')
            score = 0

        reviews = []
        for _ in range(250):
            reviews.append(' '.join(random.sample(words, random.randint(3, 50))))
        review = random.sample(reviews, 1)[0]
        reviews.remove(review)
        title = ' '.join(random.sample(words, random.randint(1, 4)))
        obj = {'user': user_info['user']['id'],
               'movie': movie["movie"],
               'score': score,
               'content': f'{review}',
               'title': f'{title}'}
        review_response = requests.post(f'{API_ADDR}/reviews/new/', json=obj)
        if review_response.status_code != 201:
            print('[review] failed to post review')
            continue
        print(f'[review] user {user_info["user"]["id"]} posted a review for movie {movie["movie"]} with a score of {score}')

