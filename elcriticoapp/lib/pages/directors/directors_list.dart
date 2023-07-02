import 'package:elcriticoapp/models/director.dart';
import 'package:elcriticoapp/pages/directors/director_item.dart';
import 'package:flutter/material.dart';

class DirectorList extends StatelessWidget {
  final List<Director> directors;
  const DirectorList({super.key, required this.directors});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: GridView.builder(
        itemCount: directors.length,
        itemBuilder: ((context, index) =>
            DirectorItem(director: directors[index])),
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
