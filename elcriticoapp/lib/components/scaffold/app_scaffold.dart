import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final String pageTitle;
  final Widget? body;
  final FloatingActionButton? floatingButton;

  const AppScaffold({
    super.key,
    this.body,
    this.pageTitle = "Blank Page",
    this.floatingButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          pageTitle,
          style: Theme.of(context).textTheme.displayMedium,
          textAlign: TextAlign.start,
        ),
      ),
      body: body,
      floatingActionButton: floatingButton,
      resizeToAvoidBottomInset: false,
    );
  }
}
