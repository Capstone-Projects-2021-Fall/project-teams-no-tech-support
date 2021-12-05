import 'dart:developer';

import 'package:myapp/Actions/get-revised-query.dart';
import 'package:myapp/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/Screens/questionOptimizationPage.dart';
import 'package:substring_highlight/substring_highlight.dart';

class offlinePage extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<offlinePage> {
  bool isLoading = false;
  double deviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

  late TextEditingController controller;
  late List<globals.Album> users;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Are You Offline?"),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.symmetric(vertical: 50.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(' '),
                  ),
                  Center(
                    child: SizedBox(
                      width: deviceWidth(context) / 1.2,
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(14.0))),
                        child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                    'You appear not to be connected to the internet! These tips might help...'),
                              ),
                            ])),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text('\n '),
                  ),
                  SizedBox(
                    width: deviceWidth(context) / 3,
                    child: MaterialButton(
                      elevation: 4,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      onPressed: () async {
                        globals.comm.reviseQuestion = await getRevisedQuery();
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 40.0),
                        child: Text(
                          "Back",
                          style: TextStyle(fontSize: 20.0, color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
