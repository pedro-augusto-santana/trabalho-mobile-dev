// ignore_for_file: use_build_context_synchronously

import 'package:elcriticoapp/components/scaffold/app_scaffold.dart';
import 'package:elcriticoapp/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController username = TextEditingController();
    TextEditingController password = TextEditingController();
    final authService = AuthService();

    final TextTheme typography = Theme.of(context).textTheme;
    return AppScaffold(
        pageTitle: "",
        body: Center(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "El Critico",
                    style: typography.displayLarge!.copyWith(fontSize: 48),
                  ),
                  Text(
                    "Avalie seus filmes favoritos!",
                    style: typography.bodySmall,
                  ),
                  const SizedBox(height: 64),
                  FormItems(
                      userName: username,
                      password: password,
                      authService: authService)
                ],
              ),
            )
          ]),
        ));
  }
}

class FormItems extends StatelessWidget {
  const FormItems({
    super.key,
    required this.userName,
    required this.password,
    required this.authService,
  });

  final TextEditingController userName;
  final TextEditingController password;
  final AuthService authService;

  @override
  Widget build(BuildContext context) {
    final ColorScheme pallete = Theme.of(context).colorScheme;
    final TextTheme typography = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Login',
          style: typography.displayLarge,
        ),
        const SizedBox(
          height: 18,
        ),
        TextFormField(
          controller: userName,
          decoration: InputDecoration(
              labelText: 'Username',
              labelStyle:
                  TextStyle(color: pallete.onTertiary.withOpacity(0.3))),
        ),
        const SizedBox(
          height: 8.0,
        ),
        TextFormField(
          controller: password,
          decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: TextStyle(color: pallete.onTertiary.withOpacity(0.3)),
          ),
          obscureText: true,
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  final success =
                      await authService.login(userName.text, password.text);
                  if (success['success'] == true) {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/home');
                    return;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      elevation: 1,
                      backgroundColor: pallete.errorContainer,
                      content: Text('${success['reason']}'),
                    ),
                  );
                },
                child: const Text('Login')),
            const SizedBox(
              width: 8.0,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/auth/registration');
              },
              child: const Text('Criar Conta!'),
            ),
          ],
        )
      ],
    );
  }
}
