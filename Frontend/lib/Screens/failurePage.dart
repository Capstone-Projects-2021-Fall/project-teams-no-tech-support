import 'dart:developer';

import 'package:myapp/Screens/resultsPage.dart';
import 'package:myapp/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:myapp/main.dart';
import 'package:myapp/Screens/questionOptimizationPage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class failurePage extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<failurePage> {
  bool isFoundTechPhone = false;
  String sPhone = "\nResult not found!\n";

  double deviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

  Future GetTechPhone() async {
    try {
      if (globals.comm.mybrand == "") return;

      final response = await http.get(
          Uri.parse('http://notechapi.aidanbuehler.net/brand?brand=' +
              globals.comm.mybrand),
          headers: {
            "Accept": "*/*",
            "Access-Control_Allow_Origin": "*",
            "Access-Control-Allow-Headers":
                "origin, x-requested-with, content-type",
            "Access-Control-Allow-Methods": "PUT, GET, POST, DELETE, OPTIONS"
          });

      if (response.statusCode == 200) {
        Map<String, dynamic> user = jsonDecode(response.body);

        if (user['phone'] != null) {
          sPhone = globals.comm.mybrand +
              '\n\n Technology support number: \n\n' +
              user['phone'].toString() +
              "\n\n";
        }
      } else {
        print("Error getting users.");
      }
    } catch (e) {
      print("Catch error: ");
      print(e.toString());
    }
  }

  @override
  void initState() {
    //Start here

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: GetTechPhone(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text("Somthing wrong here...");
          } else {
            return Scaffold(
                appBar: AppBar(
                  title: Text("Result not found"),
                ),
                body: Stack(
                  children: <Widget>[
                    Container(
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage("images/1.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.0),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: deviceHeight(context) / 30,
                            ),
                            SizedBox(
                              width: deviceWidth(context) / 1.6,
                              child: Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(14.0))),
                                child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: Text('\n'),
                                      ),
                                      Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        children: [
                                          Icon(Icons.headset_mic,
                                              color: Colors.amber, size: 96.0),
                                          Text('\n\n'),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Text('\n\n'),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: Text(
                                          sPhone,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 24.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54),
                                        ),
                                      ),
                                    ])),
                              ),
                            ),
                            SizedBox(
                              height: deviceHeight(context) / 30,
                            ),
                            SizedBox(
                                width: deviceWidth(context) / 1.6,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: MaterialButton(
                                        elevation: 4,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(14.0))),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              //   builder: (context) => QuestionOptimizationPage(
                                              //       generatedQuestion: "Not quite there yet"), //
                                              // ),
                                              builder: (context) => ResultsPage(
                                                  finalQuestion: globals
                                                      .comm.reviseQuestion), //
                                            ),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20.0, horizontal: 40.0),
                                          child: Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            children: [
                                              Icon(Icons.arrow_back,
                                                  color: Colors.blue),
                                              Text(
                                                " Back",
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: Colors.blue),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: MaterialButton(
                                        elevation: 4,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(14.0))),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MyHomePage(),
                                            ),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20.0, horizontal: 40.0),
                                          child: Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            children: [
                                              Icon(Icons.search,
                                                  color: Colors.blue),
                                              Text(
                                                " Search again!",
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: Colors.blue),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ));
          }
        });
  }
}
