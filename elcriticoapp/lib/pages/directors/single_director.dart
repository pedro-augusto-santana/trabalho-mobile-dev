import 'dart:typed_data';

import 'package:elcriticoapp/components/scaffold/app_scaffold.dart';
import 'package:elcriticoapp/models/director.dart';
import 'package:elcriticoapp/models/movie.dart';
import 'package:elcriticoapp/pages/movies/movie_list.dart';
import 'package:elcriticoapp/services/movie_service.dart';
import 'package:flutter/material.dart';

class SingleDirectorPage extends StatefulWidget {
  final Director director;
  const SingleDirectorPage({super.key, required this.director});

  @override
  State<SingleDirectorPage> createState() => _SingleDirectorPageState();
}

class _SingleDirectorPageState extends State<SingleDirectorPage> {
  late Future<List<Movie>> movieList;

  @override
  void initState() {
    super.initState();
    movieList = moviesFromDirector(widget.director.id);
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme palette = Theme.of(context).colorScheme;
    final TextTheme typography = Theme.of(context).textTheme;

    return AppScaffold(
      pageTitle: widget.director.name,
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.memory(
                widget.director.picture ?? Uint8List(0),
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitWidth,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: '${widget.director.name}\n',
                              style: typography.displayLarge),
                          TextSpan(
                            text: 'Ano de nascimento: ${widget.director.dob}\n',
                            style: typography.bodyMedium!.copyWith(
                              color: palette.onBackground,
                            ),
                          ),
                          TextSpan(
                            text:
                                'Ano de falecimento: ${widget.director.dod ?? "-"}',
                            style: typography.bodyMedium!.copyWith(
                              color: palette.onBackground,
                            ),
                          )
                        ],
                      ),
                    ),
                    const Divider(height: 24),
                    Text(
                      widget.director.bio,
                      style: typography.bodyMedium!.copyWith(
                        color: palette.onBackground,
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const Divider(height: 16),
                    Text(
                      'Filmes de ${widget.director.name}',
                      style: typography.bodyLarge,
                    ),
                    const SizedBox(height: 16),
                    FutureBuilder(
                      future: movieList,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return MovieList(
                            movies: snapshot.data ?? [],
                          );
                        } else if (snapshot.hasError) {
                          return Text(
                            '${snapshot.error}',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: palette.error),
                          );
                        } else {
                          return const LinearProgressIndicator();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
