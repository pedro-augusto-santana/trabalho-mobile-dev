// ignore_for_file: use_build_context_synchronously

import 'package:elcriticoapp/components/scaffold/app_scaffold.dart';
import 'package:elcriticoapp/services/auth_service.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
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
                    "Seja bem vindo!",
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
          'Cadastro',
          style: typography.displayLarge,
        ),
        Text(
          'Digite seus dados!',
          style: typography.bodyLarge,
        ),
        const SizedBox(
          height: 18,
        ),
        TextFormField(
          controller: userName,
          decoration: InputDecoration(
              hintText: 'Username',
              hintStyle: TextStyle(color: pallete.onTertiary.withOpacity(0.3))),
        ),
        const SizedBox(
          height: 8.0,
        ),
        TextFormField(
          controller: password,
          decoration: InputDecoration(
            hintText: 'Password',
            hintStyle: TextStyle(color: pallete.onTertiary.withOpacity(0.3)),
          ),
          obscureText: true,
        ),
        const SizedBox(
          height: 8.0,
        ),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    final success = await authService.register(
                        userName.text, password.text);
                    if (success['success'] == true) {
                      Navigator.popUntil(context, (route) => route.isFirst);
                      Navigator.pop(context);
                      // this one is needed to make the new page the
                      // root of the navigation tree
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
                  child: const Text('Criar Conta!')),
              const SizedBox(
                height: 12,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Text('Já possui conta? Fazer Login'),
              ),
            ],
          ),
        )
      ],
    );
  }
}
