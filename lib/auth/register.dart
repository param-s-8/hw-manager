import '../mainPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../crud.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _displayName = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _collegeController = TextEditingController();
  double _boxh = 10;

  crudMethods crudObj = new crudMethods();

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
                Icon(Icons.create,
                  size: 70,
                  color: Colors.white,
                ),
                Text(
                  "REGISTER",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: _boxh),
                Container(
                  height: 40,
                  margin: EdgeInsets.only(left: 40, right: 40),
                  child: TextFormField(
                    controller: _displayName,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Full Name',
                      prefixIcon: Icon(Icons.person, color: Colors.white),
                      hintStyle: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                ),
                SizedBox(height: _boxh),
                Container(
                  height: 40,
                  margin: EdgeInsets.only(left: 40, right: 40),
                  child: TextFormField(
                    controller: _emailController,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.email, color: Colors.white),
                      hintStyle: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                ),
                SizedBox(height: _boxh),
                Container(
                  height: 40,
                  margin: EdgeInsets.only(left: 40, right: 40),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.lock, color: Colors.white),
                      hintStyle: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                ),
                SizedBox(height: _boxh),
                Container(
                  height: 40,
                  margin: EdgeInsets.only(left: 40, right: 40),
                  child: TextFormField(
                    controller: _collegeController,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'College',
                      prefixIcon: Icon(Icons.school, color: Colors.white),
                      hintStyle: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                ),
                SizedBox(height: _boxh),
                Container(
                  height: 40,
                  margin: EdgeInsets.only(left: 40, right: 40),
                  child: TextFormField(
                    controller: _subjectController,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Number of Subjects',
                      prefixIcon: Icon(
                          Icons.library_books, color: Colors.white),
                      hintStyle: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                ),
                SizedBox(height: _boxh),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: RaisedButton(
                            elevation: 5,
                            onPressed: () => print('Login pressed'),
                            padding: EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            color: Colors.white,
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: _boxh),
                        Container(
                          child: RaisedButton(
                            elevation: 5,
                            onPressed: () => _registerAccount(),
                            padding: EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            color: Colors.white,
                            child: Text(
                              'REGISTER',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _registerAccount() async {
    final User user = (await _auth.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ))
        .user;

    if (user != null) {
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }
      await user.updateProfile(displayName: _displayName.text);
      final user1 = _auth.currentUser;
      crudObj.addUser({
        'UID': user1.uid,
        'Name': _displayName.text,
        'Email': _emailController.text,
        'Password': _passwordController.text,
        'College': _collegeController.text,
        'Total Subjects': _subjectController.text
      }).then((result) {
        print("User Added");
      }).catchError((e) {
        print("Error: $e");
      });
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MainPage(
                user: user1,
              )));
    } else {
      print("User not registered");
    }
  }
}
