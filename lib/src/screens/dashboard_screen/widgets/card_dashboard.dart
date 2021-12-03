import 'package:flutter/material.dart';

class CardDashboard extends StatelessWidget {
  String title;
  int count;
  Color color;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: color,
          boxShadow: [
            new BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 2),
              spreadRadius: 2,
              blurRadius: 2.0,
            ),
          ],
        ),
        width: screenSize.width * 0.4,
        height: screenSize.width * 0.4,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(count.toString()), Text(title)],
        ),
      ),
    );
  }

  CardDashboard(this.title, this.count, this.color);
}
