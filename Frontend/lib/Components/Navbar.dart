import 'package:flutter/material.dart';
import 'package:myapp/Screens/searchPage.dart';

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
                  child: Text("Home ", style: TextStyle(color: Colors.white),),
                  onPressed: (){
                    //Navigator.of(context).push(
                        //MaterialPageRoute(builder: (context) => searchPage())
                        //);
                  },
                  //style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  width: 30,
                ),
                 TextButton(
                  child: Text("About ", style: TextStyle(color: Colors.white),),
                  onPressed: (){
                    //Navigator.of(context).push(
                        //MaterialPageRoute(builder: (context) => searchPage()));
                  },
                  //style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  width: 30,
                ),
                 TextButton(
                  child: Text("Search", style: TextStyle(color: Colors.white),),
                  onPressed: (){
                    //Navigator.of(context).push(
                        //MaterialPageRoute(builder: (context) => searchPage()));
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
                    //Navigator.of(context).push(
                        //MaterialPageRoute(builder: (context) => searchPage()));
                  },
                  child: Text(
                    "Get Started",
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

class MobileNavbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Container(
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    //Navigator.of(context).push(
                        //MaterialPageRoute(builder: (context) => searchPage()));
                  },
                  child: Text("Home"),
                  //style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  "About Us",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  "Portfolio",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
