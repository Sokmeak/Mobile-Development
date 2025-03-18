import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 280,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/profile.jpg',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey.shade200,
              child: const Icon(Icons.person, size: 120, color: Colors.grey),
            );
          },
        ),
      ),
    );
  }
}
