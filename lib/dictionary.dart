import 'package:creationofswiftype/firebaseservices.dart';
import 'package:creationofswiftype/model/word_dic.dart';
//import 'package:creationofswiftype/pages/add_note.dart';
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
  addword d = addword();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
                    tileColor: Color.fromARGB(255, 2, 16, 41),
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
                                      title: Text('Are you sure?',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontFamily: 'Source Sans Pro',
                                              fontWeight: FontWeight.bold)),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'No',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontFamily:
                                                      'Source Sans Pro'),
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
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontFamily:
                                                        'Source Sans Pro'))),
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
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        child: Icon(
          Icons.add,
          color: Color.fromARGB(255, 3, 0, 28),
        ),
        hoverColor: Color.fromARGB(255, 3, 0, 28),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text(
                'Enter the word/phrase',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Source Sans Pro',
                    fontWeight: FontWeight.bold),
              ),
              content: TextField(
                controller: _textEditingController,
                decoration: const InputDecoration(
                  hintText: 'Enter the word/phrase',
                  hintStyle: TextStyle(
                      color: Color.fromARGB(100, 0, 0, 0),
                      fontSize: 16,
                      fontFamily: 'Source Sans Pro'),
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
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Source Sans Pro',
                      fontWeight: FontWeight.bold,
                    ),
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
