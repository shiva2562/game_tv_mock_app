import 'package:flutter/material.dart';
import 'home.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  final _loginkey = GlobalKey<FormState>();
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    String _username;
    String _password;
    void _submit() async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (_loginkey.currentState.validate()) {
        if ((_username == '9898989898' && _password == 'password123') ||
            (_username == '9876543210' && _password == 'password123')) {
          prefs.setBool('loggedin', true);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return home();
          }));
        }
        else{
          _scaffoldkey.currentState.showSnackBar(SnackBar(content: Text('Please enter the right details')));
        }
      }
    }
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Colors.white.withOpacity(0.95),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                ),
                Container(height: 100, child: Image.asset("images/e.png")),
                SizedBox(
                  height: 100,
                ),
                Form(
                  key: _loginkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom:10),
                        child: TextFormField(
                          validator: (input) {
                            if (input.length < 3) {
                              return "UserName Should be atleat 3 characters";
                            } else if (input.length > 10) {
                              return "UserName Should not exceed 10 characters";
                            } else {
                              _username = input;
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            labelText: 'Username'
                            ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom:10),
                        child: TextFormField(
                          validator: (input) {
                            if (input.length < 3) {
                              return "Password Should be atleat 3 characters";
                            } else if (input.length > 11) {
                              return "Password Should not exceed 11 characters";
                            } else {
                              _password = input;
                              return null;
                            }
                          },
                          obscureText: true,
                          decoration: InputDecoration(border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),labelText: 'Password'),
                        ),
                      ),
                      RaisedButton(
                        color: Colors.black,
                        child: Text("Submit",style: TextStyle(color: Colors.white),),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        onPressed: _submit,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
