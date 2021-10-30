import 'package:flutter/material.dart';

class aboutUsPage extends StatelessWidget {
  List<Widget> pageChildren(double width) {
    return <Widget>[
      Container(
        width: width * 2,
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
                "Thanks for using NoTechSupport developed by Temple University CIS 4398 NoTechSupport team!",
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(' '),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  child: Column(
                    children: [
                      Image.asset('images/pic1.jpg'),
                      Text('Aidan E Buehler'),
                    ],
                  ),
                ),
                Spacer(flex: 2),
                Card(
                  child: Column(
                    children: [
                      Image.asset('images/pic1.jpg'),
                      Text('Jixi He'),
                    ],
                  ),
                ),
                Spacer(flex: 2),
                Card(
                  child: Column(
                    children: [
                      Image.asset('images/pic1.jpg'),
                      Text('Henry Keja Kombem'),
                    ],
                  ),
                ),
                Spacer(flex: 2),
                Card(
                  child: Column(
                    children: [
                      Image.asset('images/pic1.jpg'),
                      Text('Dajun Lin'),
                    ],
                  ),
                ),
                Spacer(flex: 2),
                Card(
                  child: Column(
                    children: [
                      Image.asset('images/pic1.jpg'),
                      Text('Yangmiao Wu'),
                    ],
                  ),
                ),
              ],
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
