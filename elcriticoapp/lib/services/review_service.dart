import 'dart:convert';

import 'package:elcriticoapp/models/review.dart';
import 'package:elcriticoapp/services/auth_service.dart';
import 'package:elcriticoapp/shared/constants.dart';
import 'package:http/http.dart' as http;

Future<List<Review>> fetchReview(int id) async {
  final response = await http
      .get(Uri.parse('$apiURL/reviews/user/${AuthService().user?.id ?? 0}'));
  if (response.statusCode == 200) {
    var json = jsonDecode(response.body)["reviews"];
    List<Review> reviews = [];
    for (var review in json) {
      reviews.add(Review.fromJson(review));
    }
    return reviews;
  }
  return [];
}

Future<List<Review>> reviewsFromMovie(int movieId) async {
  final response = await http.get(
      Uri.parse('$apiURL/reviews/movie/$movieId&${AuthService().user!.id}'));
  if (response.statusCode == 200) {
    var json = jsonDecode(response.body)["reviews"];
    List<Review> reviews = [];
    for (var review in json) {
      reviews.add(Review.fromJson(review));
    }
    return reviews;
  }
  return [];
}

Future<Review?> getUserReviewForMovie(int userID, int movieID) async {
  final response = await http.get(
      Uri.parse('$apiURL/reviews/userandmovie/?user=$userID&movie=$movieID'));
  if (response.statusCode == 200) {
    Review review = Review.fromJson(jsonDecode(response.body)["review"]);
    return review;
  }
  return null;
}

Future<bool> postReview(Review review) async {
  final response = await http.post(Uri.parse('$apiURL/reviews/new/'),
      body: jsonEncode({
        "movie": review.movieID,
        "user": review.user,
        "content": review.content,
        "score": review.score,
        "title": review.title
      }),
      headers: {
        'Content-Type': 'application/json',
      });
  if (response.statusCode == 201) {
    return true;
  }
  return false;
}
