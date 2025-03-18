import 'package:flutter/material.dart';

class NameText extends StatelessWidget {
  const NameText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
        children: [
          TextSpan(
            text: 'Hi I\'m ',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              height: 1.2,
            ),
          ),
          TextSpan(
            text: 'Saren Sokmeak\n',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D6EFD),
              height: 1.2,
            ),
          ),
          TextSpan(
            text: 'Mobile\nDeveloper',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
