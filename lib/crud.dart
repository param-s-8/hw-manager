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

  Future<void> addUser(userData) {

      return FirebaseFirestore.instance.collection('users').add(userData).then((value) {
      print("User Added");
      }).catchError((e) {
        print(e);
      });

    
  }

  updateData(sDoc, newValues) {
    FirebaseFirestore.instance.collection('users').document(sDoc).updateData(newValues).catchError((e) {
    print(e);
    });
  }
}