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
  FirebaseAuth auth=FirebaseAuth.instance;
  User user=FirebaseAuth.instance.currentUser!;
  TextEditingController _name = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _location = new TextEditingController();
  TextEditingController _phone = new TextEditingController();
  // QuerySnapshot userid=await FirebaseFirestore.instance.collection('user').where('UID',isEqualTo: user.uid).limit(1).get();
   
  bool showPassword = false;
  //FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  initState(){
    super.initState();
    CollectionReference users = FirebaseFirestore.instance.collection('user');
    FirebaseFirestore.instance.collection("user").doc(user.uid).get().then((value) {
      _name.text=value['name'];
      _email.text=value['email'];
      _location.text=value['location'];
      _phone.text=value['phone'];
      _email.text=value['email'];
      
    });

    // _email= TextEditingController(text:user.email);


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Swif⚡ype',style: TextStyle(color: Colors.black),),
        // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
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
              Text(
                "Edit Profile",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                "images/pfp.jfif",
                              ))),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.green,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => ProfileScree()),
                              // );
                            },
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ),
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
              padding: const EdgeInsets.only(bottom: 35.0),
              child: TextField(
                controller: _name,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: 'Full Name',
                    
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
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
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
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
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 35.0),
              child: TextField(
                controller: _phone,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: 'Phone',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
              ),
            ),
          ],
        )
      ),
              // buildTextField("Full Name", _name),
              // buildTextField("E-mail", _email),
              // buildTextField("Location", _location),
              // buildTextField("Phone", _phone),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 50),
                  Center(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                      ),
                    onPressed: () {Navigator.pop(context);},
                    child: Text("CANCEL",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black)),
                    ),
                  ),
                  SizedBox(height: 50),
                  Center(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                      ),
                     onPressed: () async{
                      CollectionReference users = FirebaseFirestore.instance.collection('user');
                      FirebaseFirestore.instance.collection("user").doc(user.uid).set({"name":_name.text,
                      'email':_email.text,
                      'location': _location.text,
                      'phone': _phone.text,
                      'UID':user.uid 
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
                      // else
                      // {
                      //   final users = await FirebaseAuth.instance.currentUser!; 
                      // }
                      Navigator.push(
                        context, MaterialPageRoute(builder: (BuildContext context){
                          return HomePage(name: _name.text, email: _email.text, location: _location.text, phone: _phone.text);
                        },),
                      );
                    },
                    child: Text("SAVE",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black)),
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
    return Scaffold(
      // body: Center(
      //   child: Column(
      //     children: [
      //       Padding(
      //         padding: const EdgeInsets.only(bottom: 35.0),
      //         child: TextField(
      //           controller: _name,
      //           decoration: InputDecoration(
      //               contentPadding: EdgeInsets.only(bottom: 3),
      //               labelText: 'Full Name',
      //               floatingLabelBehavior: FloatingLabelBehavior.always,
      //               hintStyle: TextStyle(
      //                 fontSize: 16,
      //                 fontWeight: FontWeight.bold,
      //                 color: Colors.black,
      //               )),
      //         ),
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.only(bottom: 35.0),
      //         child: TextField(
      //           controller: _email,
      //           decoration: InputDecoration(
      //               contentPadding: EdgeInsets.only(bottom: 3),
      //               labelText: 'E-mail',
      //               floatingLabelBehavior: FloatingLabelBehavior.always,
      //               hintStyle: TextStyle(
      //                 fontSize: 16,
      //                 fontWeight: FontWeight.bold,
      //                 color: Colors.black,
      //               )),
      //         ),
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.only(bottom: 35.0),
      //         child: TextField(
      //           controller: _location,
      //           decoration: InputDecoration(
      //               contentPadding: EdgeInsets.only(bottom: 3),
      //               labelText: 'Location',
      //               floatingLabelBehavior: FloatingLabelBehavior.always,
      //               hintStyle: TextStyle(
      //                 fontSize: 16,
      //                 fontWeight: FontWeight.bold,
      //                 color: Colors.black,
      //               )),
      //         ),
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.only(bottom: 35.0),
      //         child: TextField(
      //           controller: _phone,
      //           decoration: InputDecoration(
      //               contentPadding: EdgeInsets.only(bottom: 3),
      //               labelText: 'Phone',
      //               floatingLabelBehavior: FloatingLabelBehavior.always,
      //               hintStyle: TextStyle(
      //                 fontSize: 16,
      //                 fontWeight: FontWeight.bold,
      //                 color: Colors.black,
      //               )),
      //         ),
      //       ),
      //     ],
      //   )
      // )
    );

    // if(labelText=="Full Name"){
    //   onChanged: (text1){
    //     placeholder = text1;
    //   };
    // }
    // else if(labelText=="E-mail"){
    //   onChanged: (text2){
    //     placeholder = text2;
    //   };
    // }
    // else if(labelText=="Location"){
    //   onChanged: (text3){
    //     placeholder = text3;
    //   };
    // }
    // else if(labelText=="Phone"){
    //   onChanged: (text4){
    //    placeholder = text4;
    //   };
    // }
  }
}