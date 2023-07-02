import 'dart:typed_data';

import 'package:elcriticoapp/components/scaffold/app_scaffold.dart';
import 'package:elcriticoapp/models/movie.dart';
import 'package:elcriticoapp/models/studio.dart';
import 'package:elcriticoapp/pages/movies/movie_list.dart';
import 'package:elcriticoapp/services/movie_service.dart';
import 'package:flutter/material.dart';

class SingleStudioPage extends StatefulWidget {
  final Studio studio;
  const SingleStudioPage({super.key, required this.studio});

  @override
  State<SingleStudioPage> createState() => _SingleStudioPageState();
}

class _SingleStudioPageState extends State<SingleStudioPage> {
  late Future<List<Movie>> movieList;

  @override
  void initState() {
    super.initState();
    movieList = moviesFromStudio(widget.studio.id);
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme palette = Theme.of(context).colorScheme;
    final TextTheme typography = Theme.of(context).textTheme;

    return AppScaffold(
      pageTitle: widget.studio.name,
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.memory(
                widget.studio.picture ?? Uint8List(0),
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitWidth,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(TextSpan(
                      children: [
                        TextSpan(
                            text: '${widget.studio.name}\n',
                            style: typography.displayLarge),
                        TextSpan(
                            text: 'Fundado em: ${widget.studio.foundedIn}',
                            style: typography.bodyMedium!
                                .copyWith(color: palette.onBackground))
                      ],
                    )),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      widget.studio.description,
                      style: typography.bodyMedium!.copyWith(
                        color: palette.onBackground,
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const Divider(
                      height: 32,
                    ),
                    Text(
                      'Filmes de ${widget.studio.name}',
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
