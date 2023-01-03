
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'loginScreen.dart';
import 'splashScreen.dart';
import 'package:origin/main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}

