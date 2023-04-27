import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../context/textfield.dart';
import 'navigator.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  // FirebaseAuth auth = FirebaseAuth.instance;
  // Firebase.initializeApp();
  // void showErrorMeassage(String  message){
  void signUserIn() async {
    //show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );
    //try sign  in
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      if (userCredential.user != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => myNavigatorBar()),
            (route) => false);
      }
      // Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      wronginfo(e.code);
    }
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
      body: SafeArea(
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
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 50,
                      fontFamily: 'Source Sans Pro',
                      letterSpacing: 0.6,
                      fontWeight: FontWeight.bold),
                ),
                //welcome back
                //username
                SizedBox(height: 30),

                //login
                myTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                  //for text entered to be white in color
                  //style: TextStyle(color: Colors.white),
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
                  height: 10,
                ),
                Text(
                  'Forgot Password?',
                  style: TextStyle(
                      color: Color.fromARGB(255, 69, 194, 240),
                      fontFamily: 'Source Sans Pro',
                      fontSize: 16),
                ),

                //forgot passwd
                //sign in button

                SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: signUserIn,
                  child: Container(
                      padding: EdgeInsets.all(25),
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 3, 0, 28),
                            fontSize: 19.5,
                            fontFamily: 'Source Sans Pro',
                          ),
                        ),
                      )),
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(
                          color: Color.fromARGB(255, 69, 194, 240),
                          fontFamily: 'Source Sans Pro',
                          fontSize: 17),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Register Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          fontFamily: 'Source Sans Pro',
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
    );
  }
}
