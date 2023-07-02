import 'package:elcriticoapp/components/scaffold/app_scaffold.dart';
import 'package:elcriticoapp/models/studio.dart';
import 'package:elcriticoapp/pages/studios/studio_list.dart';
import 'package:elcriticoapp/services/studio_service.dart';
import 'package:flutter/material.dart';

class StudiosPage extends StatefulWidget {
  const StudiosPage({super.key});

  @override
  State<StudiosPage> createState() {
    return _StudiosPage();
  }
}

class _StudiosPage extends State<StudiosPage> {
  late Future<List<Studio>> studioList;

  @override
  void initState() {
    super.initState();
    studioList = fetchStudios();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme pallete = Theme.of(context).colorScheme;
    return AppScaffold(
      pageTitle: 'Estúdios',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: FutureBuilder(
          future: studioList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return StudioList(
                studios: snapshot.data ?? [],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot}',
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
