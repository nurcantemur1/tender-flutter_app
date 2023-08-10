import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home.dart';
// ignore: unused_import
import 'package:http/http.dart';

import 'drawer_menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static DrawerMenu menu = DrawerMenu();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}
