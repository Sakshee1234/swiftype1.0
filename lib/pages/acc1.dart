
import 'package:creationofswiftype/pages/acc4.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:loginpage/navigators/feedback.dart';
import '../navigators/feedback.dart';
import 'about.dart';
import 'acc2.dart';
// import 'account/acc2.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//       ),
//       home: SettingPage(),
//     );
//   }
// }
enum Language { English }
class SettingPage extends StatefulWidget {
  const SettingPage({super.key});
  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  Language? _language;Language? English;
  bool valNotify1 = true;
  bool valNotify2 = true;
 void signUserOut() async {
    await FirebaseAuth.instance.signOut();
  }
  onChangeFunction1(bool newValue1){
    setState(() {
      valNotify1 = newValue1;
      
    });
  }

  onChangeFunction2(bool newValue2){
    setState(() {
      valNotify2 = newValue2;
      if(valNotify2==false)
      {
        theme: ThemeData(brightness: Brightness.dark);
      }
    });
  }

  // yourprofnav(){
  //   onPressed: () {
  //     Navigator.push(
  //       context, MaterialPageRoute(builder: (BuildContext context){
  //         return EditProfilePage();
  //       },
  //       ),
  //     );
  //   };
  // }

  // youraccnav(){
  //   onPressed: () {
  //     Navigator.push(
  //       context, MaterialPageRoute(builder: (BuildContext context){
  //         return HomePage();
  //       },
  //       ),
  //     );
  //   };
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Account", style: TextStyle(fontSize: 22)),
      //   leading: IconButton(
      //     onPressed: () {},
      //     icon: Icon(
      //       Icons.arrow_back,
      //       color: Colors.white,
      //     ),
      //   ),
      // ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  SizedBox(width: 10),
                  Text("Account", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold
                  ))
                ],
              ),
              Divider(height: 20, thickness: 1),
              SizedBox(height: 10),
              buildAccountOption(context, "Your Profile"),
              buildAccountOption(context, "Manage Profile Settings"),
              
              SizedBox(height: 50),
              GestureDetector(
                onTap:(){showDialog(context: context, builder: (context)=>AlertDialog(
                  title:Column(children:[Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('English',style: TextStyle(fontSize: 20),),
                          Radio<Language>(
                            value: Language.English,
                            groupValue: _language,
                            onChanged: (Language? value) {
                              setState(() {
                                _language = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),]),
                  actions: [
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text('OK'))
                  ],
              ));
              },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.language_outlined, color: Colors.black),
                        SizedBox(width: 8),
                        Text("Language Preference", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold
                        )),
                      ],
                    ),
                    // SizedBox(width: 84),
                    Icon(Icons.arrow_forward_ios, color: Colors.black),
                  ],
                ),
              ),
      

              
              SizedBox(height: 50),
              GestureDetector(
               onTap: () {
                  Navigator.push(
                    context,MaterialPageRoute(builder: (context)=>myfeedback())
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.feedback_outlined, color: Colors.black),
                        SizedBox(width: 10),
                        Text("Provide Feedback", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold
                        )),
                      ],
                    ),
                    // SizedBox(width: 116),
                    Icon(Icons.arrow_forward_ios, color: Colors.black),
                  ],
                ),
              ),
              
              SizedBox(height: 50),
              GestureDetector(
                onTap:(){
                  // showAboutDialog(context:context);
                  showDialog(context: context, builder: (context)=>AboutDialog(applicationName: "About Swift⚡ype",
                    applicationVersion: '0.0.1',
                    applicationLegalese: "Developed by ASV",
                    children: <Widget>[
                      Text(
                          'Displays an AboutDialog, which describes the application and provides a button to show licenses for software used by the application. The arguments correspond to the properties on AboutDialog. If the application has a Drawer, consider using AboutListTile instead of calling this directly. If you do not need an about box in your application, you should at least provide an affordance to call showLicensePage. The licenses shown on the LicensePage are those returned by the LicenseRegistry API, which can be used to add more licenses to the list. The context, useRootNavigator, routeSettings and anchorPoint arguments are passed to showDialog, the documentation for which discusses how it is used.')
                    ],));
                  //  Navigator.push(context, MaterialPageRoute(builder: (context)=>myaboutpg()));
                  },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outlined, color: Colors.black),
                        SizedBox(width: 10),
                        Text("About", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold
                        )),
                      ],
                    ),
                    // SizedBox(width: 232),
                    Icon(Icons.arrow_forward_ios, color: Colors.black),
                  ],
                ),
              ),
              
              // SizedBox(height: 20),
              // Row(
              //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Icon(Icons.notifications_outlined, color: Colors.black),
              //     buildNotificationOption("Notifications", valNotify1, onChangeFunction1)
              //   ],
              // ),
      
              SizedBox(height: 30),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.light_mode, color: Colors.black),
                  buildNotificationOption("Theme Dark ", valNotify2, onChangeFunction2)
                ],
              ),
              
              SizedBox(height: 45),
              GestureDetector(
                onTap: (){
                  showDialog(context: context, builder: (context){
                    return AlertDialog(
                      title: Text("Are you sure you want to logout?"),
                      actions: [
                        TextButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: Text("No", style: TextStyle(color: Colors.green)),
                        ),
                        TextButton(
                          onPressed: (){
                            signUserOut();
                            Navigator.pop(context);
                          },
                          child: Text("Yes",style: TextStyle(color: Colors.green),),
                        ),
                      ],
                    );
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.logout, color: Colors.black),
                        SizedBox(width: 10),
                        Text("Logout", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold
                        )),
                      ],
                    ),
                    // SizedBox(width: 220),
                    Icon(Icons.arrow_forward_ios, color: Colors.black),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildNotificationOption(String title, bool value, Function onChangeMethod){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black
          )),
          SizedBox(width: 109),
          Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              activeColor: Colors.green,
              trackColor: Colors.black,
              value: value,
              onChanged: (bool newValue){
                onChangeMethod(newValue);
              },
            ),
          )
        ],
      ),
      );

  }

  GestureDetector buildAccountOption(BuildContext context, String title){
    return GestureDetector(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600]
          )),
          OutlinedButton(onPressed: () { 
             Navigator.push(
                context, MaterialPageRoute(builder: (BuildContext context){
                  if(title=="Manage Profile Settings")
                  {
                    return EditProfilePage();
                  }
                  else if(title=="Your Profile")
                  {
                    return ProfilePage();
                  }
                  return SettingPage();
                },
              ),
            );
          },
          child: Icon(Icons.arrow_forward_ios, color: Colors.grey),
          ) 
        ],
      ),
    );
  }
}
