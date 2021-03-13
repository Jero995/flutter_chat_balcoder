import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User> getCurrentUser() async {
    User user = _firebaseAuth.currentUser;
    return user;
  }

  Future<String> signIn(String email, String password) async {
    var uid;
    await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((UserCredential userCredential) {
          uid = userCredential.user.uid.toString();
      
    });
    return uid;
  }

  signOut() {
    return _firebaseAuth.signOut();
  }
}
