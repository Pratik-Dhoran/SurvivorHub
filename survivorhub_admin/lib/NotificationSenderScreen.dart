import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationSenderScreen extends StatefulWidget {
  const NotificationSenderScreen({Key? key}) : super(key: key);

  @override
  State<NotificationSenderScreen> createState() => _NotificationSenderScreenState();
}

class _NotificationSenderScreenState extends State<NotificationSenderScreen> {
  final TextEditingController _messageController = TextEditingController();
  List<Map<String, String>> users = [];
  List<String> selectedUserUids = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('tournament_registrations')
        .orderBy('timestamp', descending: true)
        .get();

    Set<String> uniqueUids = {};
    List<Map<String, String>> loadedUsers = [];

    for (var doc in snapshot.docs) {
      final data = doc.data();
      final firebaseUid = data['firebaseUid'] ?? ''; // ✅ Get UID from root
      final username = data['username'] ?? '';
      final players = data['players'] as List<dynamic>? ?? [];

      // Show one entry per registration (based on firebaseUid at root)
      if (firebaseUid.isNotEmpty && !uniqueUids.contains(firebaseUid)) {
        final ign = players.isNotEmpty ? (players[0]['ign'] ?? '') : '';

        uniqueUids.add(firebaseUid);
        loadedUsers.add({
          'uid': firebaseUid,
          'name': ign.isNotEmpty && ign != 'text' ? ign : username,
        });
      }
    }

    setState(() {
      users = loadedUsers;
    });
  }

  Future<void> _sendNotification() async {
    final message = _messageController.text.trim();
    if (message.isEmpty || selectedUserUids.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a message and select at least one user')),
      );
      return;
    }

    await FirebaseFirestore.instance.collection('notifications').add({
      'message': message,
      'uids': selectedUserUids,
      'timestamp': FieldValue.serverTimestamp(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Notification(s) sent successfully!')),
    );

    _messageController.clear();
    setState(() {
      selectedUserUids.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Notification'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                labelText: 'Message',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            const Text('Select users:', style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  final uid = user['uid']!;
                  final name = user['name']!;

                  return CheckboxListTile(
                    value: selectedUserUids.contains(uid),
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          selectedUserUids.add(uid);
                        } else {
                          selectedUserUids.remove(uid);
                        }
                      });
                    },
                    title: Text(name),
                    subtitle: Text(uid),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _sendNotification,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
              child: const Text('Send Notification'),
            ),
          ],
        ),
      ),
    );
  }
}
