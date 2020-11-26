import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class crudMethods {
  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> addUser(userData) async {
    if(isLoggedIn()) {
      FirebaseFirestore.instance.collection('users').add(userData).catchError((e) {
        print(e);
      });
    } else {
      print('You need to be logged in');

    }
  }
}