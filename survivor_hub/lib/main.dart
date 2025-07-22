import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:screen_protector/screen_protector.dart'; // ✅ Add this
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // ✅ Initialize Firebase
  await ScreenProtector.preventScreenshotOn(); // ✅ Block screenshots globally
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Survivor Hub',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      home: const SplashScreen(),
    );
  }
}
