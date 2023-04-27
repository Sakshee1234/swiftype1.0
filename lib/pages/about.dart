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
      height: 20,
      child: AboutDialog(
        applicationName: "About SWIF⚡YPE",
        //style: TextStyle(fontSize: 20),
        applicationVersion: '0.0.1',
        applicationLegalese: "Developed by ASV",
        children: <Widget>[
          // SizedBox(height: 100),
          Text(
            'Displays an AboutDialog, which describes the application and provides a button to show licenses for software used by the application. The arguments correspond to the properties on AboutDialog. If the application has a Drawer, consider using AboutListTile instead of calling this directly. If you do not need an about box in your application, you should at least provide an affordance to call showLicensePage. The licenses shown on the LicensePage are those returned by the LicenseRegistry API, which can be used to add more licenses to the list. The context, useRootNavigator, routeSettings and anchorPoint arguments are passed to showDialog, the documentation for which discusses how it is used.',
            //style: TextStyle(fontSize: 890),
          )
        ],
      ),
    );
  }
}
