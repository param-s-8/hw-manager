//get data
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hw_manager/screens/show_meeting.dart';
import 'package:hw_manager/screens/show_asnmt.dart';
import 'package:hw_manager/screens/showlist.dart';
import '../forms/add-asnmt.dart';
import '../forms/add-meet.dart';
import 'home_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(
                'Home Page of',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            Container(
              child: Text(
                '${_auth.currentUser.displayName}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 16.0),
              alignment: Alignment.center,
              child: OutlineButton(
                  child: Text("Home Screen"),
                  onPressed: () async {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (_) {
                      return HomeScreen();
                    }));
                  }),
            ),
            Container(
              padding: const EdgeInsets.only(top: 16.0),
              alignment: Alignment.center,
              child: OutlineButton(
                  child: Text("Show List"),
                  onPressed: () async {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (_) {
                      return ShowList();
                    }));
                  }),
            ),
            Container(
              padding: const EdgeInsets.only(top: 16.0),
              alignment: Alignment.center,
              child: OutlineButton(
                  child: Text("Show Meeting"),
                  onPressed: () async {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (_) {
                      return ShowMeeting();
                    }));
                  }),
            ),
            Container(
              padding: const EdgeInsets.only(top: 16.0),
              alignment: Alignment.center,
              child: OutlineButton(
                  child: Text("Show Assignment"),
                  onPressed: () async {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (_) {
                      return ShowAsnmt();
                    }));
                  }),
            ),
            Container(
              padding: const EdgeInsets.only(top: 16.0),
              alignment: Alignment.center,
              child: OutlineButton(
                  child: Text("Add Assignment"),
                  onPressed: () async {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (_) {
                      return AddAsnmt();
                    }));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
