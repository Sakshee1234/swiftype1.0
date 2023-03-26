import 'package:flutter/material.dart';
// import 'package:loginpage/pages/Regpage.dart';
import 'Regpage.dart';
import 'login_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {

  //initially login page is shown
  bool showLogin = true;
  //toggle between login and register page
  void togglePage() {
    setState(() {
      showLogin = !showLogin;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showLogin){
      return LoginPage(
        onTap: togglePage,
      );
    }else{
      return RegisterPage(onTap:togglePage);
  }
  }
}