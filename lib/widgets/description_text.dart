import 'package:flutter/material.dart';

class DescriptionText extends StatelessWidget {
  const DescriptionText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Collaborating with highly skilled individuals, our agency delivers top-quality services.',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 16, color: Colors.black54, height: 1.5),
    );
  }
}
