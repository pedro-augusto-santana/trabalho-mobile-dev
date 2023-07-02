import 'package:elcriticoapp/components/scaffold/app_scaffold.dart';
import 'package:elcriticoapp/models/director.dart';
import 'package:elcriticoapp/pages/directors/directors_list.dart';
import 'package:elcriticoapp/services/director_service.dart';
import 'package:flutter/material.dart';

class DirectorsPage extends StatefulWidget {
  const DirectorsPage({super.key});

  @override
  State<DirectorsPage> createState() {
    return _DirectorsPage();
  }
}

class _DirectorsPage extends State<DirectorsPage> {
  late Future<List<Director>> directorList;
  @override
  void initState() {
    super.initState();
    directorList = fetchDirectors();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme pallete = Theme.of(context).colorScheme;

    return AppScaffold(
      pageTitle: 'Diretores',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: FutureBuilder(
          future: directorList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return DirectorList(
                directors: snapshot.data ?? [],
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.toString(),
                  style: TextStyle(color: pallete.error));
            } else {
              return const LinearProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
