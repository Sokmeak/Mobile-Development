import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HireMeButton extends StatelessWidget {
  const HireMeButton({super.key});

  Future<void> _navigateFacebook() async {

    final Uri testUri = Uri.parse('https://github.com/Sokmeak');

    if (await canLaunchUrl(testUri)) {
      await launchUrl(testUri);
    } else {
      throw 'Could not launch URL';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _navigateFacebook,
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
