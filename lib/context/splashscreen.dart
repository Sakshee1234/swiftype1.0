import 'dart:async';
import 'package:flutter/material.dart';

import '../auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState  -->for short time
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => AuthPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 3, 0, 28),
      body: Column(children: [
        SizedBox(height: 350),
        Center(
          child: Container(
            child: Text(
              'SWIF⚡YPE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 56,
                letterSpacing: 0.6,
                fontWeight: FontWeight.bold,
                fontFamily: 'Source Sans Pro',
              ),
            ),
          ),
        ),
        SizedBox(height: 250),
        Text(
          'from',
          style: TextStyle(
              color: Colors.yellow,
              fontSize: 18,
              fontFamily: 'Source Sans Pro'),
        ),
        SizedBox(height: 10),
        Text(
          'ASV',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: 'Source Sans Pro',
          ),
        ),
      ]),
    );
  }
}
