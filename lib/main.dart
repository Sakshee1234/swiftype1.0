import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'context/splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class Launchpg extends StatelessWidget {
  const Launchpg({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 3, 0, 28),
        body: Center(
          child: Text(
            'SWIF⚡YPE',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 0.6,
            ),
          ),
        ));
  }
}


