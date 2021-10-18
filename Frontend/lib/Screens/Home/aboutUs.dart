import 'package:flutter/material.dart';


class aboutUsPage extends StatelessWidget {
  List<Widget> pageChildren(double width) {
    return <Widget>[
      Container(
        width: width*2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.white),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 70.0, horizontal: 80),
              child: Text(
                "Thanks for using NoTechSupport developed by Temple University CIS 4398 NoTechSupport team!\n\n\n\n\n\n Here are our team members:\n\n Aidan E Buehler          Jixi He          Henry Keja Kombem          Dajun Lin          Yangmiao Wu",
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: pageChildren(constraints.biggest.width / 2),
          );
        } else {
          return Column(
            children: pageChildren(constraints.biggest.width),
          );
        }
      },
    );
  }
}
