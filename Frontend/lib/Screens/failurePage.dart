import 'package:myapp/Screens/resultsPage.dart';
import 'package:myapp/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/Screens/questionOptimizationPage.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class failurePage extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<failurePage> {
  bool isFoundTechPhone = false;
  String sPhone = "";

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

        sPhone = (user['phone'] == null) ? "" : user['phone'].toString();

        if (sPhone != "") {
          sPhone =
              globals.comm.mybrand + ' technology support number: ' + sPhone;
        }

        //setState();

        print("phone:");
        print(sPhone);
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
                        padding: EdgeInsets.symmetric(vertical: 50.0),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(1.0),
                              child: Text(' '),
                            ),
                            SizedBox(
                              width: deviceWidth(context) / 1.6,
                              child: Card(
                                child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(children: <Widget>[
                                      //What is the problem

                                      Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: Text(''),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: Text(sPhone),
                                      ),
                                    ])),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(' '),
                            ),
                            MaterialButton(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        QuestionOptimizationPage(
                                            generatedQuestion:
                                                "Not quite there yet"), //
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 40.0),
                                child: Text(
                                  sPhone,
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.red),
                                ),
                              ),
                            ),
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
