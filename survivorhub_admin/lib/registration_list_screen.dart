import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RegistrationListScreen extends StatelessWidget {
  const RegistrationListScreen({Key? key}) : super(key: key);

  Future<void> _sendNotification(BuildContext context, String firebaseUid) async {
    final TextEditingController messageController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Send Notification'),
        content: TextField(
          controller: messageController,
          decoration: const InputDecoration(
            hintText: 'Enter your message',
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final message = messageController.text.trim();
              if (message.isNotEmpty) {
                await FirebaseFirestore.instance.collection('notifications').add({
                  'uid': firebaseUid,
                  'message': message,
                  'timestamp': FieldValue.serverTimestamp(),
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Notification sent')),
                );
              }
            },
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Registrations'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('tournament_registrations')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;
          if (docs.isEmpty) {
            return const Center(child: Text('No registrations found.'));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              final players = data['players'] as List<dynamic>? ?? [];
              final registrationId = docs[index].id;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Username: ${data['username'] ?? 'N/A'}", style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text("Mode: ${data['mode'] ?? 'N/A'}"),
                      const SizedBox(height: 8),
                      const Text("Players:"),
                      ...players.map((p) {
                        final ign = p['ign'] ?? 'Unknown';
                        final uid = p['uid'] ?? 'N/A';
                        final firebaseUid = p['firebaseUid'] ?? ''; // <- make sure this exists
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("• $ign (UID: $uid)"),
                            if (firebaseUid.isNotEmpty)
                              Align(
                                alignment: Alignment.centerLeft,
                                child: TextButton(
                                  onPressed: () => _sendNotification(context, firebaseUid),
                                  child: const Text('Send Notification'),
                                ),
                              ),
                          ],
                        );
                      }).toList(),
                      const SizedBox(height: 8),
                      const Text("Payment Screenshot:"),
                      const SizedBox(height: 6),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullScreenImageScreen(imageUrl: data['paymentScreenshotUrl'] ?? ''),
                            ),
                          );
                        },
                        child: CachedNetworkImage(
                          imageUrl: data['paymentScreenshotUrl'] ?? '',
                          height: 150,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text("QR Code:"),
                      const SizedBox(height: 6),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullScreenImageScreen(imageUrl: data['qrCodeUrl'] ?? ''),
                            ),
                          );
                        },
                        child: CachedNetworkImage(
                          imageUrl: data['qrCodeUrl'] ?? '',
                          height: 150,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () => _deleteRegistration(registrationId),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        child: const Text('Delete Registration'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _deleteRegistration(String registrationId) async {
    try {
      await FirebaseFirestore.instance
          .collection('tournament_registrations')
          .doc(registrationId)
          .delete();
    } catch (e) {
      print('Error deleting registration: $e');
    }
  }
}

class FullScreenImageScreen extends StatelessWidget {
  final String imageUrl;

  const FullScreenImageScreen({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: InteractiveViewer(
            child: Image.network(imageUrl),
          ),
        ),
      ),
    );
  }
}
