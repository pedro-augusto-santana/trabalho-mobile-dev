import 'package:elcriticoapp/models/studio.dart';
import 'package:elcriticoapp/pages/studios/studio_item.dart';
import 'package:flutter/material.dart';

class StudioList extends StatelessWidget {
  final List<Studio> studios;
  const StudioList({super.key, required this.studios});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: GridView.builder(
        itemCount: studios.length,
        itemBuilder: ((context, index) {
          return StudioItem(studio: studios[index]);
        }),
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
}
