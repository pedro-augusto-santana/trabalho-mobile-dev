import 'dart:convert';
import 'dart:typed_data';

class Director {
  final int id;
  final String name;
  final int dob;
  final String bio;
  Uint8List? picture;
  num? score;
  int? reviews;
  final int? dod;

  Director({
    required this.id,
    required this.dob,
    required this.name,
    this.dod,
    this.picture,
    this.score,
    this.reviews,
    this.bio = "",
  });

  factory Director.fromJson(Map<String, dynamic> json) {
    return Director(
      id: json["id"],
      dob: json["dob"],
      dod: json["dod"],
      bio: json["bio"],
      name: json["name"],
      reviews: json["reviews"] ?? 0,
      score: double.parse(json["score"] ?? '0').round(),
      picture: base64Decode(json["picture"]),
    );
  }

  @override
  String toString() {
    return """
{ id: $id, name: $name, dob: $dob, dod: $dod,bio: $bio,
score: $score, reviews: $reviews}
""";
  }
}
