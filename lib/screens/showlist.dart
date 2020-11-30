import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_ui/firestore_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../crud.dart';
import '../forms/add-asnmt.dart';
import '../forms/add-meet.dart';
import '../screens/main_drawer.dart';
import 'show_asnmt.dart';
import 'show_meeting.dart';

class ShowList extends StatefulWidget {
  @override
  _ShowListState createState() => _ShowListState();
}

class _ShowListState extends State<ShowList> with SingleTickerProviderStateMixin{

  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 2, vsync: this);
    // TODO: implement initState
    crudObj.subject().then((QuerySnapshot results) {
      setState(() {
        sub = results;
      });
    });
//    _ref = FirebaseFirestore.instance
//    .collection('subject')
//    .where('UID',isEqualTo: _auth.currentUser.uid.toString())
//    .orderBy('Subject');
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  Query _ref;
  QuerySnapshot sub;
  crudMethods crudObj = new crudMethods();
  FirebaseAuth _auth = FirebaseAuth.instance;



  Widget _buildListItem({String Subject, String Professor}){
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 2.0),
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
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 150.0,

                child: Column(
                  children: <Widget>[

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

                          Text(Subject),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0,0.0 ,212.0,10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.person),
                          SizedBox(width: 10.0,),
                          Text(Professor),
                        ],
                      ),
                    ),


                  ],
                ),
              )
            ],
          ),
        ),
      ) ,
    );
  }


  @override
  Widget build(BuildContext context) {
    void _pushPage(BuildContext context, Widget page) {
      Navigator.of(context).push(
        MaterialPageRoute<void>(builder: (_) => page),
      );
    }
    if (sub != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text("HOMEWORK MANAGER"),
          backgroundColor: Colors.black,
          centerTitle: true,
          bottom: TabBar(
            controller: controller,
              tabs: <Tab>[
                new Tab(text: 'ASSIGNMENTS'),
                new Tab(text: 'MEETINGS'),
              ],
          ),
        ),
        drawer: MainDrawer(),
        body: new TabBarView(
          controller: controller,
            children: <Widget>[
              new ShowAsnmt(),
              new ShowMeeting(),
            ],
        ),
        /*Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            *//*Row(
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
            ),*//*
            SizedBox(height: 30.0,),
            Expanded(
              child: ListView.builder(
                itemCount: sub.docs.length,
                itemBuilder: (context, index) {
                  return _buildListItem(Subject: sub.docs[index].get('Subject'),
                      Professor: sub.docs[index].get('Professor')
                  );
                },),
            ),
          ],
        ),*/

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
        )

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





