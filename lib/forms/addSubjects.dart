import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/home.dart';
import '../crud.dart';

class addSubject extends StatefulWidget {
  @override
  _addSubjectState createState() => _addSubjectState();
}

crudMethods crudObj = new crudMethods();

class _addSubjectState extends State<addSubject> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _subjectController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _professorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      key: _scaffoldKey,
      body: Stack(
          children: <Widget>[
            Scaffold(
              backgroundColor: Colors.white,
            ),
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('media/bg-app.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  addSubjects(),
                ],
              ),
            ),
          ]
        //Builder(builder: (BuildContext context) {
        //return ;
        //}),
      ),
    );
  }

  Widget addSubjects() {
    return Expanded(
      child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20,50,30,100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 20),

                  child: const Text(
                    'Enter Subjects',
                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 30),
                  ),
                  alignment: Alignment.center,
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(

                  controller: _subjectController,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  decoration: const InputDecoration(border: UnderlineInputBorder(),labelText: 'Subject',labelStyle: TextStyle(
                      color: Colors.white
                  )),
                  validator: (value) {
                    if (value.isEmpty) return 'Please enter some text';
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _professorController,
                  style: TextStyle(color: Colors.white),
                  decoration: const InputDecoration(labelText: 'Professor',labelStyle: TextStyle(
                      color: Colors.white
                  ),),
                  validator: (value) {
                    if (value.isEmpty) return 'Please enter some text';
                    return null;
                  },
                ),
                Container(
                  padding: const EdgeInsets.only(top: 50.0),

                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white
                    ),
                    child: FlatButton(


                      child: Text("Add Subject",style: TextStyle(color: Colors.black,fontSize: 18),),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          _addNewSubject();
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _professorController.dispose();
    super.dispose();
  }

  void _addNewSubject() async {
    try {
      crudObj.addSubject({
        'UID': _auth.currentUser.uid,
        'Subject': _subjectController.text,
        'Professor': _professorController.text
      }).then((result) {
        print("Subject Added");
      }).catchError((e) {
        print("Error: $e");
      });
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return HomePage();
      }));
    } catch (e) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Failed to add subject"),
      ));
    }
  }
}