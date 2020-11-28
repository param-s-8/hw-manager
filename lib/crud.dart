import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class crudMethods {
  FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> addUser(userData) {
//    return FirebaseFirestore.instance
//        .collection('users')
//        .doc('${FirebaseAuth.instance.currentUser.uid}')
//        .update(userData).then((value) {
//          print("UID: ${FirebaseAuth.instance.currentUser.uid}");
//    } )
//        .catchError((e) {
//      print(e);
//    });

     return FirebaseFirestore.instance
         .collection('users')
         .add(userData)
         .then((value) {
       print("UID: ${FirebaseAuth.instance.currentUser.uid}");
     }).catchError((e) {
       print(e);
     });
  }

  Future<void> addSubject(subject) {
    return FirebaseFirestore.instance
        .collection('subject')
        .add(subject).then((value) {
      print("UID: ${FirebaseAuth.instance.currentUser.uid}");
    } )
        .catchError((e) {
      print(e);
    });
  }

  Future<void> addAssignment(assignment) {
    return FirebaseFirestore.instance
        .collection('assignment')
        .add(assignment).then((value) {
      print("UID: ${FirebaseAuth.instance.currentUser.uid}");
    } )
        .catchError((e) {
      print(e);
    });
  }

  Future<void> addMeeting(meeting) {
    return FirebaseFirestore.instance
        .collection('meeting')
        .add(meeting).then((value) {
      print("UID: ${FirebaseAuth.instance.currentUser.uid}");
    } )
        .catchError((e) {
      print(e);
    });
    // return FirebaseFirestore.instance
    //     .collection('meeting')
    //     .add(meeting)
    //     .then((value) {
    //   print("Meeting Added");
    // }).catchError((e) {
    //   print(e);
    // });
  }

  updateData(sDoc, newValues) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(sDoc)
        .update(newValues)
        .catchError((e) {
      print(e);
    });
  }
}
