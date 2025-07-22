import 'package:flutter/material.dart';

class TournamentDetailScreen extends StatelessWidget {
  final int index;
  const TournamentDetailScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(title: const Text("Tournament Details")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text("Details for tournament #$index",
            style: const TextStyle(color: Colors.white, fontSize: 18)),
      ),
    );
  }
}
