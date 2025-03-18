import 'package:flutter/material.dart';
import 'widgets/profile_image.dart';
import 'widgets/welcome_text.dart';
import 'widgets/name_text.dart';
import 'widgets/description_text.dart';
import 'widgets/hire_me_button.dart';
import 'widgets/download_cv_button.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: const PortfolioScreen(),
    );
  }
}

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFF0D6EFD),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.paragliding_outlined,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'AeroVision',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.black87,
              size: 28,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const ProfileImage(),
              const SizedBox(height: 24),
              const WelcomeText(),
              const SizedBox(height: 16),
              const NameText(),
              const SizedBox(height: 24),
              const DescriptionText(),
              const SizedBox(height: 40),
              const HireMeButton(),
              const SizedBox(height: 16),
              const DownloadCVButton(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}