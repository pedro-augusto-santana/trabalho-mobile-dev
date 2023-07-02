import 'package:elcriticoapp/pages/auth/login_page.dart';
import 'package:elcriticoapp/pages/auth/registration_page.dart';
import 'package:elcriticoapp/pages/main/main_page.dart';
import 'package:flutter/material.dart';
import 'package:elcriticoapp/shared/app_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const ElCriticoApp());
}

class ElCriticoApp extends StatelessWidget {
  const ElCriticoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ElCriticoAppState(),
        child: MaterialApp(
          title: 'ElCritico',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
          // theme: elcriticoLightTheme,
          theme: elcriticoDarkTheme,
          initialRoute: "/auth/login",
          routes: {
            "/auth/login": (context) => const LoginPage(),
            "/auth/registration": (context) => const RegistrationPage(),
            "/home": (context) => const MainPage()
          },
        ));
  }
}

class ElCriticoAppState extends ChangeNotifier {}
