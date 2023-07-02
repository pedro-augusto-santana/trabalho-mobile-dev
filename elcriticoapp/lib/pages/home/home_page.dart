import 'package:elcriticoapp/components/scaffold/app_scaffold.dart';
import 'package:elcriticoapp/models/review.dart';
import 'package:elcriticoapp/pages/home/review_list.dart';
import 'package:elcriticoapp/services/auth_service.dart';
import 'package:elcriticoapp/services/review_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  late Future<List<Review>> reviewList;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    reviewList = fetchReview(AuthService().user?.id ?? 0);
    final ColorScheme pallete = Theme.of(context).colorScheme;
    return AppScaffold(
      pageTitle: 'Suas Análises',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: FutureBuilder(
          future: reviewList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ReviewList(
                  reviews: snapshot.data ?? [],
                  clickableItems: true,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: pallete.error),
                ),
              );
            } else {
              return const LinearProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
