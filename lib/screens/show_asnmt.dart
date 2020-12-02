import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_ui/firestore_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../crud.dart';
import '../screens/main_drawer.dart';
import '../forms/add-asnmt.dart';
import '../forms/add-meet.dart';


class ShowAsnmt extends StatefulWidget {
  @override
  _ShowAsnmtState createState() => _ShowAsnmtState();
}

class _ShowAsnmtState extends State<ShowAsnmt> {
  Query _ref;
  QuerySnapshot ast;
  crudMethods crudObj = new crudMethods();
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    crudObj.assignment().then((QuerySnapshot results) {
      setState(() {
        ast = results;
      });
    });
    super.initState();
//    _ref = FirebaseFirestore.instance
//    .collection('subject')
//    .where('UID',isEqualTo: _auth.currentUser.uid.toString())
//    .orderBy('Subject');
  }

  Widget _buildListItem({String Subject, String Date, String Time, String Title, String Index, Item}){
    return Dismissible(
      key: Key(Index),
      onDismissed: (direction){
          crudObj.deleteA(Index);
      },
      background: Container(
        color: Colors.red,
      ),
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.deepOrange),
            borderRadius: BorderRadius.circular(30.0),
          ),
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 150.0,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Date: ${Date}"),
                        SizedBox(width: 100.0,),
                        Text("Time: ${Time}"),
                      ],
                    ),
                    SizedBox(height: 10.0,),
                    Padding(padding:EdgeInsets.symmetric(horizontal: 20.0) ,
                      child: Container(
                        height: 1.0,
                        width: 304.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 15.00,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0,0.0 ,20.0,10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.book),
                          SizedBox(width: 10.0,),
                          Text("${Subject}"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0,0.0 ,20.0,10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.home),
                          SizedBox(width: 10.0,),
                          Text("${Title}"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0,0.0 ,20.0,10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.person),
                          SizedBox(width: 10.0,),
                          Text("Anooja"),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    void _pushPage(BuildContext context, Widget page) {
      Navigator.of(context).push(
        MaterialPageRoute<void>(builder: (_) => page),
      );
    }
    if (ast != null) {
      return Scaffold(
        body:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20.0,),
            Expanded(
              child: ListView.builder(
                itemCount: ast.docs.length,
                itemBuilder: (context, index) {
                  return _buildListItem(
                    Subject: ast.docs[index].get('Subject'),
                    Date: ast.docs[index].get('Date'),
                    Time: ast.docs[index].get('Time').substring(10,ast.docs[index].get('Time').length -1),
                    Title: ast.docs[index].get('Title'),
                    Index: ast.docs[index].id,
                    Item: ast.docs,
                  );
                },),
            ),
          ],
        ),
        floatingActionButton: SpeedDial(
            animatedIcon: AnimatedIcons.add_event,
            backgroundColor: Colors.black,
            children: [
              SpeedDialChild(
                child:  Icon(Icons.assignment,color: Colors.white,),
                backgroundColor: Colors.black,
                label: "Add Assignment",
                onTap: ()=>  _pushPage(context, AddAsnmt()) ,
              ),
              SpeedDialChild(
                child:  Icon(Icons.camera_alt,color: Colors.white,),
                backgroundColor: Colors.black,
                label: "Add Meeting",
                onTap: () => _pushPage(context, AddMeet()),
              ),
            ],
          ),

      );
    }
    else {
      return Scaffold(
          body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SpinKitFoldingCube(
                  color: Colors.black,
                  size: 70.0,
                ),
                SizedBox(height: 40,),
                Text(
                  'LOADING...',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    letterSpacing: 10,
                  ),
                ),
              ]
          ));
    }
  }
}





