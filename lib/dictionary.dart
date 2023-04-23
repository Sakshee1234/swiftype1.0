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
import 'package:creationofswiftype/pages/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class Dictionary extends StatefulWidget {
  const Dictionary({Key? key}) : super(key: key);

  @override
  _DictionaryState createState() => _DictionaryState();
}

class _DictionaryState extends State<Dictionary> {
//   Future<void> addword(String text) async {
//   final response = await http.get(Uri.parse('http://localhost:5000/autocomplete?text=$text'));
// }
  final TextEditingController _textEditingController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  User user = FirebaseAuth.instance.currentUser!;
  addword d=addword();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 3, 44, 46),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('words')
            .where('UID', isEqualTo: user.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                WordModel w = WordModel.fromJSON(snapshot.data.docs[index]);
                return Card(
                  elevation: 5,
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    textColor: Colors.white,
                    tileColor: Color.fromARGB(255, 5, 70, 73),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(w.word),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () async {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text('Are you sure?'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'No',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            )),
                                        TextButton(
                                            onPressed: () async {
                                              await FirestoreService()
                                                  .deleteWord(w.id);
                                              d.remove(w.word);
                                              Navigator.pop(context);
                                            },
                                            child: Text('Yes',
                                                style: TextStyle(
                                                    color: Color.fromARGB(255, 20, 153, 24)))),
                                      ],
                                    ));
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No words'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          color: Color.fromARGB(255, 3, 44, 46),
        ),
        hoverColor: Color.fromARGB(255, 3, 44, 46),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Enter the word/phrase'),
              content: TextField(
                controller: _textEditingController,
                decoration: const InputDecoration(
                  hintText: 'Enter the word/phrase',
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    await FirestoreService()
                        .insertWord(_textEditingController.text, user.uid);
                    d.addwordtodict(_textEditingController.text);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Add',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
