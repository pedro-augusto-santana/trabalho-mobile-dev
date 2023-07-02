class Review {
  final String id;
  final String user;
  final String movieID;
  final int score;
  final String content;
  final String title;
  final String movie;
  final String timestamp;

  const Review({
    this.id = "",
    required this.user,
    required this.movieID,
    required this.score,
    this.movie = "",
    this.title = "",
    this.timestamp = "",
    this.content = "",
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
        id: '${json["id"]}',
        user: '${json["user"]}',
        movieID: '${json["movie_id"]}',
        title: json["title"].isEmpty
            ? 'Análise de ${json["user"]}'
            : '${json["title"]}',
        movie: '${json["movie"]}',
        content: json["content"],
        score: json["score"],
        timestamp: '${json["timestamp"]}');
  }

  @override
  String toString() {
    return "{ id: $id, user: $user, movie: $movie, movieID: $movieID, score: $score, content: $content }";
  }
}
