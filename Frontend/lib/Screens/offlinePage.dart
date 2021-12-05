import 'dart:developer';

import 'package:myapp/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  final List<String> entries = <String>[
    'Restart your device:\nSimply restarting your device fixes a wide array of issues',
    'Check if your device is connected to the internet:\nYou may have turned off WIFI. Turn it back on to reconnect!',
    'Restart your router:\nUnplug your router or modem, wait 30 seconds, and plug it back in.',
    'Check another device:\nTry another phone or computer on your network. If it\'s not just one, it may be a router or service provider issue.',
    'Do you have a limited service plan?\nIf you rely on a cellular internet connection, you may be out of minutes!'
  ];
  final List<int> colorCodes = <int>[300, 100, 300, 100, 300];

  @override
  void initState() {
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
                  Expanded(
                    child: SizedBox(
                      height: 200.0,
                      child: new ListView.separated(
                        padding: const EdgeInsets.all(8),
                        itemCount: entries.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 50,
                            color: Colors.cyan[colorCodes[index]],
                            child: Center(child: Text('${entries[index]}')),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                      ),
                    ),
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
