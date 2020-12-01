import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hw_manager/screens/home.dart';
import '../crud.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  QuerySnapshot user;
  crudMethods crudObj = new crudMethods();

  TextEditingController _displayName = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _subjectController = TextEditingController();
  TextEditingController _collegeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void initState() {
    // TODO: implement initState
    crudObj.user().then((QuerySnapshot results) {
      setState(() {
        user = results;
      });
      user.docs.forEach((element) {
        print(element.get("Name"));
        print(element.get("Password"));
        print(element.get("Total Subjects"));
        _displayName = TextEditingController(text: element.get("Name"));
        _passwordController = TextEditingController(text: element.get("Password"));
        _subjectController = TextEditingController(text: element.get("Total Subjects"));
        _collegeController = TextEditingController(text: element.get("College"));
        _emailController = TextEditingController(text: element.get("Email"));
        print(_displayName.text);

      });
    });
    super.initState();
  }

  Widget _profileText(){
    return Padding(
        padding: EdgeInsets.all(5),
        child: Text(
          'PROFILE',
          style: TextStyle(
            fontSize: 30,
            letterSpacing: 1.5,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        )
    );
  }

  Widget _circleAvatar(){
    return Container(
      padding: EdgeInsets.all(3),
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white,width:5),
        shape: BoxShape.circle,
        color: Colors.white,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('media/user_m1.jpg'),
        ),
      ),
    );
  }
  Widget _textFormField()
  {
    if(user!=null) {
        return Material(

            elevation: 4,
            shadowColor: Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10,),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _displayName,
                    decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: Icon(Icons.person, color: Colors.black),
                        hintText: 'Full Name',
                        hintStyle: TextStyle(
                          letterSpacing: 2,
                          color: Colors.black26,
                          fontWeight: FontWeight.bold,
                        ),
                        filled: true,
                        fillColor: Colors.white30),
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: Icon(Icons.email, color: Colors.black),
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          letterSpacing: 2,
                          color: Colors.black26,
                          fontWeight: FontWeight.bold,
                        ),
                        filled: true,
                        fillColor: Colors.white30),
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: Icon(Icons.lock, color: Colors.black),
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          letterSpacing: 2,
                          color: Colors.black26,
                          fontWeight: FontWeight.bold,
                        ),
                        filled: true,
                        fillColor: Colors.white30),
                  ),
                  TextFormField(
                    controller: _collegeController,
                    decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: Icon(Icons.school, color: Colors.black),
                        hintText: 'College Name',
                        hintStyle: TextStyle(
                          letterSpacing: 2,
                          color: Colors.black26,
                          fontWeight: FontWeight.bold,
                        ),
                        filled: true,
                        fillColor: Colors.white30),
                  ),
                  TextFormField(

                    controller: _subjectController,
                    decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: Icon(
                            Icons.library_books, color: Colors.black),
                        hintText: 'Number of Subjects',
                        hintStyle: TextStyle(
                          letterSpacing: 2,
                          color: Colors.black26,
                          fontWeight: FontWeight.bold,
                        ),
                        filled: true,
                        fillColor: Colors.white30),
                  ),

                ],
              ),
            )
        );
    }else{
      return Container(
        child: Text("Loading"),
      );
    }
  }

  Widget _textFormFieldCalling(){
    return Container(
        height: 300,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _textFormField(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              width: double.infinity,
              margin: EdgeInsets.only(right: 150,left: 150),
              child: RaisedButton(
                elevation: 5,
                onPressed: () => _update(),
                padding: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                color: Colors.black,
                child: Text(
                  'UPDATE',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HOMEWORK MANAGER"),
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){},
        ),
      ),
      body: DraggableScrollableSheet(
        initialChildSize: 1,
        minChildSize: 1,
        maxChildSize: 1,
        builder: (context, scrollController){
          return SingleChildScrollView(
            controller: scrollController,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                CustomPaint(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                  painter: HeaderCurvedContainer(),

                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _profileText(),
                    _circleAvatar(),
                    _textFormFieldCalling(),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

void _update() async {
    _auth.currentUser.updatePassword(_passwordController.text) ;
    crudObj.updateData(user,{
      'UID': _auth.currentUser.uid,
      'Name': _displayName.text,
      'Email': user,
      'Password': _passwordController.text,
      'College': _collegeController.text,
      'Total Subjects': _subjectController.text
    }).then((result) {
      print("User Updated");
    }).catchError((e) {
      print("Error: $e");
    });

    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomePage()));
  }
}
class HeaderCurvedContainer extends CustomPainter{
  @override
  void paint(Canvas canvas,Size size){
    Paint paint = Paint()..color=Colors.black38;
    Path path =  Path()
      ..relativeLineTo(0, 100)
      ..quadraticBezierTo(size.width/2, 200, size.width, 100)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate)=>false;
}