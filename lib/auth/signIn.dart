import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'register.dart';
import 'package:hw_manager/screens/showlist.dart';


class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _passwordVisible = false; String errEmail = '', errPwd = '';
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _passwordController = TextEditingController();
  double _boxh = 15;
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
          DraggableScrollableSheet(
              initialChildSize: 1,
              minChildSize: 1,
              maxChildSize: 1,
              builder: (context, scrollController){
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 120.0),
                    child: Form(
                      key: _formKey,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.person_pin,
                                  size: 70,
                                  color: Colors.white,
                                ),
                                Text(
                                  "LOGIN",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: _boxh*2),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(left:80,right:80),
                                      //alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(30),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.white,
                                              blurRadius: 6,
                                              offset: Offset(0,2),
                                            )
                                          ]
                                      ),
                                      height: 50,
                                      child: Container(
                                        child: TextFormField(
                                          controller: _emailController,
                                          keyboardType: TextInputType.emailAddress,
                                          style: TextStyle(color: Colors.black,),
                                          decoration: InputDecoration(
                                            errorStyle: TextStyle(height: 0),
                                            focusedBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            focusedErrorBorder: InputBorder.none,
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black),
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                            hintText: 'E-mail',
                                            prefixIcon: Icon(Icons.person,color: Colors.black,),
                                          ),
                                          validator: (value){
                                            if(value.isEmpty){
                                              errEmail = 'Please Enter Email';
                                              return '';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: _boxh/2),
                                Text(
                                  errEmail =='' ? '' : errEmail,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                                SizedBox(height: _boxh),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(left:80,right:80),
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(30),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.white,
                                              blurRadius: 6,
                                              offset: Offset(0,2),
                                            )
                                          ]
                                      ),
                                      height: 50,
                                      child: Container(
                                        child: TextFormField(
                                          controller: _passwordController,
                                          keyboardType: TextInputType.emailAddress,
                                          style: TextStyle(color: Colors.black,),
                                          decoration: InputDecoration(
                                            errorStyle: TextStyle(height: 0),
                                            focusedBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            focusedErrorBorder: InputBorder.none,
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black),
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                            hintText: 'Password',
                                            prefixIcon: Icon(Icons.lock,color: Colors.black,),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                _passwordVisible? Icons.visibility:Icons.visibility_off,
                                                color: Colors.black,
                                              ),
                                              onPressed: (){
                                                setState(() {
                                                  _passwordVisible=!_passwordVisible;
                                                });
                                              },
                                            ),
                                          ),
                                          obscureText: !_passwordVisible,
                                          validator: (value){
                                            if(value.isEmpty){
                                              errPwd = 'Please Enter Password';
                                              return '';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: _boxh/2),
                                Text(
                                  errPwd =='' ? '' : errPwd,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                                Container(
                                  //alignment: Alignment,
                                  child: FlatButton(
                                    onPressed: () => print("Forgot Password!"),
                                    padding: EdgeInsets.only(left:250),
                                    child: Text(
                                      'Forgot Password?',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  width: double.infinity,
                                  margin: EdgeInsets.only(right: 150,left: 150),
                                  child: RaisedButton(
                                    elevation: 5,
                                    // onPressed: () => _signInWithEmailAndPassword(),
                                    padding: EdgeInsets.all(15),
                                    onPressed: ()async{
                                      if(_formKey.currentState.validate()){
                                        _signInWithEmailAndPassword();
                                      }
                                    },
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
                                GestureDetector(
                                  onTap: () => _pushPage(context,Register()),
                                  child: RichText(
                                    text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: 'New User ? Register',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                              )
                                          )
                                        ]
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signInWithEmailAndPassword() async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user;
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return ShowList();
      }));
    } catch (e) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Failed to sign in with Email & Password"),
      ));
    }
  }

  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }
}