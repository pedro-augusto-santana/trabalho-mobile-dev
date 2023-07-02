import 'package:elcriticoapp/components/navbar/bottom_navbar.dart';
import 'package:elcriticoapp/pages/directors/directors_page.dart';
import 'package:elcriticoapp/pages/home/home_page.dart';
import 'package:elcriticoapp/pages/movies/movies_page.dart';
import 'package:elcriticoapp/pages/studios/studios_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

const items = <NavigationDestination>[
  NavigationDestination(
    icon: Icon(Icons.home_rounded),
    label: 'Suas Análises',
  ),
  NavigationDestination(
    icon: Icon(Icons.movie_filter_sharp),
    label: 'Filmes',
  ),
  NavigationDestination(
    icon: Icon(Icons.person_sharp),
    label: 'Diretores',
  ),
  NavigationDestination(
    icon: Icon(Icons.castle_sharp),
    label: 'Estúdios',
  ),
];

class _MainPageState extends State<MainPage> {
  // ignore: prefer_final_fields
  int _currentPage = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          onPageChanged: (value) => setState(() {
            _currentPage = value;
          }),
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: const [
            HomePage(),
            MoviesPage(),
            DirectorsPage(),
            StudiosPage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavbar(
        items: items,
        onDestinationSelect: (page) {
          pageController.jumpToPage(page);
        },
      ),
    );
  }
}
