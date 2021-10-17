import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Screens/homePage.dart';
import 'package:myapp/Components/Navbar.dart';
import 'package:myapp/Screens/resultPage.dart';
import 'package:myapp/Screens/searchPage.dart';

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
                "Thanks for using NoTechSupport developed by Temple University CIS 4398 NoTechSupport team! Before your search, please modify your Device Name, Brand, and Operating System, and then enter your question. Good Luck and hope you can get your device fixed soon!",
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
