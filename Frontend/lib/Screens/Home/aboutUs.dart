import 'package:flutter/material.dart';

class aboutUsPage extends StatelessWidget {
    @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return DesktopaboutUsPage();
        } else if (constraints.maxWidth > 800 && constraints.maxWidth < 1200) {
          return DesktopaboutUsPage();
        } else {
          return MobileaboutUsPage();
        }
      },
    );
  }
}


class DesktopaboutUsPage extends StatelessWidget {
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
                      Image.asset('Aidan.png'),
                      Text('Aidan E Buehler'),
                    ],
                  ),
                ),
                Spacer(flex: 2),
                Card(
                  child: Column(
                    children: [
                      Image.asset('Jixi.png'),
                      Text('Jixi He'),
                    ],
                  ),
                ),
                Spacer(flex: 2),
                Card(
                  child: Column(
                    children: [
                      Image.asset('Henry.png'),
                      Text('Henry Keja Kombem'),
                    ],
                  ),
                ),
                Spacer(flex: 2),
                Card(
                  child: Column(
                    children: [
                      Image.asset('Dajun.png'),
                      Text('Dajun Lin'),
                    ],
                  ),
                ),
                Spacer(flex: 2),
                Card(
                  child: Column(
                    children: [
                      Image.asset('Yangmiao.png'),
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


class MobileaboutUsPage extends StatelessWidget {
  List<Widget> pageChildren(double width) {
    return <Widget>[
      Container(
        //width: width * 2,
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
              padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 0),
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
                      //Image.asset('images/pic1.jpg'),
                      Text('Aidan E Buehler'),
                    ],
                  ),
                ),
              ]
            ),
                        Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  child: Column(
                    children: [
                      //Image.asset('images/pic1.jpg'),
                      Text('Jixi He'),
                    ],
                  ),
                ),
              ]
            ),
                                    Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  child: Column(
                    children: [
                      //Image.asset('images/pic1.jpg'),
                      Text('Henry Keja Kombem'),
                    ],
                  ),
                ),
              ]
            ),
                                    Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  child: Column(
                    children: [
                      //Image.asset('images/pic1.jpg'),
                      Text('Dajun Lin'),
                    ],
                  ),
                ),
              ]
            ),
                                    Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  child: Column(
                    children: [
                      //Image.asset('images/pic1.jpg'),
                      Text('Yangmiao Wu'),
                    ],
                  ),
                ),
              ]
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
