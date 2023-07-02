import 'dart:convert';
import 'package:elcriticoapp/models/movie.dart';
import 'package:elcriticoapp/shared/constants.dart';
import 'package:http/http.dart' as http;

Future<List<Movie>> fetchMovies() async {
  final response = await http.get(Uri.parse('$apiURL/movies/'));
  if (response.statusCode == 200) {
    var movieList = jsonDecode(response.body)["movies"];
    List<Movie> movies = [];
    for (var movie in movieList) {
      movies.add(Movie.fromJson(movie));
    }
    return movies;
  }
  return [];
}

Future<Movie> movieByID(movieID) async {
  final response = await http.get(Uri.parse('$apiURL/movies/$movieID'));
  if (response.statusCode == 200) {
    return Movie.fromJson(jsonDecode(response.body));
  }
  return Movie.fromJson({});
}

Future<List<Movie>> moviesFromDirector(directorID) async {
  final response =
      await http.get(Uri.parse('$apiURL/movies/from/director/$directorID'));
  if (response.statusCode == 200) {
    var movieList = jsonDecode(response.body)["movies"];
    List<Movie> movies = [];
    for (var movie in movieList) {
      movies.add(Movie.fromJson(movie));
    }
    return movies;
  }
  return [];
}

Future<List<Movie>> moviesFromStudio(studioID) async {
  final response =
      await http.get(Uri.parse('$apiURL/movies/from/studio/$studioID'));
  if (response.statusCode == 200) {
    var movieList = jsonDecode(response.body)["movies"];
    List<Movie> movies = [];
    for (var movie in movieList) {
      movies.add(Movie.fromJson(movie));
    }
    return movies;
  }
  return [];
}
