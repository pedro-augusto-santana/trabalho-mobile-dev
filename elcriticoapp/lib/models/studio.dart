import 'dart:convert';
import 'dart:typed_data';

class Studio {
  final int id;
  final String name;
  final int foundedIn;
  final String description;
  Uint8List? picture;
  num? score;
  int? reviews;

  Studio({
    required this.id,
    required this.foundedIn,
    required this.name,
    this.picture,
    this.score,
    this.reviews,
    this.description = "",
  });

  factory Studio.fromJson(Map<String, dynamic> json) {
    return Studio(
      id: json["id"],
      foundedIn: json["founded_in"],
      description: '${json["description"]}',
      name: json["name"],
      reviews: json["reviews"] ?? 0,
      score: double.parse(json["score"] ?? '0').round(),
      picture: base64Decode(json["picture"]),
    );
  }

  @override
  String toString() {
    return """
{ id: $id, name: $name, dob: $foundedIn, bio: $description,
score: $score, reviews: $reviews}
""";
  }
}
