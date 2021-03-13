import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
bool isDeleted;
String email;
String uid;
String key;

UserModel({this.email, this.uid, this.key, this.isDeleted});

toJson(){
  return {
    "email": email,
    "uid": uid,
    "isDeleted": isDeleted,
  };

}

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot){

    return UserModel(
      key: snapshot.id,
      email: snapshot.data()['email'],
      isDeleted: snapshot.data()['isDeleted'],
      uid: snapshot.data()['uid']);
  }
}