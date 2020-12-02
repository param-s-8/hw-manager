import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../auth/signIn.dart';
import 'showlist.dart';
import '../forms/add-asnmt.dart';
import '../forms/add-meet.dart';
import '../forms/addSubjects.dart';
import 'user_profile.dart';
import 'home.dart';
import 'view_subjects.dart';

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
            color: Colors.black,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 30,bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                      image: DecorationImage(image: AssetImage('media/user.jpg'),
                      fit: BoxFit.fill),
                    ),
                  ),
                  Text("Name: ${_auth.currentUser.displayName}",
                    style: TextStyle(color: Colors.white) ,),
                  Text("Email: ${_auth.currentUser.email}",
                    style: TextStyle(color: Colors.white) ,),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person,color: Colors.black,),
            title: Text('Profile',style: TextStyle(color: Colors.black,),),
            onTap: () => _pushPage(context, ProfilePage()),
          ),
          ListTile(
            leading: Icon(Icons.home,color: Colors.black,),
            title: Text('Home Page',style: TextStyle(color: Colors.black,),),
            onTap: () => _pushPage(context, ShowList()),
          ),
          ListTile(
            leading: Icon(Icons.add,color: Colors.black,),
            title: Text('Add Meeting',style: TextStyle(color: Colors.black,),),
            onTap: () => _pushPage(context, AddMeet()),
          ),
          ListTile(
            leading: Icon(Icons.assignment,color: Colors.black,),
            title: Text('Add Assignment',style: TextStyle(color: Colors.black,),),
            onTap: () => _pushPage(context, AddAsnmt()),
          ),
          ListTile(
            leading: Icon(Icons.assignment,color: Colors.black,),
            title: Text('Add Subject',style: TextStyle(color: Colors.black,),),
            onTap: () => _pushPage(context, addSubject()),
          ),
          ListTile(
            leading: Icon(Icons.book,color: Colors.black,),
            title: Text('View All Subjects',style: TextStyle(color: Colors.black,),),
            onTap: () => _pushPage(context,ShowSub()),
          ),

          ListTile(
            leading: Icon(Icons.arrow_back,color: Colors.black,),
            title: Text('Log Out',style: TextStyle(color: Colors.black,),),
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
