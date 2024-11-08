
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(CupertinoIcons.back, size: 24),
        ),
        title: const Text(
          "Privacy Policy",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: ListView(
          children: [
            _buildSectionTitle("Open Player Privacy Policy"),
            _buildSectionDescription("Effective Date: November 2024", context),
            _buildSectionTitle("Introduction"),
            _buildSectionDescription(
              "Open Player is committed to protecting your privacy. This Privacy Policy explains how we collect, use, and protect your personal information.",context
            ),
            _buildSectionTitle("Scope"),
            _buildSectionDescription(
              "This Privacy Policy applies to the Open Player mobile application (the \"App\") available on GitHub. By using the App, you consent to the terms of this Policy.",context
            ),
            _buildSectionTitle("Personal Information"),
            _buildSectionDescription(
              "We collect minimal personal information to enhance your user experience: username and profile picture. This information is stored locally on your device  and is not shared with third parties.",context
            ),
            _buildSectionTitle("Data Collection and Use"),
            _buildSectionDescription(
              "We do not collect or store any sensitive information, including location data, contact information, browsing history, or audio/video playback history.",context
            ),
            _buildSectionTitle("Feedback"),
            _buildSectionDescription(
              "The App includes a feedback feature that directs you to your email application for providing input directly to the developer.",context
            ),
            _buildSectionTitle("Protection of Information"),
            _buildSectionDescription(
              "We employ industry-standard security measures to safeguard your data against unauthorized access or misuse.",context
            ),
            _buildSectionTitle("Distribution"),
            _buildSectionDescription(
              "We do not distribute or share your personal information with third parties.",context
            ),
            _buildSectionTitle("Contact"),
            _buildSectionDescription(
              "For inquiries regarding this policy or the App, contact us at:\n\nOpen Player\nDeveloper: Furqan Uddin\nEmail: furqanuddin@programmer.net",context
            ),
            _buildSectionTitle("Changes to this Policy"),
            _buildSectionDescription(
              "We reserve the right to update this Policy. Changes will be posted on this page.",context
            ),
            _buildSectionTitle("Your Rights"),
            _buildSectionDescription(
              "You have the right to access and modify your personal information, request deletion of your personal information, and opt-out of future data collection.",context
            ),
            _buildSectionTitle("Acknowledgement"),
            _buildSectionDescription(
              "By using Open Player, you acknowledge that you have read, understood, and agree to be bound by this Privacy Policy.",context
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildSectionDescription(String text, context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color:Theme.of(context).brightness == Brightness.dark?Colors.white54  : Colors.black54,
        ),
      ),
    );
  }
}

