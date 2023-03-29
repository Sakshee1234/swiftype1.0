// import 'package:flutter/material.dart';

// class Dictionary extends StatefulWidget {
//   const Dictionary({Key? key}) : super(key: key);
//   @override
//   _DictionaryState createState() => _DictionaryState();
// }

// class _DictionaryState extends State<Dictionary> {
//   final TextEditingController _textEditingController = TextEditingController();
//   final List<String> _phrases = [];

//   void _addPhrase(String phrase) {
//     setState(() {
//       _phrases.add(phrase);
//       _textEditingController.clear(); // clear the text field
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: const Text("My Dictionary"),
//       //   backgroundColor: Colors.green,
//       // ),
//       body: ListView.builder(
//         itemCount: _phrases.length,
//         itemBuilder: (context, index) => Column(
//           children: [
//             ListTile(
//               title: Text(_phrases[index]),
//             ),
//             const Divider(
//               color: Colors.grey,
//               height: 1,
//               thickness: 0.4,
//             ), // add a divider after each list tile
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showDialog(
//             context: context,
//             builder: (context) => AlertDialog(
//               title: const Text('Enter the phrase'),
//               content: TextField(
//                 controller: _textEditingController,
//                 decoration: const InputDecoration(
//                   hintText: 'Enter the word/phrase',
//                 ),
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     _addPhrase(_textEditingController.text);
//                     Navigator.pop(context);
//                   },
//                   child: const Text('Add'),
//                 ),
//               ],
//             ),
//           );
//         },
//         child: const Icon(Icons.add),
//         backgroundColor: Colors.green,
//       ),
//     );
//   }
// }
import 'package:creationofswiftype/firebaseservices.dart';
import 'package:creationofswiftype/model/word_dic.dart';
import 'package:creationofswiftype/pages/add_note.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Dictionary extends StatefulWidget {
  const Dictionary({Key? key}) : super(key: key);
  
  @override
  _DictionaryState createState() => _DictionaryState();
}

class _DictionaryState extends State<Dictionary> {
  final TextEditingController _textEditingController =
      TextEditingController();
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  FirebaseAuth auth=FirebaseAuth.instance;
  User user=FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:StreamBuilder(
        stream: FirebaseFirestore.instance.collection('words').where('UID',isEqualTo: user.uid).snapshots(),
        builder: (context,AsyncSnapshot snapshot){
          if (snapshot.hasData)
          {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context,index){
                WordModel w=WordModel.fromJSON(snapshot.data.docs[index]);
                return Card(
                  elevation: 5,
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    title: Text(w.word),
                  ),
                );
              },
            );
          }
          else
          {
            return Center(child:Text('No words'));
          }
        },
      ),
     floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.green,
      child:Icon(Icons.add),
      onPressed: (){
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Enter the phrase'),
              content: TextField(
                controller: _textEditingController,
                decoration: const InputDecoration(
                  hintText: 'Enter the word/phrase',
                ),
              ),actions: [
                TextButton (
                  onPressed: () async {
                    await FirestoreService().insertWord(_textEditingController.text,user.uid);
                     Navigator.pop(context);
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          );
         
      },
     ),
    );
  }
}


