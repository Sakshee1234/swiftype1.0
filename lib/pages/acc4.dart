import 'package:cloud_firestore/cloud_firestore.dart';
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
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Profile", style: TextStyle(fontSize: 22)),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context, snapshot){
          List<Row> clientWidgets = [];
          if(snapshot.hasData){
            final user = snapshot.data?.docs.reversed.toList();
            for(var users in user!)
            {
              final clientWidget = Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(users['name']),
                  Text(users['email']),
                  Text(users['location']),
                  Text(users['phone']),
                ],
              );
              clientWidgets.add(clientWidget);
            }
          }
          return Expanded(
            child: ListView(
              children: clientWidgets,
            ),
          );
        },
      ),
    );
  } 
}