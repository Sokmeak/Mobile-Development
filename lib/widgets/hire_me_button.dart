import 'package:flutter/material.dart';

class HireMeButton extends StatelessWidget {
  const HireMeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0D6EFD),
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        elevation: 0,
      ),
      child: const Text(
        'Hire Me!',
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
