// ignore_for_file: use_build_context_synchronously

import 'package:elcriticoapp/models/movie.dart';
import 'package:elcriticoapp/models/review.dart';
import 'package:elcriticoapp/pages/movies/single_movie.dart';
import 'package:elcriticoapp/services/movie_service.dart';
import 'package:flutter/material.dart';

class ReviewItem extends StatelessWidget {
  final Review review;
  final bool? clickable;
  const ReviewItem({super.key, required this.review, this.clickable = false});

  @override
  Widget build(BuildContext context) {
    final ColorScheme palette = Theme.of(context).colorScheme;
    final TextTheme typography = Theme.of(context).textTheme;
    return SizedBox(
      child: InkWell(
        onTap: () async {
          if (!clickable!) return;
          Movie movie = await movieByID(review.movieID);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SingleMoviePage(movie: movie),
              ));
        },
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(2)),
          ),
          color: palette.background,
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    getReviewScoreMessage(review, typography, palette),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Text(
                        review.title,
                        style: typography.headlineMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: palette.onBackground,
                  height: 12,
                ),
                Text(
                  'Postada por ${review.user} em ${review.timestamp}',
                  style: typography.bodySmall!.copyWith(
                    color: palette.onBackground,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(review.content),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Text getReviewScoreMessage(
    Review review, TextTheme typography, ColorScheme palette) {
  var data = '${review.score}%';
  review.score >= 90 ? data += ' 🏆' : null;
  return Text(
    data,
    style: typography.labelLarge!
        .copyWith(color: review.score < 50 ? palette.error : palette.primary),
  );
}
