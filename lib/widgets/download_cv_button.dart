import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DownloadCVButton extends StatelessWidget {
  const DownloadCVButton({super.key});

   Future<void> _navigateLinkIn() async {

    final Uri testUri = Uri.parse('https://www.linkedin.com/in/sokmeak-saren-940a3123a/');

    if (await canLaunchUrl(testUri)) {
      await launchUrl(testUri);
    } else {
      throw 'Could not launch URL';
    }
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: _navigateLinkIn,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        side: const BorderSide(color: Color(0xFF0D6EFD), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Download CV',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0D6EFD),
            ),
          ),
          SizedBox(width: 8),
          Icon(Icons.download, color: Color(0xFF0D6EFD)),
        ],
      ),
    );
  }
}
