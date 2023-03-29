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


class ProfileModel{
  
  String id;
  String name;
  String email;
  String phone;
  String location;
  String UID;
  ProfileModel({required this.id,required this.name,required this.email,required this.phone,required this.location,required this.UID});

  factory ProfileModel.fromJSON(DocumentSnapshot doc){
    return ProfileModel(
      id:doc.id,
      name:doc['name'],
      email:doc['email'],
      phone:doc['phone'],
      location:doc['location'],
      UID:doc['UID']
    );
  }
}