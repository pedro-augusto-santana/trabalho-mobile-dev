import 'package:elcriticoapp/models/movie.dart';
import 'package:elcriticoapp/pages/movies/movie_item.dart';
import 'package:flutter/material.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movies;
  const MovieList({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    if (movies.isNotEmpty) {
      return Scrollbar(
        child: GridView.builder(
          physics: const ClampingScrollPhysics(),
          itemCount: movies.length,
          itemBuilder: ((context, index) => MovieItem(movie: movies[index])),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 240,
              childAspectRatio: 5 / 7,
              crossAxisSpacing: 12,
              mainAxisSpacing: 0),
        ),
      );
    }
    return const Text('Nenhum filme encontrado!');
  }
}
