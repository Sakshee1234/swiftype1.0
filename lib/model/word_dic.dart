import 'package:cloud_firestore/cloud_firestore.dart';
class WordModel{
  String id;
  String word;
  Timestamp date;
  String UID;

  WordModel({required this.id,
  required this.word,
  required this.date,
  required this.UID});

  factory WordModel.fromJSON(DocumentSnapshot doc){
    return WordModel(
      id:doc.id,
      word:doc['word'],
      date:doc['date'],
      UID:doc['UID']
    );
  }
}