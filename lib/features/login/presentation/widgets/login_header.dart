import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 32, bottom: 32),
        decoration: BoxDecoration(
          color: const Color(0xFFF2C892),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Column(
          children: [
            Center(
              child: SizedBox(
                height: 160,
                width: 240,
                child: Image.asset(
                  'assets/images/logo_lib_1.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 