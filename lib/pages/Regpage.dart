import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../context/textfield.dart';
// import 'package:loginpage/context/textfield.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _location = TextEditingController();
  void userinfo() async {
    User user = FirebaseAuth.instance.currentUser!;
    CollectionReference users = FirebaseFirestore.instance.collection('user');
    FirebaseFirestore.instance.collection("user").doc(user.uid).set({
      "name": _name.text,
      'email': emailController.text,
      'location': _location.text,
      'phone': _phone.text,
      'UID': user.uid
    });
  }

  void signUserUp() async {
    //show loading circle
    int flag = 0;
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );
    //try creating user
    try {
      //check if password is confirmed
      if (passwordController.text == confirmPasswordController.text) {
        flag = 1;
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
      } else {
        wronginfo('Passwords do not match');
      }
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      wronginfo(e.code);
    }
    if (flag == 1) userinfo();
  }

  void wronginfo(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 3, 0, 28),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  //logo
                  Text(
                    'SWIF⚡YPE',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        letterSpacing: 0.6,
                        fontFamily: 'Source Sans Pro',
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30),
                  //login
                  myTextField(
                    controller: _name,
                    hintText: 'Name',
                    obscureText: false,
                  ),
                  SizedBox(height: 30),
                  //login
                  myTextField(
                    controller: _phone,
                    hintText: 'Phone Number',
                    obscureText: false,
                  ),
                  SizedBox(height: 30),
                  //login
                  myTextField(
                    controller: _location,
                    hintText: 'Location',
                    obscureText: false,
                  ),
                  //welcome back
                  //username
                  SizedBox(height: 30),
                  //login
                  myTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),
                  //passwd
                  SizedBox(
                    height: 30,
                  ),
                  myTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true, //dot dot for passwd
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  myTextField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true, //dot dot for passwd
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  //forgot passwd
                  //sign in button

                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: signUserUp,
                    child: Container(
                        padding: EdgeInsets.all(25),
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 3, 0, 28),
                                fontSize: 19,
                                fontFamily: 'Source Sans Pro'),
                          ),
                        )),
                  ),
                  //or continue with
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already a member?',
                        style: TextStyle(
                          color: Color.fromARGB(255, 69, 194, 240),
                          fontFamily: 'Source Sans Pro',
                          fontSize: 17,
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          'Login Now',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Source Sans Pro',
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
