import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creationofswiftype/model/word_dic.dart';
import 'package:creationofswiftype/pages/acc3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  User user = FirebaseAuth.instance.currentUser!;
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
              fontWeight: FontWeight.bold),
        ),
        // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("user")
            .where("UID", isEqualTo: user.uid)
            .limit(1)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                ProfileModel p =
                    ProfileModel.fromJSON(snapshot.data.docs[index]);
                // var data = snapshot.data.docs[index];
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 120,
                      ),
                      // CircleAvatar(
                      //   radius: 50,
                      //   backgroundImage: AssetImage('images/pfp.jfif'),
                      // ),
                      Text(
                        p.name,
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.black,
                            letterSpacing: -0.2,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Source Sans Pro"),
                      ),
                      SizedBox(
                        height: 60,
                        width: 200,
                        child: Divider(
                          color: Colors.white,
                        ),
                      ),
                      InfoCard(
                          placeholder: p.phone,
                          icon: Icons.phone,
                          onPressed: () async {}),
                      InfoCard(
                          placeholder: p.location,
                          icon: Icons.location_city,
                          onPressed: () async {}),
                      InfoCard(
                          placeholder: p.email,
                          icon: Icons.email,
                          onPressed: () async {}),
                    ],
                  ),
                );
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
