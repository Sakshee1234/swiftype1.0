// import 'package:account1/acc3.dart';
import 'package:creationofswiftype/model/word_dic.dart';
import 'package:creationofswiftype/pages/acc3.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}


class _EditProfilePageState extends State<EditProfilePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  User user = FirebaseAuth.instance.currentUser!;
  TextEditingController _name = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _location = new TextEditingController();
  TextEditingController _phone = new TextEditingController();
  // QuerySnapshot userid=await FirebaseFirestore.instance.collection('user').where('UID',isEqualTo: user.uid).limit(1).get();

  bool showPassword = false;
  //FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  initState() {
    super.initState();
    CollectionReference users = FirebaseFirestore.instance.collection('user');
    FirebaseFirestore.instance
        .collection("user")
        .doc(user.uid)
        .get()
        .then((value) {
      _name.text = value['name'];
      _email.text = value['email'];
      _location.text = value['location'];
      _phone.text = value['phone'];
      _email.text = value['email'];
    });

    // _email= TextEditingController(text:user.email);
  }

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
              fontFamily: 'Source Sans Pro'),
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
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              // Text(
              //   //"Edit Profile",
              //   // style: TextStyle(
              //   //     fontSize: 23,
              //   //     fontWeight: FontWeight.bold,
              //   //     fontFamily: 'Source Sans Pro'),
              // ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Stack(
                  children: [
                    // Container(
                    //   width: 130,
                    //   height: 130,
                    //   decoration: BoxDecoration(
                    //       border: Border.all(
                    //           width: 4,
                    //           color: Theme.of(context).scaffoldBackgroundColor),
                    //       boxShadow: [
                    //         BoxShadow(
                    //             spreadRadius: 2,
                    //             blurRadius: 10,
                    //             color: Colors.black.withOpacity(0.1),
                    //             offset: Offset(0, 10))
                    //       ],
                    //       // shape: BoxShape.circle,
                    //       // image: DecorationImage(
                    //       //     fit: BoxFit.cover,
                    //       //     // image: AssetImage(
                    //       //     //   // ignore: text_direction_code_point_in_literal
                    //       //     //   "C:/User/HP/Swiftype/admin.png",
                    //       //     // )
                    //       //     )
                    //       ),
                    // ),
                    // Positioned(
                    //     bottom: 0,
                    //     right: 0,
                    //     child: Container(
                    //       height: 40,
                    //       width: 40,
                    //       decoration: BoxDecoration(
                    //         shape: BoxShape.circle,
                    //         border: Border.all(
                    //           width: 4,
                    //           color: Theme.of(context).scaffoldBackgroundColor,
                    //         ),
                    //         color: Color.fromARGB(255, 70, 192, 74),
                    //       ),
                    //       child: GestureDetector(
                    //         onTap: () {
                    //           // Navigator.push(
                    //           //   context,
                    //           //   MaterialPageRoute(
                    //           //       builder: (context) => ProfileScree()),
                    //           // );
                    //         },
                    //         child: Icon(
                    //           Icons.edit,
                    //           color: Colors.white,
                    //         ),
                    //       ),
                    //     )),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Center(
                  child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 30.0,
                    ),
                    child: TextField(
                      controller: _name,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 3),
                          labelText: 'Full Name',
                          labelStyle: TextStyle(
                            fontFamily: 'Source Sans Pro',
                            fontSize: 22,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: "Name",
                          hintStyle: TextStyle(
                            fontSize: 16,
                            //fontWeight: FontWeight.bold,
                            fontFamily: 'Source Sans Pro',
                            color: Color.fromARGB(100, 0, 0, 0),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 35.0),
                    child: TextField(
                      controller: _email,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 3),
                          labelText: 'E-mail',
                          labelStyle: TextStyle(
                            fontFamily: 'Source Sans Pro',
                            fontSize: 22,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: "E-mail",
                          hintStyle: TextStyle(
                            fontSize: 16,
                            //fontWeight: FontWeight.bold,
                            fontFamily: 'Source Sans Pro',
                            color: Color.fromARGB(100, 0, 0, 0),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 35.0),
                    child: TextField(
                      controller: _location,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 3),
                          labelText: 'Location',
                          labelStyle: TextStyle(
                            fontFamily: 'Source Sans Pro',
                            fontSize: 22,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: "Location",
                          hintStyle: TextStyle(
                            fontSize: 16,
                            //fontWeight: FontWeight.bold,
                            fontFamily: 'Source Sans Pro',
                            color: Color.fromARGB(100, 0, 0, 0),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 35.0),
                    child: TextField(
                      controller: _phone,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 3),
                          labelText: 'Conatct No.',
                          labelStyle: TextStyle(
                            fontFamily: 'Source Sans Pro',
                            fontSize: 22,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: "Contact No.",
                          hintStyle: TextStyle(
                            fontSize: 16,
                            //fontWeight: FontWeight.bold,
                            color: Color.fromARGB(100, 0, 0, 0),
                            fontFamily: 'Source Sans Pro',
                          )),
                    ),
                  ),
                ],
              )),
              // buildTextField("Full Name", _name),
              // buildTextField("E-mail", _email),
              // buildTextField("Location", _location),
              // buildTextField("Phone", _phone),
              SizedBox(
                height: 17,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 20),
                  Center(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shadowColor: Colors.black,
                        backgroundColor: Color.fromARGB(255, 3, 0, 28),
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("CANCEL",
                          style: TextStyle(
                              fontSize: 16.7,
                              letterSpacing: 2,
                              fontFamily: "Source Sans Pro",
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shadowColor: Colors.black,
                        backgroundColor: Color.fromARGB(255, 3, 0, 28),
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      onPressed: () async {
                        CollectionReference users =
                            FirebaseFirestore.instance.collection('user');
                        FirebaseFirestore.instance
                            .collection("user")
                            .doc(user.uid)
                            .set({
                          "name": _name.text,
                          'email': _email.text,
                          'location': _location.text,
                          'phone': _phone.text,
                          'UID': user.uid
                        });
                        // if(users==null)
                        // {
                        //   users.add({
                        //       'name': _name.text,
                        //       'email': _email.text,
                        //       'location': _location.text,
                        //       'phone': _phone.text,
                        //       'UID':user.uid
                        //     });
                        // }
                        // elseser!;
                        // {
                        //   final users = await FirebaseAuth.instance.currentU
                        // }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return HomePage(
                                  name: _name.text,
                                  email: _email.text,
                                  location: _location.text,
                                  phone: _phone.text);
                            },
                          ),
                        );
                      },
                      child: Text("SAVE",
                          style: TextStyle(
                              fontSize: 16.7,
                              letterSpacing: 2,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Source Sans Pro")),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(BuildContext context) {
    return Scaffold();
  }
}
