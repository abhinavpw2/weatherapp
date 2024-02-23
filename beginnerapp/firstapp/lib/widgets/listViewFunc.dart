import 'package:flutter/material.dart';

class listViewFunc extends StatelessWidget {
  String widgetTitle, widgetSubtitle;
  IconData frontIcon, trailIcon;
  Color? iconColour, tileColour;

  listViewFunc({
    required this.widgetTitle,
    required this.widgetSubtitle,
    this.frontIcon = Icons.label,
    this.trailIcon = Icons.add_shopping_cart,
    this.iconColour,
    this.tileColour,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        tileColor: tileColour,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: Colors.blue,
          ),
        ),
        title: Text(widgetTitle,
            style:
                TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        subtitle: Text(widgetSubtitle),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(frontIcon),
          color: iconColour,
        ),
        trailing: IconButton(
            onPressed: () {}, icon: Icon(trailIcon)),
      ),
    );
  }
}
