import 'dart:typed_data';

import 'package:elcriticoapp/models/director.dart';
import 'package:elcriticoapp/pages/directors/single_director.dart';
import 'package:flutter/material.dart';

class DirectorItem extends StatelessWidget {
  final Director director;
  const DirectorItem({super.key, required this.director});

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
                builder: (context) => SingleDirectorPage(director: director)),
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
                    image: MemoryImage(director.picture ?? Uint8List(0)),
                    width: 192,
                    height: 192,
                    fit: BoxFit.cover,
                  ),
                  const Divider(
                    height: 18,
                  ),
                  Text(
                    director.name,
                    style: typography.displaySmall,
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  getReviewScoreMessage(director, typography, palette),
                ],
              )),
        ),
      ),
    );
  }

  Text getReviewScoreMessage(
      Director director, TextTheme typography, ColorScheme palette) {
    if (director.reviews! == 0) {
      return Text(
        'Nenhum review ainda!',
        style: typography.labelSmall,
      );
    }
    var data = '${director.score}%';
    director.score! >= 90 ? data += ' 🏆' : null;
    return Text(
      data,
      style: typography.labelSmall!.copyWith(
          color: director.score! < 50 ? palette.error : palette.primary),
    );
  }
}
