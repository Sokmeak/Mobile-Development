import 'package:flutter/material.dart';

class DownloadCVButton extends StatelessWidget {
  const DownloadCVButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
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
