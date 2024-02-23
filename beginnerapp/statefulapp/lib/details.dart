import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  Details({super.key, required this.productName});

  String productName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.balance),
              title: Text(productName),
            )
          ],
        ),
      )
      );
  }
}
