import 'dart:typed_data';

import 'package:elcriticoapp/models/studio.dart';
import 'package:elcriticoapp/pages/studios/single_studio.dart';
import 'package:flutter/material.dart';

class StudioItem extends StatelessWidget {
  final Studio studio;
  const StudioItem({super.key, required this.studio});

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
                builder: (context) => SingleStudioPage(studio: studio)),
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
                    image: MemoryImage(studio.picture ?? Uint8List(0)),
                    width: 192,
                    height: 192,
                    fit: BoxFit.fitWidth,
                  ),
                  const Divider(
                    height: 18,
                  ),
                  Text(
                    studio.name,
                    style: typography.displaySmall,
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  getReviewScoreMessage(studio, typography, palette),
                ],
              )),
        ),
      ),
    );
  }

  Text getReviewScoreMessage(
      Studio movie, TextTheme typography, ColorScheme palette) {
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
