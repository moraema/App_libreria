import 'package:flutter/material.dart';
import 'package:libreria/features/login/presentation/widgets/login_header.dart';
import 'package:libreria/features/login/presentation/widgets/login_form.dart';
import 'package:libreria/features/login/presentation/widgets/login_actions.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5E6),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const LoginHeader(),
            const SizedBox(height: 32),
            const Text(
              'Bienvenido de nuevo',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                children: [
                  LoginForm(
                    emailController: emailController,
                    passwordController: passwordController,
                  ),
                  const SizedBox(height: 8),
                  LoginActions(
                    emailController: emailController,
                    passwordController: passwordController,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
