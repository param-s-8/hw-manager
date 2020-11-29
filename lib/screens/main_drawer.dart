import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth/signIn.dart';
import 'showlist.dart';
import '../forms/add-asnmt.dart';
import '../forms/add-meet.dart';
import '../forms/addSubjects.dart';
import 'user_profile.dart';
import 'home.dart';

class MainDrawer extends StatelessWidget {
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Colors.black54,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 30,bottom: 10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: NetworkImage('https://image.shutterstock.com/image-vector/user-member-vector-icon-ui-260nw-1180939933.jpg'),
                      fit: BoxFit.fill),

                    ),
                  ),
                  Text("Name: ${_auth.currentUser.displayName}",
                    style: TextStyle(color: Colors.white) ,),
                  Text("${_auth.currentUser.email}",
                    style: TextStyle(color: Colors.white) ,),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () => _pushPage(context, ProfilePage()),
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Add a meeting'),
            onTap: () => _pushPage(context, AddMeet()),
          ),
          ListTile(
            leading: Icon(Icons.assignment),
            title: Text('Add a assignment'),
            onTap: () => _pushPage(context, AddAsnmt()),
          ),
          ListTile(
            leading: Icon(Icons.assignment),
            title: Text('Add a subject'),
            onTap: () => _pushPage(context, addSubject()),
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('View all Subjects'),
            onTap: () => _pushPage(context,ShowList()),
          ),
          ListTile(
            leading: Icon(Icons.hourglass_empty),
            title: Text('Pending Tasks'),
            onTap: () => _pushPage(context, HomePage()),
          ),
          ListTile(
            leading: Icon(Icons.arrow_back),
            title: Text('Logout'),
            onTap: () {
              _signOut().whenComplete(() {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => SignIn()));
              });
            },
          ),
        ],
      ),
    );
  }
  Future _signOut() async {
    await _auth.signOut();
  }

  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }
}
