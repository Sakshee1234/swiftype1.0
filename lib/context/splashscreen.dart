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
    Timer(Duration(seconds:3),(){
      Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>AuthPage()));
    });
  }
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      body: Column(
        children: [SizedBox(height:350),
          Center(
          child: Container(
            child: Text('Swif⚡ype',
            style:TextStyle(
            color:Colors.green,
            fontSize: 56,
            fontWeight:FontWeight.bold,
            ),
            ),
          ),
        ),
        SizedBox(height: 250),
        Text('from'),
        SizedBox(height: 10),
        Text('ASV',style:TextStyle(
          color:Colors.green,
          fontSize: 30,
          fontWeight:FontWeight.bold,
        ),),]

        
      ),
      
    );
  }
}