import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creationofswiftype/navigators/feedback1.dart';
import 'package:creationofswiftype/pages/acc1.dart';
import 'package:creationofswiftype/pages/navigator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../firebaseservices.dart';

class myfeedback extends StatefulWidget {
  const myfeedback({super.key});

  @override
  State<myfeedback> createState() => _feedbackState();
}

class _feedbackState extends State<myfeedback> {
  File? file;
  ImagePicker image = ImagePicker();
  TextEditingController feedback = TextEditingController();
  TextEditingController mail = TextEditingController();
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
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: 10.0),
            // Text("SwifType",
            //     style: TextStyle(
            //         color: Colors.green,
            //         fontWeight: FontWeight.bold,
            //         fontSize: 20.0)),
            SizedBox(height: 25.0),
            // buildCheckItem("Suggestions are irrelevant"),
            // buildCheckItem("Not user friendly"),
            // buildCheckItem("Offensive"),
            // buildCheckItem("Other issues"),
            // buildCheckItem("Suggestions "),
            // SizedBox(height: 20.0),
            buildFeedbackForm(),
            SizedBox(height: 20.0),
            buildFeedbackField(),
            Spacer(),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 3, 0, 28),
                      padding: EdgeInsets.all(16.0),
                    ),
                    onPressed: () async {
                      await FirestoreService()
                          .insertfeedback(feedback.text, mail.text);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return Settingpage();
                          },
                        ),
                      );
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text("Thank you for your feedback"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return myNavigatorBar();
                                        }));
                                      },
                                      child: Text(
                                        "OK",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 17),
                                      ))
                                ],
                              ));
                    },
                    child: Text("Submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17.5,
                          fontFamily: 'Source Sans Pro',
                          //fontWeight: FontWeight.bold,
                          letterSpacing: 0.8,
                        )),
                  ),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }

  buildFeedbackField() {
    return TextField(
      controller: mail,
      style: TextStyle(
        color: Colors.black,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(0.0),
        prefixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    border: Border(
                  right: BorderSide(width: 1.0, color: Colors.grey),
                )),
                child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Icon(Icons.email, color: Colors.grey),
                  SizedBox(width: 5.0),
                  Text("Email",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                  Icon(Icons.arrow_drop_down, color: Colors.grey),
                  SizedBox(width: 10.0),
                ]))
          ],
        ),
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 15.0,
        ),
        hintText: "Enter your Email",
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  buildFeedbackForm() {
    return Container(
      height: 200.0,
      child: Stack(
        children: <Widget>[
          TextField(
            controller: feedback,
            maxLines: 10,
            decoration: InputDecoration(
              hintText: " Enter your feedback here",
              hintStyle: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 1.0,
                    color: Colors.grey,
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ))),
                    SizedBox(width: 20.0),

                    MaterialButton(
                      onPressed: () {
                        //getgall();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return AddItem();
                        }));
                      },
                      color: Colors.white,
                      child: Text(
                        "Add a screenshot",
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    ),
                    // Text(
                    //   "Add a screenshot",
                    //   style: TextStyle(color: Colors.grey),
                    // )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
