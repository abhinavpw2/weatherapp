import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Dashboard'.toUpperCase()),
      //   backgroundColor: Colors.blueGrey,
      // ),
      backgroundColor: Colors.lightGreen,
      body: Container(
        width: 350.0,
        height: 250.0,
        padding: EdgeInsets.all(20.0),
        margin: EdgeInsets.all(20.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          //borderRadius: BorderRadius.circular(10.0),
          color: Colors.blueGrey,
          border: Border.all(width: 7.0, color: Colors.grey),
          shape: BoxShape.circle,
          image: DecorationImage(image: AssetImage("images/abc.png")),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.shade700,
              spreadRadius: 7.0,
              blurRadius: 4.0,
              offset: Offset(6, 6),
            )
          ]
        ),
        // child: Text(
        //   "boring",
        //   style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
        // ),
      ),
    );
  }
}

//int getNumber(){return Random().nextInt(200000);}