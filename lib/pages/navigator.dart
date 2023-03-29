import 'package:creationofswiftype/dictionary.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:loginpage/navigators/feedback.dart';
// import 'package:loginpage/pages/acc1.dart';
// import 'package:loginpage/pages/dictionary.dart';
import 'acc1.dart';
import 'dictionary.dart';
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
    SettingPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.black,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.book,
                color: Colors.black,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Colors.black,
              ),
              label: ''),
              
        ],
        backgroundColor: Colors.green,
         type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        //selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Swif⚡ype',style: TextStyle(color: Colors.black),),
        // actions: [
        //   IconButton(
        //     onPressed: signUserOut,icon: Icon(Icons.logout,color: Colors.black),
        //   )
        // ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      )
    );
  }
}
