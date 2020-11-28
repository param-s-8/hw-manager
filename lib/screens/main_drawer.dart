import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
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
                  Text("Name: VAIBHAVI KUNDLE",
                    style: TextStyle(color: Colors.white) ,),
                  Text("vaibhavikundle20@gmail.com ",
                    style: TextStyle(color: Colors.white) ,),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Add a meeting'),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.assignment),
            title: Text('Add a assignment'),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('View all Subjects'),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.hourglass_empty),
            title: Text('Pending Tasks'),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.arrow_forward),
            title: Text('Register'),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.arrow_back),
            title: Text('Logout'),
            onTap: null,
          ),
        ],
      ),
    );
  }
}
