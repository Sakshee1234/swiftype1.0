import 'package:creationofswiftype/navigators/feedback.dart';
import 'package:creationofswiftype/pages/acc2.dart';
import 'package:creationofswiftype/pages/acc4.dart';
// import 'package:creationofswiftype/pages/theme_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return ChangeNotifierProvider(
      // create: (context) => ThemeSettings(),
      // builder: (context, child) {
      //   final settings = context.watch<ThemeSettings>();
        //final settings = Provider.of<ThemeSettings>(context);
        return MaterialApp(
          title: 'Flutter Demo',
          // theme: settings.currentTheme,
          home: Settingpage(),
        );
      // },
    // );
  }
}

enum Language { English }

class Settingpage extends StatefulWidget {
  const Settingpage({Key? key}) : super(key: key);
  @override
  State<Settingpage> createState() => _SettingPageState();
}

class _SettingPageState extends State<Settingpage> {
  // bool valNotify1 = true;
  // bool valNotify2 = true;
  Language? _language;
  Language? English;
  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
  }

  int _counter = 0;
  // void _toggleTheme() {
  //   final settings = Provider.of<ThemeSettings>(context, listen: false);
  //   settings.toggleTheme();
  // }

  // onChangeFunction1(bool newValue1){
  //   setState(() {
  //     valNotify1 = newValue1;
  //   });
  // }

  // onChangeFunction2(bool newValue2){
  //   setState(() {
  //     valNotify2 = newValue2;
  //   });
  // }

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
  //String? language;
  @override
  Widget build(BuildContext context) {
    // return Consumer(
    //   builder: (context, ThemeModel themeNotifier, child){
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 3, 44, 46),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.green,
      //   onPressed: _toggleTheme,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.lightbulb_outline),
      // ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20),
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                SizedBox(width: 10),
                Text("Account",
                    style: TextStyle(fontSize: 22, //fontWeight: FontWeight.bold ,
                    color: Colors.white))
              ],
            ),
            Divider(height: 20, thickness: 1),
            SizedBox(height: 10),
            buildAccountOption(context, "Your Profile"),
            buildAccountOption(context, "Manage Profile Settings"),

            SizedBox(height: 50),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Column(children: [
                            Row(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'English',
                                      style: TextStyle(fontSize: 20),
                                    ),
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
                            ),
                          ]),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('OK'))
                          ],
                        ));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.language_outlined, color: Colors.white),
                      SizedBox(width: 8),
                      Text("Language Preference",
                          style: TextStyle(
                              fontSize: 22, //fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                  // SizedBox(width: 84),
                  Icon(Icons.arrow_forward_ios, color: Colors.white),
                ],
              ),
            ),

            SizedBox(height: 50),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => myfeedback()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.feedback_outlined, color: Colors.white),
                      SizedBox(width: 10),
                      Text("Provide Feedback",
                          style: TextStyle(
                              fontSize: 22, //fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                  // SizedBox(width: 116),
                  Icon(Icons.arrow_forward_ios, color: Colors.white),
                ],
              ),
            ),

            SizedBox(height: 50),

            GestureDetector(
              onTap: () {
                // showAboutDialog(context:context);
                showDialog(
                    context: context,
                    builder: (context) => AboutDialog(
                          applicationName: "About Swift⚡ype",
                          applicationVersion: '0.0.1',
                          applicationLegalese: "Developed by ASV",
                          children: <Widget>[
                            Text(
                                'Displays an AboutDialog, which describes the application and provides a button to show licenses for software used by the application. The arguments correspond to the properties on AboutDialog. If the application has a Drawer, consider using AboutListTile instead of calling this directly. If you do not need an about box in your application, you should at least provide an affordance to call showLicensePage. The licenses shown on the LicensePage are those returned by the LicenseRegistry API, which can be used to add more licenses to the list. The context, useRootNavigator, routeSettings and anchorPoint arguments are passed to showDialog, the documentation for which discusses how it is used.')
                          ],
                        ));
                //  Navigator.push(context, MaterialPageRoute(builder: (context)=>myaboutpg()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outlined, color: Colors.white),
                      SizedBox(width: 10),
                      Text("About",
                          style: TextStyle(
                              fontSize: 22,//fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                  // SizedBox(width: 232),
                  Icon(Icons.arrow_forward_ios, color: Colors.white),
                ],
              ),
            ),
            // SizedBox(height: 40),
            // Row(
            //   children: [
            //     //Icon(Icons.notifications_outlined, color: Colors.white),
            //     //buildNotificationOption("Notifications", valNotify1, onChangeFunction1)
            //   ],
            // ),

            // SizedBox(height: 20),
            // Row(
            //   children: [
            //     //Icon(Icons.light_mode, color: Colors.white),
            //     //buildNotificationOption("Theme Dark ", valNotify2, onChangeFunction2)
            //   ],
            // ),

            SizedBox(height: 50),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Are you sure you want to logout?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("No",
                                style: TextStyle(color: Color.fromARGB(255, 3, 44, 46))),
                          ),
                          TextButton(
                            onPressed: () {
                              signUserOut();
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Yes",
                              style: TextStyle(color: Color.fromARGB(255, 3, 44, 46)),
                            ),
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
                      Icon(Icons.logout, color: Colors.white),
                      SizedBox(width: 10),
                      Text("Logout",
                          style: TextStyle(
                              fontSize: 22,
                              //fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                  // SizedBox(width: 220),
                  Icon(Icons.arrow_forward_ios, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    //   }
    // );
  }

  GestureDetector buildAccountOption(BuildContext context, String title) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: 20,
                    //fontWeight: FontWeight.w500,
                    color: Colors.white)),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      if (title == "Manage Profile Settings") {
                        return EditProfilePage();
                      } else if (title == "Your Profile") {
                        return ProfilePage();
                      }
                      return Settingpage();
                    },
                  ),
                );
              },
              child: Icon(Icons.arrow_forward_ios, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
