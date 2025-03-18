import 'package:flutter/material.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Welcome to my Portfolio',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
    );
  }
}
