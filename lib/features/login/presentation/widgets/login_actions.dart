import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:libreria/core/router/domain/constants/router_constants.dart';
import 'package:libreria/features/login/domain/entities/login_user.dart';
import 'package:libreria/features/login/presentation/cubit/login_cubit.dart';
import 'package:libreria/features/login/presentation/cubit/login_state.dart';

class LoginActions extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginActions({
    Key? key,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              context.go(RouterConstants.home);
            } else if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is LoginLoading;
            return SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE56E1A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  elevation: 0,
                ),
                onPressed: isLoading
                    ? null
                    : () {
                        final email = emailController.text.trim();
                        final password = passwordController.text.trim();
                        final loginUser = LoginUser(
                          email: email,
                          password: password,
                        );
                        context.read<LoginCubit>().login(loginUser);
                      },
                child: isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        'Iniciar sesión',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '¿No tienes cuenta?',
              style: TextStyle(fontSize: 15),
            ),
            TextButton(
              onPressed: () {
                context.go(RouterConstants.register);
              },
              child: const Text(
                'Crea cuenta',
                style: TextStyle(
                  color: Color(0xFFD4842C),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
} 