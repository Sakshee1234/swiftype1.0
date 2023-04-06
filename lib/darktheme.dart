import 'package:flutter/material.dart';


class darkthemetoggle extends StatefulWidget {
  @override
  _darkthemetoggleState createState() => _darkthemetoggleState();
}

class _darkthemetoggleState extends State<darkthemetoggle> {
  bool isDarkModeEnabled = false;

  void toggleDarkMode() {
    setState(() {
      isDarkModeEnabled = !isDarkModeEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dark Theme Demo',
      theme: isDarkModeEnabled ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dark Theme Demo'),
        ),
        body: Center(
          child: Switch.adaptive(
            value: isDarkModeEnabled,
            onChanged: (value) => toggleDarkMode(),
          ),
        ),
      ),
    );
  }
}