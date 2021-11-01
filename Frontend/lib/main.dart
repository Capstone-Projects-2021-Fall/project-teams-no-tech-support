import 'package:flutter/material.dart';
import 'package:myapp/Screens/homePage.dart';
import 'package:myapp/Components/Navbar.dart';
import 'package:myapp/Screens/resultPage.dart';
import 'package:myapp/Screens/searchPage.dart';
import 'package:myapp/Screens/Home/aboutUs.dart';
import 'package:myapp/Screens/MobileSearchPage.dart';
import 'package:myapp/Screens/current_device.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NoTechSupport',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "Montserrat"),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.centerRight,
              colors: [
                Color.fromRGBO(215, 191, 255, 1.0),
                Color.fromRGBO(0, 191, 255, 1.0)
              ]),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Navbar(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 100.0, horizontal: 80.0),
                child: homePage()
              )
            ],
          ),
        ),
      ),
    );
  }
}

class myresultpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromRGBO(215, 191, 255, 1.0),
                Color.fromRGBO(0, 191, 255, 1.0)
              ]),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Navbar(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 40.0),
                child: resultPage()
              )
            ],
          ),
        ),
      ),
    );
  }
}
class mysearchpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
                child: searchPage()
              )
    );
  }
}

class Mobilemysearchpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
                child: MobilesearchPage()
              )
    );
  }
}

class myaboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromRGBO(215, 191, 255, 1.0),
                Color.fromRGBO(0, 191, 255, 1.0)
              ]),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Navbar(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 40.0),
                child: aboutUsPage()
              )
            ],
          ),
        ),
      ),
    );
  }
}


class mydeviceinfopage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
                child: DeviceDetail()
              )
    );
  }
}
