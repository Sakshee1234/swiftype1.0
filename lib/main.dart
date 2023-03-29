import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'context/splashscreen.dart';

Future<void> main() async{
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
      //  theme: ThemeData(brightness: Brightness.dark)
    );
  }
}

class Launchpg extends StatelessWidget {
  const Launchpg({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green,
        body: Center(
          child: Text(
            'Swif⚡ype',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }
}
