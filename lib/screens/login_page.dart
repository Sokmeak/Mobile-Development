import 'package:flutter/material.dart';
import 'package:my_flutter_app/components/worktency_logo.dart';

class LoginPage extends StatefulWidget {
  final bool isDarkMode;
  final String selectedLanguage;
  final Map<String, Map<String, String>> localizedStrings;
  final Function(bool) onDarkModeChanged;
  final Function(String) onLanguageChanged;

  const LoginPage({
    Key? key,
    required this.isDarkMode,
    required this.selectedLanguage,
    required this.localizedStrings,
    required this.onDarkModeChanged,
    required this.onLanguageChanged,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Get localized string
  String getLocalizedString(String key) {
    return widget.localizedStrings[widget.selectedLanguage]?[key] ?? key;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _buildLanguageButton(
    String langCode,
    String flagEmoji,
    bool isSelected,
  ) {
    return Container(
      width: 90,
      height: 50,
      decoration: BoxDecoration(
        color: isSelected ? Colors.orange : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? Colors.orange : Colors.grey.shade400,
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => widget.onLanguageChanged(langCode),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(flagEmoji, style: TextStyle(fontSize: 16)),
                SizedBox(width: 4),
                Text(
                  langCode.toUpperCase(),
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text(
          getLocalizedString('app_title'),
          style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w600),
        ),
        backgroundColor: widget.isDarkMode ? Colors.black : Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              const LogoWidget(),

              // // Worktency Logo
              // Container(
              //   child: RichText(
              //     text: TextSpan(
              //       style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              //       children: [
              //         TextSpan(
              //           text: 'w',
              //           style: TextStyle(color: Colors.orange),
              //         ),
              //         TextSpan(
              //           text: 'orktency',
              //           style: TextStyle(
              //             color:
              //                 widget.isDarkMode
              //                     ? Colors.white
              //                     : Colors.blue.shade800,
              //           ),
              //         ),
              //         TextSpan(
              //           text: '>',
              //           style: TextStyle(color: Colors.orange),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              const SizedBox(height: 40),

              // Greeting
              Text(
                getLocalizedString('greeting'),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.orange,
                ),
              ),

              const SizedBox(height: 40),

              // Username field
              TextField(
                controller: _usernameController,
                style: TextStyle(
                  color: widget.isDarkMode ? Colors.white : Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: getLocalizedString('username'),
                  hintStyle: TextStyle(
                    color:
                        widget.isDarkMode
                            ? Colors.grey.shade400
                            : Colors.grey.shade600,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.orange, width: 2),
                  ),
                  filled: true,
                  fillColor:
                      widget.isDarkMode ? Colors.grey[800] : Colors.white,
                ),
              ),

              const SizedBox(height: 20),

              // Password field
              TextField(
                controller: _passwordController,
                obscureText: true,
                style: TextStyle(
                  color: widget.isDarkMode ? Colors.white : Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: getLocalizedString('password'),
                  hintStyle: TextStyle(
                    color:
                        widget.isDarkMode
                            ? Colors.grey.shade400
                            : Colors.grey.shade600,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.orange, width: 2),
                  ),
                  filled: true,
                  fillColor:
                      widget.isDarkMode ? Colors.grey[800] : Colors.white,
                ),
              ),

              const SizedBox(height: 30),

              // Login button
              ElevatedButton(
                onPressed: () {
                  String username = _usernameController.text;
                  String password = _passwordController.text;

                  if (username.isNotEmpty && password.isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Login successful for $username'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please enter both username and password',
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  getLocalizedString('login'),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),

              const Spacer(),

              // Language selection buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLanguageButton(
                    'en',
                    '🇬🇧',
                    widget.selectedLanguage == 'en',
                  ),
                  const SizedBox(width: 20),
                  _buildLanguageButton(
                    'fr',
                    '🇫🇷',
                    widget.selectedLanguage == 'fr',
                  ),
                  const SizedBox(width: 20),
                  _buildLanguageButton(
                    'kh',
                    '🇰🇭',
                    widget.selectedLanguage == 'kh',
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Dark mode toggle
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    getLocalizedString('dark_mode'),
                    style: TextStyle(
                      fontSize: 16,
                      color: widget.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Switch(
                    value: widget.isDarkMode,
                    onChanged: widget.onDarkModeChanged,
                    activeColor: Colors.orange,
                    activeTrackColor: Colors.orange.shade200,
                    inactiveThumbColor: Colors.grey.shade400,
                    inactiveTrackColor: Colors.grey.shade300,
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
