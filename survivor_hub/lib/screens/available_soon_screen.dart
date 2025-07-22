import 'package:flutter/material.dart';

class AvailableSoonScreen extends StatelessWidget {
  const AvailableSoonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1f1f1f),
        title: const Text('Coming Soon'),
      ),
      body: const Center(
        child: Text(
          'This feature is coming soon...',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
