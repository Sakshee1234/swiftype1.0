import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService{
  FirebaseFirestore f=FirebaseFirestore.instance;

  Future insertWord(String word,String UID) async{
    try{
      await f.collection('words').add({
        'word':word,
        'UID':UID,
        "date":DateTime.now(),
      }
      );
    }catch(e)
    {
    }
  }
  Future deleteWord(String id) async{
    try{
      await f.collection('words').doc(id).delete();
    }catch(e)
    {
    }
  }
}