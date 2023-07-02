import 'package:elcriticoapp/components/scaffold/app_scaffold.dart';
import 'package:elcriticoapp/models/movie.dart';
import 'package:elcriticoapp/pages/movies/movie_list.dart';
import 'package:elcriticoapp/services/movie_service.dart';
import 'package:flutter/material.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() {
    return _MoviesPage();
  }
}

class _MoviesPage extends State<MoviesPage> {
  late Future<List<Movie>> movieList;

  @override
  void initState() {
    super.initState();
    movieList = fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme pallete = Theme.of(context).colorScheme;

    return AppScaffold(
      pageTitle: 'Filmes',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: FutureBuilder(
          future: movieList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return MovieList(
                movies: snapshot.data ?? [],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}',
                  style: TextStyle(color: pallete.error));
            } else {
              return const LinearProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
