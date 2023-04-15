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
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(w.word),
                        IconButton(
                          icon: Icon(Icons.delete,color: Colors.green,),
                          onPressed: () async {
                            showDialog(context: context,builder: (context)=>AlertDialog(
                              title: Text('Are you sure?'),
                              actions: [
                                TextButton(onPressed: (){
                                  Navigator.pop(context);
                                }, child: Text('No',style: TextStyle(color: Colors.green),)),
                                TextButton(onPressed: () async{
                                  await FirestoreService().deleteWord(w.id);
                                  Navigator.pop(context);
                                }, child: Text('Yes',style:TextStyle(color: Colors.green))),
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
                  child: const Text('Add',style: TextStyle(color: Colors.green),),
                ),
              ],
            ),
          );
         
      },
     ),
    );
  }
}


