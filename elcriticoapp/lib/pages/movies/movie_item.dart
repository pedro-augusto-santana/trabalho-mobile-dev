import 'dart:typed_data';

import 'package:elcriticoapp/models/movie.dart';
import 'package:elcriticoapp/pages/movies/single_movie.dart';
import 'package:flutter/material.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;
  const MovieItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final ColorScheme palette = Theme.of(context).colorScheme;
    final TextTheme typography = Theme.of(context).textTheme;
    return SizedBox(
      height: 192,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SingleMoviePage(movie: movie)),
          );
        },
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(2)),
          ),
          color: palette.background,
          elevation: 1,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image(
                    image: MemoryImage(movie.cover ?? Uint8List(0)),
                    width: 192,
                    height: 192,
                    fit: BoxFit.cover,
                  ),
                  const Divider(
                    height: 18,
                  ),
                  Text(
                    movie.name,
                    style: typography.displaySmall,
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  getReviewScoreMessage(movie, typography, palette),
                ],
              )),
        ),
      ),
    );
  }

  Text getReviewScoreMessage(
      Movie movie, TextTheme typography, ColorScheme palette) {
    if (movie.reviews! == 0) {
      return Text(
        'Nenhum review ainda!',
        style: typography.labelSmall,
      );
    }
    var data = '${movie.score}%';
    movie.score! >= 90 ? data += ' 🏆' : null;
    return Text(
      data,
      style: typography.labelSmall!
          .copyWith(color: movie.score! < 50 ? palette.error : palette.primary),
    );
  }
}
