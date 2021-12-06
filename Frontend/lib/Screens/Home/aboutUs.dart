import 'package:flutter/material.dart';
import 'package:myapp/globals.dart' as globals;

class aboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        globals.comm.H = constraints.maxHeight;
        globals.comm.W = constraints.maxWidth;
        if (constraints.maxWidth > 1200) {
          return DesktopaboutUsPage();
        } else if (constraints.maxWidth > 800 && constraints.maxWidth < 1200) {
          return DesktopaboutUsPage();
        } else {
          return DesktopaboutUsPage();
        }
      },
    );
  }
}

class DesktopaboutUsPage extends StatelessWidget {
  double deviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
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
                Expanded(
                  child: Card(
                    child: SizedBox(
                      width: globals.comm.W,
                      child: Column(
                        children: [
                          Image(
                            image: AssetImage('Aidan.png'),
                            alignment: Alignment.center,
                            height: globals.comm.W / 6,
                            width: globals.comm.W / 6,
                            fit: BoxFit.fill,
                          ),
                          Text('Aidan E Buehler \n'),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(1.5),
                  child: Text(' '),
                ),
                Expanded(
                  child: Card(
                    child: SizedBox(
                      width: globals.comm.W,
                      child: Column(
                        children: [
                          Image(
                            image: AssetImage('Jixi.png'),
                            alignment: Alignment.center,
                            height: globals.comm.W / 6,
                            width: globals.comm.W / 6,
                            fit: BoxFit.fill,
                          ),
                          Text('Jixi He \n'),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(1.5),
                  child: Text(' '),
                ),
                Expanded(
                  child: Card(
                    child: SizedBox(
                      width: globals.comm.W,
                      child: Column(
                        children: [
                          Image(
                            image: AssetImage('Henry.png'),
                            alignment: Alignment.center,
                            height: globals.comm.W / 6,
                            width: globals.comm.W / 6,
                            fit: BoxFit.fill,
                          ),
                          Text('Henry Keja Kombem \n'),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(1.5),
                  child: Text(' '),
                ),
                Expanded(
                  child: Card(
                    child: SizedBox(
                      width: globals.comm.W,
                      child: Column(
                        children: [
                          Image(
                            image: AssetImage('Dajun.png'),
                            alignment: Alignment.center,
                            height: globals.comm.W / 6,
                            width: globals.comm.W / 6,
                            fit: BoxFit.fill,
                          ),
                          Text('Dajun Lin \n'),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(1.5),
                  child: Text(' '),
                ),
                Expanded(
                  child: Card(
                    child: SizedBox(
                      width: globals.comm.W,
                      child: Column(
                        children: [
                          Image(
                            image: AssetImage('Yangmiao.png'),
                            alignment: Alignment.center,
                            height: globals.comm.W / 6,
                            width: globals.comm.W / 6,
                            fit: BoxFit.fill,
                          ),
                          Text('Yangmiao Wu \n'),
                        ],
                      ),
                    ),
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
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Card(
                child: Column(
                  children: [
                    //Image.asset('images/pic1.jpg'),
                    Text('Aidan E Buehler'),
                  ],
                ),
              ),
            ]),
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Card(
                child: Column(
                  children: [
                    //Image.asset('images/pic1.jpg'),
                    Text('Jixi He'),
                  ],
                ),
              ),
            ]),
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Card(
                child: Column(
                  children: [
                    //Image.asset('images/pic1.jpg'),
                    Text('Henry Keja Kombem'),
                  ],
                ),
              ),
            ]),
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Card(
                child: Column(
                  children: [
                    //Image.asset('images/pic1.jpg'),
                    Text('Dajun Lin'),
                  ],
                ),
              ),
            ]),
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Card(
                child: Column(
                  children: [
                    //Image.asset('images/pic1.jpg'),
                    Text('Yangmiao Wu'),
                  ],
                ),
              ),
            ]),
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
