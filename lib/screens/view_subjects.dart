import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hw_manager/forms/addSubjects.dart';
import 'main_drawer.dart';
import 'package:hw_manager/forms/add-asnmt.dart';
import 'package:hw_manager/forms/add-meet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_ui/firestore_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class ShowSub extends StatefulWidget {
  @override
  _ShowSubState createState() => _ShowSubState();
}

class _ShowSubState extends State<ShowSub> {
  Query _ref;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    final User user = _auth.currentUser;
    final uid = user.uid;
    super.initState();
    _ref = FirebaseFirestore.instance
        .collection('subject')
        .where('UID',isEqualTo: uid)
        .orderBy('Subject');
  }

  Widget _buildListItem({Map subject}){
    return Container(

      // width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 35.0,vertical: 10.0),
      child: Card(

        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),

        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black54),
            borderRadius: BorderRadius.circular(30.0),


          ),

          // width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 150.0,

                child: Column(
                  children: <Widget>[

                    SizedBox(height: 20.0,),
                    Padding(padding:EdgeInsets.symmetric(horizontal: 30.0) ,
                      child: Container(
                        height: 1.0,
                        width: 110.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20.00,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0,0.0 ,10.0,10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.subject),
                          SizedBox(width: 10.0,),

                          Text(subject["Subject"], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.00,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0,0.0 ,10.0,10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.account_box,size: 25,),
                          SizedBox(width: 10.0,),
                          Text(subject["Professor"],style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),),
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
          SizedBox(height: 20.0,),
          Expanded(
            child: FirestoreAnimatedList(query: _ref
              , itemBuilder: (BuildContext context, DocumentSnapshot snapshot, Animation<double>animation , int index){
                Map subject = snapshot.data();
                return _buildListItem(subject: subject);
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
}
