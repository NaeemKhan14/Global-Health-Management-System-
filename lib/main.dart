import 'package:flutter/material.dart';
import 'file:///E:/Uni/Year%204/Semester%202/Dissertation/ghms/lib/Screens/WelcomeScreen/welcome_screen.dart';
import 'package:ghms/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white
      ),
      home: WelcomeScreen(),
    );
  }
}