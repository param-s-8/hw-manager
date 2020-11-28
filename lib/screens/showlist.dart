import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../screens/main_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_ui/firestore_ui.dart';

class ShowList extends StatefulWidget {
  @override
  _ShowListState createState() => _ShowListState();
}

class _ShowListState extends State<ShowList> {
  Query _ref;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ref = FirebaseFirestore.instance
    .collection('subject')
    .orderBy('Subject');
  }

  Widget _buildListItem({Map subject}){
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

                          Text(subject["Subject"]),
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
                          Text(subject["Professor"]),
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
                  onTap: (){},
                ),
                InkWell(
                  child: Container(
                    color: Colors.black54,
                    child: Text("FUTURE"),
                    width: 200,
                    height: 50,
                    padding: EdgeInsets.fromLTRB(80.0, 15.0, 10.0, 5.0),



                  ),
                  onTap: (){},
                ),

              ]
          ),
          SizedBox(
            height: 30.0,
          ),
          Expanded(

            child: FirestoreAnimatedList(query: _ref
              , itemBuilder: (BuildContext context, DocumentSnapshot snapshot, Animation<double>animation , int index){
              Map subject = snapshot.data();
              return _buildListItem(subject: subject);
              },),


          ),



        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){

      },
        backgroundColor: Colors.black,
        child: Icon(Icons.add, color: Colors.white,),) ,

    );






  }
}





