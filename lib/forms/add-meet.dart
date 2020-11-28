import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../screens/home.dart';
import '../crud.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddMeet extends StatefulWidget {
  @override
  _AddMeetState createState() => _AddMeetState();
}


crudMethods crudObj = new crudMethods();

class _AddMeetState extends State<AddMeet> {
  List _subjName = [
    'AI', 'OS', 'TOC', 'INS'
  ];

  FirebaseAuth _auth = FirebaseAuth.instance;
  DateTime _dateTime;
  String _subjVal, _formattedDT;
  final TextEditingController _titleController = TextEditingController();
  TimeOfDay _time , picked;
  double _boxh = 15;
  @override
  void initState() {
    super.initState();
    _time = TimeOfDay.now();
  }

Future<Null> selectTime(BuildContext context) async{
    picked = await showTimePicker(context: context, initialTime: _time,);

    if(picked!=null){
      setState(() {
        _time = picked;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
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
                  Icon(Icons.laptop,
                  size: 60,
                  ),
                  Text(
                    "ADD A MEETING",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: _boxh*3),
                  Container(
                    height: 50,
                    margin: EdgeInsets.only(left:40,right:40),
                    child: TextFormField(
                      controller: _titleController,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.laptop_windows,
                          color: Colors.white,
                        ),
                        hintText: 'Title/Description',
                        hintStyle: TextStyle(color: Colors.grey[700]),
                        fillColor: Colors.white.withOpacity(0.9),

                      ),
                    ),
                  ),
                  SizedBox(height: _boxh*3),
                  Row(
                    children: <Widget>[
                      Container(
                        height: 50,
                        margin: EdgeInsets.only(left:40,right:40),
                        child: DropdownButton(
                          hint: Text(
                            'Select Subject',
                            style: TextStyle(
                                color: Colors.white,
                            ),
                          ),
                          dropdownColor: Colors.white,
                          focusColor: Colors.white,
                          icon: Icon(Icons.arrow_drop_down,
                          color: Colors.white,
                          ),
                          iconSize: 36,
                          value: _subjVal,
                            onChanged:(value){
                              setState(() {
                                _subjVal = value;
                              });
                            },
                        items: _subjName.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value,
                            style: TextStyle(
                              color: Colors.grey[700],
                            ),
                            ),
                          );
                        }).toList(),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            height: 40,
                            child: RaisedButton(
                              color: Colors.grey,
                              child: Text(
                                _dateTime != null ? 'Pick another date' : 'Enter Date Of Meeting',
                                style: TextStyle(
                                  color: Colors.grey[800],
                                ),
                              ),
                              onPressed: (){
                                showDatePicker(
                                  context: context,
                                  initialDate: _dateTime == null ? DateTime.now() : _dateTime,
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2025),
                                  initialEntryMode: DatePickerEntryMode.input,
                                ).then((date){
                                  setState(() {
                                    _dateTime = date;
                                    _formattedDT = DateFormat('dd-MM-yyyy').format(_dateTime);
                                  });
                                });
                              },
                            ),
                          ),
                          Container(
                            child: Text(
                              _dateTime == null ? 'No date has been picked yet!' : _formattedDT,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: _boxh),
                  Container(
                    height: 40,
                    margin: EdgeInsets.only(left:40,right:40),
                    child: ListTile(
                      title: Text(
                          _time!=null ? 'Meeting Time: ${_time.hour} : ${_time.minute}' : 'Pick a time for meeting',
                        style: TextStyle(
                          color: _time!=null ? Colors.white : Colors.grey[700],
                        ),
                      ),
                      leading: Icon(Icons.access_time,
                      color: Colors.white,
                      ),
                      onTap: () {
                        selectTime(context);
                        print(_time);
                      },
                    ),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    height: 40,
                    margin: EdgeInsets.only(left:40,right:40),
                    color: Colors.white,
                    child: OutlineButton(
                      child: Text(
                        "ADD MEETING",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () => _addMeeting(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



void _addMeeting() async {
  try {
    crudObj.addMeeting({
      'UID': _auth.currentUser.uid,
      'Title': _titleController.text,
      'Date': _formattedDT,
      'Subject': _subjVal,
      'Time' : _time.toString()
    }).then((result) {
      print("Meeting Added");
    }).catchError((e) {
      print("Error: $e");
    });
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
      return HomePage();
    }));
  } catch (e) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("Failed to add Meeting"),
    ));
  }
}
}





