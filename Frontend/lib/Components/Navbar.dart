import 'package:flutter/material.dart';
import 'package:myapp/main.dart';

class Navbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return DesktopNavbar();
        } else if (constraints.maxWidth > 800 && constraints.maxWidth < 1200) {
          return DesktopNavbar();
        } else {
          return MobileNavbar();
        }
      },
    );
  }
}

class DesktopNavbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "NoTechSupport",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 30),
            ),
            Row(
              children: <Widget>[
                TextButton(
                  child: Text(
                    "Home",
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MyHomePage()));
                  },
                  //style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  width: 30,
                ),
                TextButton(
                  child: Text(
                    "About Us",
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => myaboutUsPage()));
                  },
                  //style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  width: 30,
                ),
                TextButton(
                  child: Text(
                    "Search",
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => mysearchpage()));
                  },
                  //style: TextStyle(color: Colors.white),
                ),
                //Text(
                //  "Search",
                //  style: TextStyle(color: Colors.white),
                //),
                SizedBox(
                  width: 30,
                ),
                MaterialButton(
                  color: Colors.pink,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => mydeviceinfopage()));
                  },
                  child: Text(
                    "My Device Info",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
////////////////////////////
                ///
                TextButton(
                  child: Text(
                    "FP",
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => myFailurePage()));
                  },
                  //style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  width: 30,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MobileNavbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20),
            ),
            Row(
              children: <Widget>[
                TextButton(
                  child: Text(
                    "Home",
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MyHomePage()));
                  },
                  //style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  width: 20,
                ),
                TextButton(
                  child: Text(
                    "About Us",
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => myaboutUsPage()));
                  },
                  //style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  width: 20,
                ),
                TextButton(
                  child: Text(
                    "Search",
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Mobilemysearchpage()));
                  },
                  //style: TextStyle(color: Colors.white),
                ),
                //Text(
                //  "Search",
                //  style: TextStyle(color: Colors.white),
                //),
                SizedBox(
                  width: 10,
                ),
                MaterialButton(
                  color: Colors.pink,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => mydeviceinfopage()));
                  },
                  child: Text(
                    "My Device Info",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
