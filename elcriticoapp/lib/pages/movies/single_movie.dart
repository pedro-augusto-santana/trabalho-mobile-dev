import 'dart:typed_data';

import 'package:elcriticoapp/components/scaffold/app_scaffold.dart';
import 'package:elcriticoapp/models/movie.dart';
import 'package:elcriticoapp/models/review.dart';
import 'package:elcriticoapp/pages/home/review_list.dart';
import 'package:elcriticoapp/pages/review/new_review.dart';
import 'package:elcriticoapp/services/auth_service.dart';
import 'package:elcriticoapp/services/review_service.dart';
import 'package:flutter/material.dart';

class SingleMoviePage extends StatefulWidget {
  final Movie movie;
  const SingleMoviePage({super.key, required this.movie});

  @override
  State<SingleMoviePage> createState() => _SingleMoviePageState();
}

class _SingleMoviePageState extends State<SingleMoviePage> {
  late Future<List<Review>> reviewList;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    reviewList = reviewsFromMovie(widget.movie.id);
    final ColorScheme palette = Theme.of(context).colorScheme;
    final TextTheme typography = Theme.of(context).textTheme;

    return AppScaffold(
      pageTitle: widget.movie.name,
      body: RefreshIndicator(
        onRefresh: () async {
          var refreshedReviews = reviewsFromMovie(widget.movie.id);
          setState(() {
            reviewList = refreshedReviews;
          });
        },
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.memory(
                  widget.movie.cover ?? Uint8List(0),
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitWidth,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: '${widget.movie.name}\n',
                                style: typography.displayLarge),
                            TextSpan(
                                text: 'Lançamento: ${widget.movie.year}',
                                style: typography.bodyMedium!
                                    .copyWith(color: palette.onBackground))
                          ],
                        ),
                      ),
                      getReviewScoreMessage(widget.movie, typography, palette),
                      const SizedBox(height: 24),
                      Text(
                        widget.movie.description,
                        style: typography.bodyMedium!.copyWith(
                          color: palette.onBackground,
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Text('Diretor: '),
                          InkWell(
                            child: Text(widget.movie.director),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Text('Estúdio: '),
                          InkWell(
                            child: Text(widget.movie.studio),
                          )
                        ],
                      ),
                      const Divider(height: 12),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                    child: FutureBuilder(
                      future: reviewList,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ReviewList(
                            reviews: snapshot.data ?? [],
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
                    )),
              ],
            ),
          ),
        ),
      ),
      floatingButton: FloatingActionButton(
          child: const Icon(
            Icons.add_comment_sharp,
          ),
          onPressed: () async {
            final response = await getUserReviewForMovie(
              AuthService().user!.id,
              widget.movie.id,
            );
            // ignore: use_build_context_synchronously
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewReview(
                  review: response,
                  movie: widget.movie,
                ),
              ),
            );
          }),
    );
  }
}

Widget getReviewScoreMessage(
  Movie movie,
  TextTheme typography,
  ColorScheme palette,
) {
  if (movie.reviews == 0) return const Text('');
  var data = '${movie.score}%';
  movie.score! >= 90 ? data += ' 🏆' : null;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 12),
      Text(
        data,
        style: typography.displayLarge!.copyWith(
            color: movie.score! < 50 ? palette.error : palette.primary),
      ),
      Text('Baseado em ${movie.reviews} análises.'),
    ],
  );
}
