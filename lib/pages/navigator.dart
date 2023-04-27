import 'package:creationofswiftype/dictionary.dart';
import 'package:creationofswiftype/pages/acc1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';

class myNavigatorBar extends StatefulWidget {
  const myNavigatorBar({super.key});

  @override
  State<myNavigatorBar> createState() => NavigatorState();
}

class NavigatorState extends State<myNavigatorBar> {
  int _selectedIndex = 0;
  TextEditingController typing = TextEditingController();
  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Dictionary(),
    Settingpage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 3, 0, 28),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                backgroundColor: Color.fromARGB(255, 3, 0, 28),
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.book,
                  color: Colors.white,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                label: ''),
          ],
          backgroundColor: Color.fromARGB(255, 3, 0, 28),
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          //selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 3, 0, 28),
          title: Text(
            'SWIF⚡YPE',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Source Sans Pro',
                letterSpacing: 0.6,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          // actions: [
          //   IconButton(
          //     onPressed: signUserOut,icon: Icon(Icons.logout,color: Colors.black),
          //   )
          // ],
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ));
  }
}
