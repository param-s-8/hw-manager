import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../screens/main_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

            child: Subjectcard(),


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


class Subjectcard extends StatefulWidget {
  @override
  _SubjectcardState createState() => _SubjectcardState();
}

class _SubjectcardState extends State<Subjectcard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemCount: 5,
        shrinkWrap: true,
        itemBuilder: (BuildContext context,int index)=> Container(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: <Widget>[

                            Text("Date: 12/01/2021"),
                            SizedBox(width: 120.0,),
                            Text("Time: 11:59pm"),



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

                              Text("Prof. Anooja Joy"),
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
                              Text("Zoom Meeting"),
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
          ) ,
        ),
      ),
    );
  }
}


