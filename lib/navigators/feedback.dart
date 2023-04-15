import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../firebaseservices.dart';

class myfeedback extends StatefulWidget {
  const myfeedback({super.key});

  @override
  State<myfeedback> createState() => _feedbackState();
}

class _feedbackState extends State<myfeedback> {

  TextEditingController feedback=TextEditingController();
  TextEditingController mail=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // appBar: AppBar(
      //     iconTheme: IconThemeData(color: Colors.white),
      //     backgroundColor: Colors.green,
      //     elevation: 2.0,
      //     centerTitle: true,
      //     title: Text("Feedback",
      //         style:
      //             TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      //     leading: IconButton(
      //       icon: Icon(Icons.arrow_back),
      //       onPressed: () {},
      //     )),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Swif⚡ype',style: TextStyle(color: Colors.black),),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
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
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.all(16.0),
                        ),
                        onPressed: () async {
                          await FirestoreService().insertfeedback(feedback.text,mail.text);
                          Navigator.pop(context);
                          showDialog(context: context, builder: (context) => AlertDialog(
                            title: Text("Thank you for your feedback"),
                            actions: [
                              TextButton(onPressed: (){
                                Navigator.pop(context);
                              }, child: Text("OK",style: TextStyle(color: Colors.green),))
                            ],
                          ));
                          },
                        child: Text("Submit",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
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
        color: Colors.green,
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
                      )),
                  Icon(Icons.arrow_drop_down, color: Colors.grey),
                  SizedBox(width: 10.0),
                ]))
          ],
        ),
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 14.0,
        ),
        hintText: "Enter your Email",
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
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
                fontSize: 13.0,
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
                    SizedBox(width: 15.0),
                    Text(
                      "Add a screenshot",
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildCheckItem(title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: <Widget>[
          Icon(Icons.check_circle_outline, color: Colors.green),
          SizedBox(width: 20.0),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
          )
        ],
      ),
    );
  }
}

// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:creationofswiftype/pages/photo.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// import '../firebaseservices.dart';


// class myfeedback extends StatefulWidget {
//   const myfeedback({super.key});

//   @override
//   State<myfeedback> createState() => _feedbackState();
// }

// class _feedbackState extends State<myfeedback> {
//   File? file;
//   ImagePicker image = ImagePicker();
//   TextEditingController feedback=TextEditingController();
//   TextEditingController mail=TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(

//       // appBar: AppBar(
//       //     iconTheme: IconThemeData(color: Colors.white),
//       //     backgroundColor: Colors.green,
//       //     elevation: 2.0,
//       //     centerTitle: true,
//       //     title: Text("Feedback",
//       //         style:
//       //             TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//       //     leading: IconButton(
//       //       icon: Icon(Icons.arrow_back),
//       //       onPressed: () {},
//       //     )),
//       appBar: AppBar(
//         backgroundColor: Colors.green,
//         title: Text('Swif⚡ype',style: TextStyle(color: Colors.black),),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children:[
//                 SizedBox(height: 10.0),
//                 // Text("SwifType",
//                 //     style: TextStyle(
//                 //         color: Colors.green,
//                 //         fontWeight: FontWeight.bold,
//                 //         fontSize: 20.0)),
//                 SizedBox(height: 25.0),
//                 // buildCheckItem("Suggestions are irrelevant"),
//                 // buildCheckItem("Not user friendly"),
//                 // buildCheckItem("Offensive"),
//                 // buildCheckItem("Other issues"),
//                 // buildCheckItem("Suggestions "),
//                 // SizedBox(height: 20.0),
//                 buildFeedbackForm(),
//                 SizedBox(height: 20.0),
//                 buildFeedbackField(),
//                 Spacer(),
//                 Row(
//                   children: <Widget>[
//                     Expanded(
//                       child: TextButton(
//                         style: TextButton.styleFrom(
//                           backgroundColor: Colors.green,
//                           padding: EdgeInsets.all(16.0),
//                         ),
//                         onPressed: () async {
//                           await FirestoreService().insertfeedback(feedback.text,mail.text);
//                           Navigator.pop(context);
//                           showDialog(context: context, builder: (context) => AlertDialog(
//                             title: Text("Thank you for your feedback"),
//                             actions: [
//                               TextButton(onPressed: (){
//                                 Navigator.pop(context);
//                               }, child: Text("OK",style: TextStyle(color: Colors.green),))
//                             ],
//                           ));
//                           },
//                         child: Text("Submit",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold)),
//                       ),
//                     )
//                   ],
//                 )
//               ]),
//         ),
//       ),
//     );
//   }

//   buildFeedbackField() {
//     return TextField(
//       controller: mail,
//       style: TextStyle(
//         color: Colors.green,
//       ),
//       decoration: InputDecoration(
//         contentPadding: EdgeInsets.all(0.0),
//         prefixIcon: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Container(
//                 decoration: BoxDecoration(
//                     border: Border(
//                   right: BorderSide(width: 1.0, color: Colors.grey),
//                 )),
//                 child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
//                   Icon(Icons.email, color: Colors.grey),
//                   SizedBox(width: 5.0),
//                   Text("Email",
//                       style: TextStyle(
//                         color: Colors.grey,
//                         fontWeight: FontWeight.bold,
//                       )),
//                   Icon(Icons.arrow_drop_down, color: Colors.grey),
//                   SizedBox(width: 10.0),
//                 ]))
//           ],
//         ),
//         hintStyle: TextStyle(
//           color: Colors.grey,
//           fontSize: 14.0,
//         ),
//         hintText: "Enter your Email",
//         border: OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.grey),
//         ),
//       ),
//     );
//   }

//   buildFeedbackForm() {
//     return Container(
//       height: 200.0,
//       child: Stack(
//         children: <Widget>[
//           TextField(
//             controller: feedback,
//             maxLines: 10,
//             decoration: InputDecoration(
//               hintText: " Enter your feedback here",
//               hintStyle: TextStyle(
//                 fontSize: 13.0,
//                 color: Colors.grey,
//               ),
//               border: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.grey),
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               decoration: BoxDecoration(
//                 border: Border(
//                   top: BorderSide(
//                     width: 1.0,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Row(
//                   children: <Widget>[
//                     Container(
//                         decoration: BoxDecoration(
//                           color: Colors.grey,
//                           borderRadius: BorderRadius.circular(5.0),
//                         ),
//                         child: Padding(
//                             padding: EdgeInsets.all(5.0),
//                             child: Icon(
//                               Icons.add,
//                               color: Colors.white,
//                             ))

//                         ),
//                         SizedBox(width: 20.0),
                        
//                         MaterialButton(
//                           onPressed: () {
//                             //getgall();
//                             Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
//                               return SS();
//                             }));
//                           },
//                           color: Colors.blue[900],
//                           child: Text(
//                             "Add a screenshot",
//                             style: TextStyle(
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ),
//                     // Text(
//                     //   "Add a screenshot",
//                     //   style: TextStyle(color: Colors.grey),
//                     // )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//   // getgall() async {
//   //   // ignore: deprecated_member_use
//   //   var img = await image.getImage(source: ImageSource.gallery);
//   //   setState(() {
//   //     file = File(img!.path);
//   //   });
//   // }

//   buildCheckItem(title) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 20.0),
//       child: Row(
//         children: <Widget>[
//           Icon(Icons.check_circle_outline, color: Colors.green),
//           SizedBox(width: 20.0),
//           Text(
//             title,
//             style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
//           )
//         ],
//       ),
//     );
//   }
// }