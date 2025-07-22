import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'About SurvivorHub',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                'SurvivorHub is a competitive gaming platform designed for Free Fire enthusiasts who want to participate in real-time tournaments, win prizes, and showcase their skills.',
              ),
              SizedBox(height: 16),
              Text(
                'Our Mission:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'To empower mobile gamers by providing them with a fair and exciting space to compete, connect, and grow in the esports ecosystem.',
              ),
              SizedBox(height: 12),
              Text(
                'What We Offer:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '- Real-time Free Fire tournaments\n- Secure UPI-based transactions\n- Transparent leaderboard and prize system\n- Player support and dispute resolution\n- User-friendly interface',
              ),
              SizedBox(height: 16),
              Text(
                'We are a team of passionate gamers and developers working to make mobile esports more accessible and enjoyable for everyone.',
              ),
              SizedBox(height: 12),
              Text(
                'For collaborations or inquiries, reach us at support@survivorhub.in',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
