// TournamentRegistrationPage.dart

import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:screen_protector/screen_protector.dart';

import 'notification_screen.dart'; // <-- Replace with your file path!

class TournamentRegistrationPage extends StatefulWidget {
  final String mode;
  final String qrImage;

  const TournamentRegistrationPage({
    Key? key,
    required this.mode,
    required this.qrImage,
  }) : super(key: key);

  @override
  _TournamentRegistrationPageState createState() => _TournamentRegistrationPageState();
}

class _TournamentRegistrationPageState extends State<TournamentRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController upiIdController = TextEditingController();
  List<TextEditingController> ignControllers = [];
  List<TextEditingController> uidControllers = [];

  File? paymentScreenshot;
  File? qrCodeImage;
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    int players = int.tryParse(widget.mode[0]) ?? 1;
    ignControllers = List.generate(players, (_) => TextEditingController());
    uidControllers = List.generate(players, (_) => TextEditingController());
    ScreenProtector.preventScreenshotOff();
  }

  @override
  void dispose() {
    usernameController.dispose();
    upiIdController.dispose();
    for (var c in ignControllers) c.dispose();
    for (var c in uidControllers) c.dispose();
    ScreenProtector.preventScreenshotOn();
    super.dispose();
  }

  Future<void> _pickImage(Function(File) onPicked) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      onPicked(File(picked.path));
    }
  }

  Future<String> _uploadToImgur(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    final base64Image = base64Encode(bytes);

    final response = await http.post(
      Uri.parse('https://api.imgur.com/3/image'),
      headers: {
        'Authorization': 'Client-ID cefa661d0eb0cea',
      },
      body: {
        'image': base64Image,
        'type': 'base64',
      },
    );

    final data = jsonDecode(response.body);
    if (response.statusCode == 200 && data['success']) {
      return data['data']['link'];
    } else {
      throw Exception('Failed to upload image: ${data['data']['error']}');
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    if (paymentScreenshot == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload payment screenshot')),
      );
      return;
    }
    if (qrCodeImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload your QR code')),
      );
      return;
    }

    setState(() => isSubmitting = true);

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please log in first')),
        );
        setState(() => isSubmitting = false);
        return;
      }

      final screenshotUrl = await _uploadToImgur(paymentScreenshot!);
      final qrCodeUrl = await _uploadToImgur(qrCodeImage!);

      final registrationData = {
        'firebaseUid': user.uid,
        'username': usernameController.text.trim(),
        'upiId': upiIdController.text.trim(),
        'mode': widget.mode,
        'timestamp': FieldValue.serverTimestamp(),
        'players': List.generate(ignControllers.length, (i) => {
          'ign': ignControllers[i].text.trim(),
          'uid': uidControllers[i].text.trim(), // <-- ✅ Corrected here
        }),
        'paymentScreenshotUrl': screenshotUrl,
        'qrCodeUrl': qrCodeUrl,
      };

      await FirebaseFirestore.instance.collection('tournament_registrations').add(registrationData);

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Registration Successful'),
          content: const Text('Registration successful. For further updates, please check the notifications regularly.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const NotificationScreen()),
                );
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() => isSubmitting = false);
    }
  }

  InputDecoration neonInputDecoration(String hintText) => InputDecoration(
    filled: true,
    fillColor: const Color(0xFF0F0F0F),
    hintText: hintText,
    hintStyle: const TextStyle(color: Colors.grey),
    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.cyanAccent, width: 2),
      borderRadius: BorderRadius.circular(12),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.cyanAccent, width: 2),
      borderRadius: BorderRadius.circular(12),
    ),
  );

  void _copyUpiId() {
    Clipboard.setData(const ClipboardData(text: '9608830652@ptsbi'));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('UPI ID Copied!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4B0082), Color(0xFF8A2BE2)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            title: Text('${widget.mode} Registration'),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      backgroundColor: const Color(0xFF1A1A1A),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField('Username', usernameController, 'Enter your username'),
              const SizedBox(height: 16),
              _buildTextField('Your UPI ID', upiIdController, 'Enter your UPI ID'),
              const SizedBox(height: 16),
              _buildImagePicker('Upload Your QR Code', qrCodeImage, () => _pickImage((file) => setState(() => qrCodeImage = file))),
              const SizedBox(height: 24),
              for (int i = 0; i < ignControllers.length; i++) ...[
                _buildTextField('In-Game Name ${i + 1}', ignControllers[i], 'Enter In-Game Name ${i + 1}'),
                const SizedBox(height: 8),
                _buildTextField('Game UID ${i + 1}', uidControllers[i], 'Enter Game UID ${i + 1}'),
                const SizedBox(height: 16),
              ],
              Center(
                child: Column(
                  children: [
                    const Text('Scan QR & Make Payment', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.cyanAccent, width: 2),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [BoxShadow(color: Colors.cyanAccent.withOpacity(0.4), blurRadius: 10, spreadRadius: 2)],
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Image.asset(widget.qrImage, height: 200),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: _copyUpiId,
                      child: const Text('UPI ID: 9608830652@ptsbi', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.cyanAccent)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _buildImagePicker('Attach Payment Screenshot', paymentScreenshot, () => _pickImage((file) => setState(() => paymentScreenshot = file))),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: isSubmitting ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: Colors.blueAccent, width: 2),
                    ),
                  ),
                  child: const Text('Submit', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: neonInputDecoration(hint),
          style: const TextStyle(color: Colors.white),
          validator: (v) => v == null || v.trim().isEmpty ? 'Please enter $label' : null,
        ),
      ],
    );
  }

  Widget _buildImagePicker(String label, File? imageFile, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 75,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.cyanAccent, width: 2),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [BoxShadow(color: Colors.cyanAccent.withOpacity(0.4), blurRadius: 8, spreadRadius: 2)],
            ),
            child: imageFile != null
                ? Image.file(imageFile, fit: BoxFit.cover)
                : const Center(child: Text('Tap to upload', style: TextStyle(color: Colors.white, fontSize: 16))),
          ),
        ),
      ],
    );
  }
}
