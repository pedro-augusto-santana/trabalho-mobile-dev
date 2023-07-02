import 'package:elcriticoapp/models/review.dart';
import 'package:elcriticoapp/pages/home/review_item.dart';
import 'package:flutter/material.dart';

class ReviewList extends StatelessWidget {
  final List<Review> reviews;
  final bool clickableItems;
  const ReviewList(
      {super.key, required this.reviews, this.clickableItems = false});

  @override
  Widget build(BuildContext context) {
    if (reviews.isNotEmpty) {
      return Scrollbar(
        child: ListView.builder(
          physics: const ClampingScrollPhysics(),
          itemCount: reviews.length,
          itemBuilder: ((context, index) => ReviewItem(
                review: reviews[index],
                clickable: clickableItems,
              )),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
        ),
      );
    }
    return const Text('Nenhuma avaliação ainda!');
  }
}
