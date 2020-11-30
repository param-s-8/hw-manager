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
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    addSubjects(),
                  ],
                ),
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
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.assignment,
              size: 70,
              color: Colors.white,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: const Text(
                'ENTER SUBJECT',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 30),
              ),
              alignment: Alignment.center,
            ),
            SizedBox(height: 15,),
            Container(
              margin: EdgeInsets.only(left: 40, right: 40),
              child: TextFormField(
                controller: _subjectController,
                style: TextStyle(fontSize: 16, color: Colors.white),
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.library_books,color: Colors.white,),
                    border: UnderlineInputBorder(),
                    labelText: 'Subject',
                    labelStyle: TextStyle(
                    color: Colors.grey,
                )
                ),
                validator: (value) {
                  if (value.isEmpty) return 'Please Enter Subject Name';
                  return null;
                },
              ),
            ),
            SizedBox(height: 15,),
            Container(
              margin: EdgeInsets.only(left: 40, right: 40),
              child: TextFormField(
                controller: _professorController,
                style: TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person,color: Colors.white,),
                  labelText: 'Professor',labelStyle: TextStyle(
                    color: Colors.grey
                ),),
                validator: (value) {
                  if (value.isEmpty) return 'Please Enter Professor Name';
                  return null;
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 30.0),
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white
                ),
                child: FlatButton(
                  child: Text("ADD SUBJECT",style: TextStyle(color: Colors.black,fontSize: 18),),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      _addNewSubject();
                    }
                  },
                ),
              ),
            ),
          ],
        ));
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