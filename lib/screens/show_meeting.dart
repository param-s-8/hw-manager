import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_ui/firestore_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../crud.dart';
import '../screens/main_drawer.dart';


class ShowMeeting extends StatefulWidget {
  @override
  _ShowMeetingState createState() => _ShowMeetingState();
}

class _ShowMeetingState extends State<ShowMeeting> {
  Query _ref;
  QuerySnapshot meet;
  crudMethods crudObj = new crudMethods();

  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    crudObj.meeting().then((QuerySnapshot results) {
      setState(() {
        meet = results;
      });
    });
    super.initState();
//    _ref = FirebaseFirestore.instance
//    .collection('subject')
//    .where('UID',isEqualTo: _auth.currentUser.uid.toString())
//    .orderBy('Subject');
  }

  Widget _buildListItem({String Subject, String Date, String Time, String Title}){
    return Card(

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
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 25.0),
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
                            SizedBox(width: 120.0,),
                            Text("Time: ${Time}"),



                          ],
                        ),
                        SizedBox(height: 10.0,),
                        Padding(padding:EdgeInsets.symmetric(horizontal: 2.0) ,
                          child: Container(
                            height: 1.0,
                            width: 340.0,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 15.00,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0.0,0.0 ,200.0,10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(Icons.book),
                              SizedBox(width: 10.0,),

                              Text("${Subject}"),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(0.0,0.0 ,212.0,10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(Icons.home),
                              SizedBox(width: 10.0,),
                              Text("${Title}"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0.0,0.0 ,200.0,10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(Icons.person),
                              SizedBox(width: 10.0,),
                              Text("Prof. Anooja Joy"),
                            ],
                          ),
                        ),

                      ],
                    ),


                  )
                ],
              ),
            ),
          );

  }


  @override
  Widget build(BuildContext context) {
    if (meet != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text("HOMEWORK MANAGER"),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        drawer: MainDrawer(),
        body:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    child: Container(
                      color: Colors.black54,
                      child: Text("TODAY",),
                      width: 210,
                      height: 50,
                      padding: EdgeInsets.fromLTRB(85.0, 15.0, 20.0, 5.0),
                    ),
                    onTap: () {},
                  ),
                  InkWell(
                    child: Container(
                      color: Colors.black54,
                      child: Text("FUTURE"),
                      width: 200,
                      height: 50,
                      padding: EdgeInsets.fromLTRB(80.0, 15.0, 10.0, 5.0),
                    ),
                    onTap: () {},
                  ),

                ]
            ),
            SizedBox(
              height: 30.0,
            ),

            Expanded(

              child: ListView.builder(
                itemCount: meet.docs.length,
                itemBuilder: (context, index) {
                  return _buildListItem(Subject: meet.docs[index].get('Subject'),
                      Date: meet.docs[index].get('Date'),
                    Time: meet.docs[index].get('Time'),
                    Title: meet.docs[index].get('Title'),
                  );
                },),
            ),

          ],
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {

        },
          backgroundColor: Colors.black,
          child: Icon(Icons.add, color: Colors.white,),),

      );
    }
    else {
      return Scaffold(
          appBar: AppBar(
            title: Text("HOMEWORK MANAGER"),
            backgroundColor: Colors.black,
            centerTitle: true,
          ),
          drawer: MainDrawer(),
          body:
          Column(
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





