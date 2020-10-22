import 'package:flutter/material.dart';
import 'login.dart';
import 'dart:async';
import 'home.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var check =prefs.getBool('loggedin')??false;
  runApp(MyApp(check));
}

class MyApp extends StatelessWidget {
  var isloggedin;
  MyApp(this.isloggedin);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: isloggedin==true?home():login(),
    );
  }
}