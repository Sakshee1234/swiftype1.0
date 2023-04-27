import 'package:flutter/material.dart';

class myTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  const myTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              //before clicking
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              color: Color.fromARGB(100, 150, 200, 218),
            ),
          ),
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Source Sans Pro',
            fontSize: 17,
          )),
    );
  }
}
