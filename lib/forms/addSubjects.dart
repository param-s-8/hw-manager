import 'package:firebase_auth/firebase_auth.dart';
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
      body: Builder(builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            addSubjects(),
          ],
        );
      }),
    );
  }

  Widget addSubjects() {
    return Form(
        key: _formKey,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: const Text(
                    'Enter Subjects',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  alignment: Alignment.center,
                ),
                TextFormField(
                  controller: _subjectController,
                  decoration: const InputDecoration(labelText: 'Subject'),
                  validator: (value) {
                    if (value.isEmpty) return 'Please enter some text';
                    return null;
                  },
                ),
                TextFormField(
                  controller: _professorController,
                  decoration: const InputDecoration(labelText: 'Professor'),
                  validator: (value) {
                    if (value.isEmpty) return 'Please enter some text';
                    return null;
                  },
                ),
                Container(
                  padding: const EdgeInsets.only(top: 16.0),
                  alignment: Alignment.center,
                  child: OutlineButton(
                    child: Text("Confirm"),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        _addNewSubject();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
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
