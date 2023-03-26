import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  TextEditingController typing = TextEditingController();
  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[400],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                
                SizedBox(
                  height: 25,
                ),
                SizedBox(
                    width: 350, // <-- TextField width
                    height: 500, // <-- TextField height
                    child: Container(
                      child: 
                        TextField(
                          maxLines: null,
                          expands: true,
                          decoration: InputDecoration( filled:true,fillColor: Colors.white,hintText: 'Start Typing...'),
                          controller: typing,
                        ),
                    ),
                    
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: (){ 
                          Clipboard.setData(ClipboardData(text: typing.text));
                        }, 
                        style:ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                        ),
                        child: Text("Copy Text")
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
