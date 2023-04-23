// import 'package:flutter/material.dart';
// //import 'package:path/path.dart';

// class about extends StatefulWidget {
//   const about({Key? key}) : super(key: key);
//   @override
//   _aboutState createState() => _aboutState();
// }

// class _aboutState extends State<about> {
//   @override
//   Widget build(BuildContext context) {
//     return aboutMyApp();
// return Scaffold(
//   appBar: AppBar(
//     title: Text("About"),
//     backgroundColor: Colors.green,
//   ),
// drawer: Drawer(
//   child: ListView(
//     children: <Widget>[
//       ListTile(
//         onTap: aboutMyApp,
//         title: Text("Show about page"),

//       ),
//     ],
//   ),
// ),
//   body: Center(
//     child: TextButton(
//       child: Text("About Swift⚡ype"),
//       onPressed: aboutMyApp,
//     ),
//   ),
// );
//   }

// aboutMyApp() {
//   showAboutDialog(
//       context: context,
//       applicationName: "About Swift⚡ype",
//       applicationVersion: '0.0.1',
//       applicationLegalese: "Developed by ASV",
//       children: <Widget>[
//         Text(
//             'Displays an AboutDialog, which describes the application and provides a button to show licenses for software used by the application. The arguments correspond to the properties on AboutDialog. If the application has a Drawer, consider using AboutListTile instead of calling this directly. If you do not need an about box in your application, you should at least provide an affordance to call showLicensePage. The licenses shown on the LicensePage are those returned by the LicenseRegistry API, which can be used to add more licenses to the list. The context, useRootNavigator, routeSettings and anchorPoint arguments are passed to showDialog, the documentation for which discusses how it is used.')
//       ]);
//   }
// }
import 'package:flutter/material.dart';

class myaboutpg extends StatefulWidget {
  const myaboutpg({super.key});

  @override
  State<myaboutpg> createState() => _myaboutpgState();
}

class _myaboutpgState extends State<myaboutpg> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: AboutDialog(
        applicationName: "About Swift⚡ype",
        applicationVersion: '0.0.1',
        applicationLegalese: "Developed by ASV",
        children: <Widget>[
          Text(
            'Displays an AboutDialog, which describes the application and provides a button to show licenses for software used by the application. The arguments correspond to the properties on AboutDialog. If the application has a Drawer, consider using AboutListTile instead of calling this directly. If you do not need an about box in your application, you should at least provide an affordance to call showLicensePage. The licenses shown on the LicensePage are those returned by the LicenseRegistry API, which can be used to add more licenses to the list. The context, useRootNavigator, routeSettings and anchorPoint arguments are passed to showDialog, the documentation for which discusses how it is used.',
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }
}
