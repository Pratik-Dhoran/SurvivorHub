import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'profilescreen.dart';
import 'tournament_registration_page.dart'; // Add this import
import 'notification_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final tournaments = [
    {
      "mode": "1V1 MODE",
      "entry": "ENTRY = ₹100",
      "win": "WIN = ₹180",
      "perPlayer": "",
      "image": "assets/1v1.jpg",
      "qrImage": "assets/qrcodes/1v1_qr.png"
    },
    {
      "mode": "2V2 MODE",
      "entry": "ENTRY ₹100 PER PLAYER",
      "win": "WIN = ₹360",
      "perPlayer": "(PER PLAYER ₹180)",
      "image": "assets/2v2.jpg",
      "qrImage": "assets/qrcodes/2v2_qr.png"
    },
    {
      "mode": "4V4 MODE",
      "entry": "ENTRY ₹100 PER PLAYER",
      "win": "WIN ₹720",
      "perPlayer": "(PER PLAYER ₹180)",
      "image": "assets/4v4.jpg",
      "qrImage": "assets/qrcodes/4v4_qr.png"
    },
    {
      "mode": "6V6 MODE",
      "entry": "ENTRY ₹100 PER PLAYER",
      "win": "WIN ₹1080",
      "perPlayer": "(PER PLAYER ₹180)",
      "image": "assets/6v6.jpg",
      "qrImage": "assets/qrcodes/6v6_qr.png"
    },
  ];

  // Function to check for new notifications
  Future<bool> _hasNewNotification() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('notifications')
        .where('isRead', isEqualTo: false)
        .get();

    return snapshot.docs.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            Image.asset('assets/logo.png', height: 30),
            const SizedBox(width: 10),
            const Text('Survivor Hub'),
          ],
        ),
        centerTitle: false,
        actions: [
          FutureBuilder<bool>(
            future: _hasNewNotification(),
            builder: (context, snapshot) {
              bool hasNewNotification = snapshot.data ?? false;
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const NotificationScreen()),
                      );
                    },
                  ),
                  if (hasNewNotification)
                    Positioned(
                      right: 4,
                      top: 4,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                "Available Tournaments",
                style: TextStyle(
                  color: Colors.cyanAccent,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: tournaments.length,
                itemBuilder: (context, index) {
                  final t = tournaments[index];
                  return Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          colors: [
                            Colors.deepPurpleAccent.withOpacity(0.5),
                            Colors.black,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.cyanAccent.withOpacity(0.6),
                            blurRadius: 20,
                            offset: Offset(0, 6),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                            child: AspectRatio(
                              aspectRatio: 16 / 7,
                              child: Image.asset(
                                t["image"] ?? "assets/default.jpg", // Use a default image if null
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  t["mode"] ?? 'N/A', // Fallback value if null
                                  style: const TextStyle(
                                    color: Colors.orangeAccent,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          t["entry"] ?? 'N/A', // Fallback value if null
                                          style: const TextStyle(
                                            color: Colors.greenAccent,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          t["win"] ?? 'N/A', // Fallback value if null
                                          style: const TextStyle(
                                            color: Colors.greenAccent,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        if ((t["perPlayer"] ?? '').isNotEmpty)
                                          Text(
                                            t["perPlayer"] ?? '',
                                            style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 11,
                                            ),
                                          ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blueAccent,
                                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => TournamentRegistrationPage(
                                                  mode: t["mode"]?.split(" ")[0] ?? "N/A", // Use fallback if null
                                                  qrImage: t["qrImage"] ?? "assets/default_qr.png", // Fallback if null
                                                ),
                                              ),
                                            );
                                          },
                                          child: const Text(
                                            "Join Now",
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
