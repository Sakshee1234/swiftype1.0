import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:loginpage/context/textfield.dart';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:loginpage/pages/homepage.dart';
import '../context/textfield.dart';
import 'navigator.dart';
class LoginPage extends StatefulWidget {
  final Function()? onTap;
  LoginPage({super.key,required this.onTap});


  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  // FirebaseAuth auth = FirebaseAuth.instance;
  // Firebase.initializeApp();
  // void showErrorMeassage(String  message){
  void signUserIn() async{
    //show loading circle
    showDialog(context: context, 
    builder: (context){
      return Center(child:CircularProgressIndicator());
      },
      );
    //try sign  in
    try{
      UserCredential userCredential=await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text, 
      password: passwordController.text
      );
      if(userCredential.user!=null)
      {
        Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=>myNavigatorBar()), (route) => false);
      }
      // Navigator.pop(context);
    }on FirebaseAuthException catch(e){
      Navigator.pop(context);
      wronginfo(e.code);
    }
  }
  void wronginfo(String message)
  {
    showDialog(context: context,builder:(context) {
      return AlertDialog(title: Text(message),);
    },);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
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
                  'Swif⚡ype',
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                ),
                //welcome back
                //username
                SizedBox(height: 25),
                //login
                myTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                //passwd
                SizedBox(
                  height: 25,
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
                    color: Colors.green,
                  ),
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
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      )),
                ),
                //or continue with
                // SizedBox(
                //   height: 25,
                // ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 10),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Divider(
                //           thickness: 0.5,
                //           color: Colors.green,
                //         ),
                //       ),
                //       Padding(
                //         padding: EdgeInsets.symmetric(horizontal: 8),
                //         child: Text('Or Continue with',
                //             style: TextStyle(color: Colors.green)),
                //       ),
                //       Expanded(
                //         child: Divider(
                //           color: Colors.green,
                //           thickness: 0.5,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                //google+apple sign in
                // SizedBox(height: 25),
        
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Container(
                //         padding: EdgeInsets.all(4),
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(16),
                //           border: Border.all(
                //             color: Colors.green,
                //             style: BorderStyle.solid,
                //           ),
                //         ),
                //         child: Image.asset('lib/images/google.png', height: 72)),
                //     SizedBox(width: 25),
                //     Container(
                //         padding: EdgeInsets.all(4),
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(16),
                //           border: Border.all(
                //             color: Colors.green,
                //             style: BorderStyle.solid,
                //           ),
                //         ),
                //         child: Image.asset('lib/images/apple.png', height: 72))
                //   ],
                // ),
                //not a member register
        
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                    GestureDetector(
                      onTap:widget.onTap,
                      child: Text(
                        'Register Now',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
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
