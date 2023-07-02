import 'dart:convert';
import 'dart:typed_data';

class Movie {
  final int id;
  final String studio;
  final String description;
  final String director;
  Uint8List? cover;
  num? score;
  int? reviews;
  final int year;
  final String name;

  Movie({
    required this.id,
    required this.studio,
    required this.director,
    required this.year,
    required this.name,
    this.cover,
    this.score,
    this.reviews,
    this.description = "",
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json["id"],
      studio: '${json["studio"]}',
      year: json["year"],
      description: '${json["description"]}',
      director: '${json["director"]}',
      name: json["name"],
      reviews: json["reviews"] ?? 0,
      score: double.parse(json["score"] ?? '0').round(),
      cover: base64Decode(json["cover"]),
    );
  }

  @override
  String toString() {
    return """
{ id: $id, studio: $studio, year: $year,
director: $director,description: $description,
score: $score, reviews: $reviews}
""";
  }
}
