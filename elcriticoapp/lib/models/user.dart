class User {
  final int id;
  final String username;
  final String registered;
  final String hash;

  const User({
    required this.id,
    required this.username,
    required this.registered,
    required this.hash,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      username: json["username"],
      registered: json["registered"],
      hash: json["hash"],
    );
  }
}
