import 'package:flutter/material.dart';
import 'package:my_flutter_app/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;
  String _selectedLanguage = 'en';
  SharedPreferences? _prefs;

  // Localization dictionary
  Map<String, Map<String, String>> localizedStrings = {
    'en': {
      'app_title': 'Log in',
      'greeting': 'Hello!',
      'username': 'Username',
      'password': 'Password',
      'login': 'Log in',
      'dark_mode': 'Dark Mode',
    },
    'fr': {
      'app_title': 'Connexion',
      'greeting': 'Salut!',
      'username': 'Nom d\'utilisateur',
      'password': 'Mot de passe',
      'login': 'Connexion',
      'dark_mode': 'Mode sombre',
    },
    'kh': {
      'app_title': 'ចូល',
      'greeting': 'សួស្ដី!',
      'username': 'ឈ្មោះអ្នកប្រើប្រាស់',
      'password': 'ពាក្យសម្ងាត់',
      'login': 'ចូល',
      'dark_mode': 'ងងឹត',
    },
  };

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  // Load saved preferences
  Future<void> _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = _prefs!.getBool('darkMode') ?? false;
      _selectedLanguage = _prefs!.getString('language') ?? 'en';
    });
  }

  // Save dark mode preference
  Future<void> _saveDarkMode(bool value) async {
    await _prefs!.setBool('darkMode', value);
    setState(() {
      _isDarkMode = value;
    });
  }

  // Save language preference
  Future<void> _saveLanguage(String language) async {
    await _prefs!.setString('language', language);
    setState(() {
      _selectedLanguage = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi-Language Login App',
      theme: ThemeData(
        brightness: _isDarkMode ? Brightness.dark : Brightness.light,
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: _isDarkMode ? Colors.black : Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: _isDarkMode ? Colors.black : Colors.white,
          foregroundColor: _isDarkMode ? Colors.white : Colors.orange,
          elevation: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.orange, width: 2),
          ),
          filled: true,
          fillColor: _isDarkMode ? Colors.grey[800] : Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            minimumSize: Size(double.infinity, 50),
          ),
        ),
      ),
      home: LoginPage(
        isDarkMode: _isDarkMode,
        selectedLanguage: _selectedLanguage,
        localizedStrings: localizedStrings,
        onDarkModeChanged: _saveDarkMode,
        onLanguageChanged: _saveLanguage,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}