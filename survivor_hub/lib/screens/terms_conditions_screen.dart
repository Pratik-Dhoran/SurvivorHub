import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Welcome to SurvivorHub!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                'By participating in our platform, you agree to comply with the terms and conditions outlined below. These rules are designed to ensure a fair, transparent, and enjoyable experience for all users. Please read them carefully before engaging with our services.',
              ),
              SizedBox(height: 16),
              Text('1. Gameplay Recording Submission Deadline:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('If you fail to submit the gameplay recording within 2 hours after the scheduled match time, you will not be eligible to receive any prizes.'),
              SizedBox(height: 8),
              Text('2. Winnings Transfer from Banned Accounts:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Winnings from banned or inaccessible accounts cannot be transferred.'),
              SizedBox(height: 8),
              Text('3. Minimum Resolution and FPS Requirements for Recording:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('A minimum resolution of 480p and 30 FPS is required for recordings.'),
              SizedBox(height: 8),
              Text('4. Cancellation of Withdrawal Requests:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Withdrawal requests cannot be canceled after submission.'),
              SizedBox(height: 8),
              Text('5. Changing UPI Details After Withdrawal Request:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Once a withdrawal request is submitted, UPI details cannot be modified.'),
              SizedBox(height: 8),
              Text('6. Appeal Process for Unfair Account Bans:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('If you believe your account has been unfairly banned, you may submit an appeal by contacting support at support@suvivorhub.in.'),
              SizedBox(height: 8),
              Text('7. Impact of Account Ban on Match Registrations:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('All upcoming match registrations will be canceled from banned accounts.'),
              SizedBox(height: 8),
              Text('8. Participation During Account Review:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Accounts under review for suspected violations are prohibited from participating in matches until the review is completed.'),
              SizedBox(height: 8),
              Text('9. Prize Allocation for Rule Violations:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('If both teams violate the rules in a short map match, the prizes will still be awarded to the winners.'),
              SizedBox(height: 8),
              Text('10. Financial Responsibility Disclaimer:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Participants are solely responsible for their financial investments. Refunds will not be provided for monetary losses.'),
              SizedBox(height: 16),
              Text(
                'Participation is strictly limited to individuals aged 18 and above to ensure compliance with our eligibility criteria.',
              ),
              SizedBox(height: 12),
              Text(
                'By continuing to use SurvivorHub, you acknowledge and accept these terms and conditions. For any inquiries, contact our support team.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
