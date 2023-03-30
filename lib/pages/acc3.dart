import 'package:creationofswiftype/pages/acc1.dart';
import 'package:flutter/material.dart';
// import 'package:account1/acc2.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       //home: ProfilePage(),
//     );
//   }
// }

// class ProfilePage extends StatelessWidget{
//   String name, email, location, phone;
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return HomePage(name: name, email: email, location: location, phone: phone);
//   }

// }

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
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.teal,
          ),
          title: Text(
            placeholder,
            style: TextStyle(
                color: Colors.teal,
                fontSize: 18,
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
  HomePage({required this.name, required this.email, required this.location, required this.phone});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.green,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ]
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
                name, style: TextStyle(
                    fontSize: 40,
                    color: Colors.black,
                    letterSpacing: 2.5,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Source Sans Pro"),
              ),
              Text(
                "Flutter Developer",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.blueGrey,
                    letterSpacing: 2.5,
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

              // we will be creating a new widget name info carrd

              InfoCard(placeholder: phone, icon: Icons.phone, onPressed: () async {}),
              InfoCard(placeholder: location, icon: Icons.location_city, onPressed: () async {}),
              InfoCard(placeholder: email, icon: Icons.email, onPressed: () async {}),
              SizedBox(height: 30),
              Row(
              children: [
                Center(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 172),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                      ),
                    onPressed: (){
                      // CollectionReference users = firestore.collection('users');
                      // await users.add({
                      //   'name': 'Aakriti'
                      // });
                      // await users.doc("profile123").set({
                      //   'name': 'Aakriti'
                      // });
                      // Map <String,dynamic> data = {"feild1": _name.text, "feild2": _email.text, "feild3": _location.text, "feild4": _phone.text};
                      // Firestore.instance.collection("test").add(data);
                      // Navigator.push(
                  // context, MaterialPageRoute(builder: (BuildContext context){
                  //   return Settingpage();
                  // }));
                    Navigator.pop(context);
                    Navigator.pop(context);
                    },
                    child: Text("DONE",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black)),
                    ),
                  ),   
              ],
            ),
              SizedBox(height: 30),
            Row(
              children: [
                SizedBox(width: 20),
                Icon(Icons.delete, color: Colors.black),
                SizedBox(width: 20),
                Text("Delete Account", style: TextStyle(color: Color.fromARGB(255, 238, 28, 13), fontSize: 22, fontWeight: FontWeight.bold
                )),
                SizedBox(width: 120),
                Icon(Icons.arrow_forward_ios, color: Colors.black),   
              ],
            ), 

            ],
          ),
        ));
  }
}