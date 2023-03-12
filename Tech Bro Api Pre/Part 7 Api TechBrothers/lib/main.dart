import 'package:flutter/material.dart';
// import 'package:fluttercompleteguide/Home_Screen.dart';

import 'package:fluttercompleteguide/home_screen.dart';

import 'Home_Screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: homescreen(),
      // HomeScreen(),
    );
  }
}
