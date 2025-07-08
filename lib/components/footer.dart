import 'package:flutter/material.dart';
import 'package:my_flutter_app/components/worktency_logo.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color.fromARGB(255, 255, 255, 255),
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LogoWidget(),
          const SizedBox(height: 20),

          // Footer links with responsive layout
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFooterLink('About Us'),
                    _buildFooterLink('Contact Us'),
                    _buildFooterLink('FAQs'),
                    _buildFooterLink('Community Forum'),
                    _buildFooterLink('Term of Service'),
                    _buildFooterLink('Careers'),
                    _buildFooterLink('Leadership'),
                    _buildFooterLink('Blog'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFooterLink('Social Impact'),
                    _buildFooterLink('Cookies Setting'),
                    _buildFooterLink('Accessibility Statement'),
                    _buildFooterLink('Investors'),
                    _buildFooterLink('Go Pro Course'),
                    _buildFooterLink('Affiliate'),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
          Center(
            child: Container(
              constraints: const BoxConstraints(maxHeight: 150),
              child: Image.asset('assets/images/itc.jpeg', fit: BoxFit.contain),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.facebook),
                  onPressed: () {
                    // Add Facebook link functionality
                  },
                  color: Colors.grey,
                ),
                IconButton(
                  icon: const Icon(Icons.alternate_email),
                  onPressed: () {
                    // Add email functionality
                  },
                  color: Colors.grey,
                ),
                IconButton(
                  icon: const Icon(Icons.play_circle_filled),
                  onPressed: () {
                    // Add YouTube/video link functionality
                  },
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              '© 2025 Worktency, Inc. All rights reserved.',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterLink(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        onTap: () {
          // Add navigation functionality for each link
          _handleFooterLinkTap(text);
        },
        child: Text(
          text,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 14,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }

  void _handleFooterLinkTap(String linkText) {
    // Handle different footer link taps
    switch (linkText) {
      case 'About Us':
        // Navigate to About Us page
        break;
      case 'Contact Us':
        // Navigate to Contact Us page
        break;
      case 'FAQs':
        // Navigate to FAQs page
        break;
      case 'Community Forum':
        // Navigate to Community Forum
        break;
      case 'Term of Service':
        // Navigate to Terms of Service
        break;
      case 'Careers':
        // Navigate to Careers page
        break;
      case 'Leadership':
        // Navigate to Leadership page
        break;
      case 'Blog':
        // Navigate to Blog
        break;
      case 'Social Impact':
        // Navigate to Social Impact page
        break;
      case 'Cookies Setting':
        // Open cookies settings
        break;
      case 'Accessibility Statement':
        // Navigate to Accessibility Statement
        break;
      case 'Investors':
        // Navigate to Investors page
        break;
      case 'Go Pro Course':
        // Navigate to Pro Course page
        break;
      case 'Affiliate':
        // Navigate to Affiliate page
        break;
      default:
        // Handle unknown links
        break;
    }
  }
}

// LogoWidget component (if not already created)
// class LogoWidget extends StatelessWidget {
//   const LogoWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Icon(Icons.work, color: Colors.blue.shade600, size: 24),
//         const SizedBox(width: 8),
//         Text(
//           'Worktency',
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Colors.blue.shade600,
//           ),
//         ),
//       ],
//     );
//   }
// }
