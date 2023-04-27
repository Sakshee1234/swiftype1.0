import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creationofswiftype/pages/acc1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class InfoCard extends StatelessWidget {
  // the values we need
  final String placeholder;
  final IconData icon;
  Function onPressed;

  InfoCard(
      {required this.placeholder, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        color: Color.fromARGB(255, 3, 0, 28),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.white,
          ),
          title: Text(
            placeholder,
            style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontFamily: "Source Sans Pro"),
          ),
        ),
      ),
    );
  }
}

// const email = "me.shivansh007@gmail.com";
// const phone = "90441539202";
// const location = "Lucknow, India";

class HomePage extends StatelessWidget {
  String name, email, location, phone;
  HomePage(
      {required this.name,
      required this.email,
      required this.location,
      required this.phone});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 3, 0, 28),
          title: Text(
            'SWIF⚡YPE',
            style: TextStyle(
                color: Colors.white,
                letterSpacing: 0.6,
                fontFamily: "Source Sans Pro"),
          ),
          // actions: [
          //   IconButton(
          //     icon: Icon(
          //       Icons.arrow_back,
          //       color: Colors.green,
          //     ),
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //   ),
          // ]
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          minimum: const EdgeInsets.only(top: 40),
          child: Column(
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('images/pfp.jfif'),
              ),
              Text(
                name,
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.black,
                    letterSpacing: -1.2,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Source Sans Pro"),
              ),
              // Text(
              //   "Flutter Developer",
              //   style: TextStyle(
              //       fontSize: 20,
              //       color: Colors.blueGrey,
              //       letterSpacing: 2.5,
              //       fontWeight: FontWeight.bold,
              //       fontFamily: "Source Sans Pro"),
              // ),
              SizedBox(
                height: 35,
                width: 200,
                // child: Divider(
                //   color: Colors.black,
                // ),
              ),

              // we will be creating a new widget name info carrd

              InfoCard(
                  placeholder: phone,
                  icon: Icons.phone,
                  onPressed: () async {}),
              InfoCard(
                  placeholder: location,
                  icon: Icons.location_city,
                  onPressed: () async {}),
              InfoCard(
                  placeholder: email,
                  icon: Icons.email,
                  onPressed: () async {}),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Center(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 15,
                          ),
                          backgroundColor: Color.fromARGB(255, 255, 255, 255),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text("DONE",
                            style: TextStyle(
                                fontSize: 17,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 3, 0, 28))),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                              "Are you sure you want to delete your accounnt?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("No",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 17)),
                            ),
                            TextButton(
                              onPressed: () async {
                                // CollectionReference user = FirebaseFirestore
                                //     .instance
                                //     .collection('users');
                                // // user.delete();
                                final CollectionReference users =
                                    FirebaseFirestore.instance
                                        .collection('user');
                                User user = FirebaseAuth.instance.currentUser!;
                                Future deleteuser() {
                                  return users.doc(user.uid).delete();
                                }

                                Navigator.pop(context);
                              },
                              child: Text(
                                "Yes",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17),
                              ),
                            ),
                          ],
                        );
                      });
                },
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    Icon(Icons.delete, color: Colors.red),
                    SizedBox(width: 20),
                    Text("Delete Account",
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 22,
                            fontFamily: 'Source Sans Pro',
                            letterSpacing: -0.5,
                            fontWeight: FontWeight.bold)),
                    SizedBox(width: 120),
                    Icon(Icons.arrow_forward_ios, color: Colors.black),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
