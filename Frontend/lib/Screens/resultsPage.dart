import 'package:flutter/material.dart';
import 'package:myapp/Actions/get-results.dart';
import 'package:myapp/Actions/get-tech-support-number.dart';
import 'package:myapp/Models/_results.dart';
import 'dart:async';
import 'package:myapp/globals.dart' as globals;
import 'package:url_launcher/url_launcher.dart';

enum ResultsPageTabViews { TextResults, VideoResults }

class ResultsPage extends StatefulWidget {
  final String finalQuestion;
  const ResultsPage({Key? key, required this.finalQuestion}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  ResultsPageState createState() => ResultsPageState();
}

class ResultsPageState extends State<ResultsPage> with TickerProviderStateMixin {
  double deviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
  String importedFinalQuestion =
      ''; // Has  to be immported form previous dart file
  Results results = new Results([], []);
  List<TextLink> textlinks = <TextLink>[];
  String techSupportPhoneNumber = '';
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.animateTo(ResultsPageTabViews.TextResults.index);

    importedFinalQuestion =
        widget.finalQuestion; // Temporary, get this from previous view
    getResults(importedFinalQuestion).then((value) {
      setState(() {
        results = value;
        textlinks = value.textLinks;
      });
    });
    getTechSupportPhoneNumber().then((value) {
      techSupportPhoneNumber = value;
    });
  }

  Widget _buildTextLinksList() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Final Question",
                  style: TextStyle(
                      color: Colors.orange[300],
                      fontSize: 19,
                      fontFamily: 'RobotoMono'),
                ),
                // Text(
                //   importedFinalQuestion,
                //   style: TextStyle(color: Colors.green[200], fontSize: 14),
                // )
                Padding(padding: const EdgeInsets.fromLTRB(15, 0, 0, 15)),
                SizedBox(
                  width: deviceWidth(context) / 2.5,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9.0),
                        border: Border.all(
                            color: Colors.grey.shade300, width: 1.5)),
                    child: Text(importedFinalQuestion),
                  ),
                ),
                Padding(padding: const EdgeInsets.symmetric(vertical: 30.0))
              ],
            ),
            Expanded(
              child: SizedBox(
                width: deviceWidth(context) / 2,
                child: results.textLinks.length == 0
                    ? Container(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                        child: Text(
                          'Sorry. No Results Found for "$importedFinalQuestion." Please go back and edit/filter questions if possible',
                          style: TextStyle(
                              color: Colors.red[300],
                              fontSize: 19,
                              fontFamily: 'RobotoMono'
                              //fontWeight: FontWeight.bold
                              ),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis
                            .vertical, // Axis.horizontal for horizontal list view.
                        itemCount: results.textLinks.length,
                        itemBuilder: (ctx, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: Card(
                              elevation: 8,
                              child: ListTile(
                                //tileColor: Colors.lightBlue[50],
                                title: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            results.textLinks[index].name,
                                            style: TextStyle(
                                                color: Colors.blue[500],
                                                fontSize: 19),
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                IconButton(
                                                  icon: const Icon(
                                                      Icons.thumb_up),
                                                  color: Colors.blue,
                                                  iconSize: 15,
                                                  tooltip: 'Result was helpful',
                                                  onPressed: () {},
                                                ),
                                                IconButton(
                                                  icon: const Icon(
                                                      Icons.thumb_down),
                                                  color: Colors.red,
                                                  iconSize: 15,
                                                  tooltip:
                                                      'Result was misleading',
                                                  onPressed: () {},
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Text(
                                        results.textLinks[index].domain.url,
                                        style: TextStyle(
                                            color: Colors.green[200],
                                            fontSize: 14),
                                      ),
                                      SizedBox(height: 10),
                                      SizedBox(
                                          width: deviceWidth(context) / 2,
                                          child: Text(
                                            results.textLinks[index].snippet,
                                            style: TextStyle(
                                                //color: Colors.orange[300],
                                                fontSize: 16),
                                          )),
                                    ],
                                  ),
                                ),

                                onTap: () {
                                  openLinkinNewTab(textlinks[index].domain.url);
                                },
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
            SizedBox(height: 30),
            globals.comm.mybrand != ''
                ? Positioned(
                    bottom: 0,
                    child: Container(
                      color: Colors.blueGrey[50],
                      child: SizedBox(
                        width: deviceWidth(context) / 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                textStyle: const TextStyle(
                                    fontSize: 17, color: Colors.black),
                                primary: Colors.orangeAccent[100],
                              ),
                              onPressed: () {
                                showMyMaterialDialog(context,
                                    "Do you want to navigate to the video results section?");
                              },
                              child: const Text(
                                'Couldn\'t find an answer?',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  void showMyMaterialDialog(BuildContext context, String modalText) {
    showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
            title: new Text(" "),
            content: Container(
              width: MediaQuery.of(context).size.width * 0.45,
              child: Text(modalText),
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 17),
                  primary: Colors.blue[300],
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  _tabController.animateTo(ResultsPageTabViews.VideoResults.index);
                  // setState(() {
                    
                  // });
                  
                },
                child: const Text('Yes'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 17),
                  primary: Colors.red[300],
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  TechSupportNumberModal(
                      context, techSupportPhoneNumber, globals.comm.mybrand);
                },
                child: const Text('No'),
              ),
            ],
          );
        });
  }

  void TechSupportNumberModal(
      BuildContext context, String techSupportNumber, String BrandName) {
    showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
            title: new Text(" "),
            content: Container(
              width: MediaQuery.of(context).size.width * 0.45,
              child: Text("Sorry we couldn't help 😟. Here is " +
                  BrandName +
                  "'s tech support number: " +
                  techSupportNumber),
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 17),
                  primary: Colors.blue[300],
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Ok'),
              ),
            ],
          );
        });
  }

  Future<void> openLinkinNewTab(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return  Scaffold(
        appBar: AppBar(
          bottom:  TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                icon: Icon(Icons.pages),
                text: 'Pages',
              ),
              Tab(
                icon: Icon(Icons.video_collection),
                text: 'Videos',
              ),
            ],
          ),
          title: const Text('Results'),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildTextLinksList(),
            Icon(Icons.video_library),
          ],
        ),
      );
    
  }
}
