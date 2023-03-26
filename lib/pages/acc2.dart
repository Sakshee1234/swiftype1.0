// import 'package:account1/acc3.dart';
import 'package:creationofswiftype/pages/acc3.dart';
import 'package:flutter/material.dart';
// import 'package:swiftypeversion2/pages/acc3.dart';

// void main(){
//   runApp(SettingsUI());
// }
// class SettingsUI extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: "Setting UI",
//       home: EditProfilePage(),
//     );
//   }
// }

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _name = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _location = new TextEditingController();
  TextEditingController _phone = new TextEditingController();
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.green,
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
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
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
                    onPressed: () {},
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
                    onPressed: () {
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