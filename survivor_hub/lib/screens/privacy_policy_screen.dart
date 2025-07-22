import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy Policy"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Privacy Policy',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                'At SurvivorHub, we value your privacy and are committed to protecting your personal data. This policy outlines how we collect, use, and safeguard your information.',
              ),
              SizedBox(height: 16),
              Text('1. Data Collection:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('We collect basic information such as your name, email, phone number, and UPI ID for account creation and transaction purposes.'),
              SizedBox(height: 8),
              Text('2. Data Usage:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Your information is used solely for account management, tournament participation, and to process transactions and support requests.'),
              SizedBox(height: 8),
              Text('3. Data Sharing:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('We do not share your personal information with any third-party services without your consent.'),
              SizedBox(height: 8),
              Text('4. Security Measures:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('We implement security protocols to ensure your data is safe and protected against unauthorized access.'),
              SizedBox(height: 8),
              Text('5. User Rights:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('You can request to view, update, or delete your data by contacting our support team.'),
              SizedBox(height: 16),
              Text(
                'By using SurvivorHub, you agree to this privacy policy. We may update it occasionally. Any changes will be communicated via app notifications or emails.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
