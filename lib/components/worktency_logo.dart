import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/worktency_logo.jpg', // Fixed image path
      height: 40, // Fixed height
      fit: BoxFit.contain, // Fixed fit
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (frame == null) {
          return Container(
            height: 40,
            color: Colors.grey.shade200,
            child: const Center(child: CircularProgressIndicator()),
          );
        }
        return child;
      },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: 40,
          color: Colors.grey.shade300,
          child: const Center(child: Icon(Icons.error, color: Colors.red)),
        );
      },
    );
  }
}
