import 'package:flutter/material.dart';
import 'package:test/constants.dart';
import 'package:test/screens/welcome/welcomeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: primeColor,
        scaffoldBackgroundColor: Colors.white
      ),
        
      home: welcomeScreen(),
    );
  }
}
