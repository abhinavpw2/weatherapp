import 'package:firstapp/screens/Dashboard.dart';
import 'package:firstapp/screens/Home.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() =>  runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'newApp',
      themeMode: ThemeMode.system,
      home: Home(),
    );
  }
}
