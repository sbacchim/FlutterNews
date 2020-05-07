import 'package:flutter/material.dart';

class StackExample extends StatelessWidget {
  StackExample();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(children: <Widget>[
      Container(
          decoration: BoxDecoration(
              image: DecorationImage(
        fit: BoxFit.fitHeight,
        image: AssetImage('assets/fuji.jpg'),
      ))),
      Positioned(
          left: 16,
          right: 16,
          top: 32,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 8,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  Text("Welcome to Japan!",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
                  Text(
                      "Mount Fuji (called by the japanese \"Fujisan\") located on the island of Honshū, is the highest mountain in Japan, standing 3,776.24 metres (12,389.2 ft).")
                ],
              ),
            ),
          ))
    ]));
  }
}
