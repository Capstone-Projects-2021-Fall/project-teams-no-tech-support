import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:myapp/Models/_question.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const QuestionOptimizationPage(title: 'Question Optimization'),
    );
  }
}

class QuestionOptimizationPage extends StatefulWidget {
  const QuestionOptimizationPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<QuestionOptimizationPage> createState() => QuestionOptimizationPageState();
}

class QuestionOptimizationPageState extends State<QuestionOptimizationPage> {
  int _counter = 0;
  // activeQuery ='My Pixel 3a My Phone screen turns blue when I try to reduce the volume';
  static String mockQuery1Content =
      'My Pixel 3a  screen turns blue when I try to reduce the volume';
  static List<String> mockQuerySuggestion1 = <String>[
    'My Pixel 3 screen turns blue when I try to reduce the volume while watching a video',
    'My Pixel 3a  screen turns blue when I go to my gallery',
    'Black Screen when I turn on my google pixel 3',
  ];
  static String mockQueryContent2 =
      'My Pixel 3 screen turns blue when I try to reduce the volume while watching a video';
  static List<String> mockQuerySuggestion2 = <String>[
    'My Pixel 3XL  screen turns blue and battery overheates after watchign a video for a few minutes',
    'My Pixel 3a  screen turns blue when I attempt to watch a video'
  ];

  static String mockQuery3Content =
      'My Pixel 3XL  screen turns blue and battery overheates after watchign a video for a few minutes';
  static List<String> mockQuerySuggestion3 = <String>[];

  static Question query1 = Question(mockQuery1Content, mockQuerySuggestion1);
  static Question query2 = Question(mockQueryContent2, mockQuerySuggestion2);
  static Question query3 = Question(mockQuery3Content, mockQuerySuggestion3);
  static Question query4 =
      Question(mockQuery3Content, <String>[]); //no suggestions

  static List<Question> queryLogHelper = <Question>[
    query1,
    query2,
    query3,
    query4
  ];
  int addedQueryCounter = 0;
  static List<Question> queryLog = <Question>[query1];
  static Question activeQuery = query1;
  static String activeQueryName = 'Version 1';
  static double deviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double deviceWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void addToQueryLog(String? incomingQuestion) {
    setState(() {
      //API Call to get suggestions for incoming question then initialize Question Object, using dummy for now
      addedQueryCounter++; //temp
      Question questionToBeAdded = queryLogHelper[addedQueryCounter]; //temp

      queryLog.add(questionToBeAdded);
      activeQuery = questionToBeAdded;
      activeQueryName = 'Version ${queryLog.length}';
    });
  }

  void removeFromQueryLog(int index) {
    //delete all questions past index given
    setState(() {
      addedQueryCounter = index;
      if (queryLog.length > 1) {
        activeQuery = queryLog[index];
        activeQueryName = 'Version ${index + 1}';
        queryLog = queryLog.sublist(0, index + 1);
      }
      //Do nothing
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,

            children: <Widget>[
           
              SizedBox(
                width: 900,
                height: 200,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis
                      .vertical, // Axis.horizontal for horizontal list view.
                  itemCount: queryLog.length,
                  itemBuilder: (ctx, index) {
                    return ListTile(
                      // selected: queryLog[index].content == activeQuery.content,
                      // title: Container(
                      //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      //   child: Text('Version ${index+1} '),
                      // ),
                      tileColor: Colors.lightBlue[50],
                      title: Row(
                        children: [
                          Text('Version ${index + 1}:   '),
                          Text(queryLog[index].content),
                          const SizedBox(
                            width: 30,
                          ),
                          Visibility(
                            visible:
                                queryLog[index].content == activeQuery.content,
                            child: IconTheme(
                              data: IconThemeData(color: Colors.green[800]),
                              child: const Icon(
                                Icons.check_circle,
                                //color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // subtitle: Container(
                      //         height: 30,
                      //         margin: const EdgeInsets.all(10),
                      //         //padding: const EdgeInsets.all(10),
                      //         //alignment: Alignment.center,
                      //         decoration: BoxDecoration(
                      //             color: Colors.white,
                      //             border: Border.all(
                      //                 color: Colors.grey, // Set border color
                      //                 width: 3.0), // Set border width
                      //             borderRadius: const BorderRadius.all(
                      //                 Radius.circular(
                      //                     10.0)), // Set rounded corner radius
                      //             // boxShadow: const [
                      //             //   BoxShadow(
                      //             //       blurRadius: 10,
                      //             //       color: Colors.black,
                      //             //       offset: Offset(1, 3))
                      //             // ] // Make rounded corner of border
                      //             ),
                      //         child: Text(queryLog[index].content),
                      //       ),
                      // title: Align(
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: <Widget>[
                      //       Text(index == 0
                      //           ? 'Initial Question: '
                      //           : 'Question $index : '),
                      //       Container(
                      //         height: 30,
                      //         margin: const EdgeInsets.all(10),
                      //         //padding: const EdgeInsets.all(10),
                      //         alignment: Alignment.center,
                      //         decoration: BoxDecoration(
                      //             color: Colors.orange,
                      //             border: Border.all(
                      //                 color: Colors.pink, // Set border color
                      //                 width: 3.0), // Set border width
                      //             borderRadius: const BorderRadius.all(
                      //                 Radius.circular(
                      //                     10.0)), // Set rounded corner radius
                      //             boxShadow: const [
                      //               BoxShadow(
                      //                   blurRadius: 10,
                      //                   color: Colors.black,
                      //                   offset: Offset(1, 3))
                      //             ] // Make rounded corner of border
                      //             ),
                      //         child: Text(queryLog[index].content),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      onTap: () {
                        removeFromQueryLog(index);
                      }, //Fix this, figure out how to call a known function
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                ),
              ),
              
              Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: activeQuery.suggestions.isEmpty
                    ? [
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                          child: Text(
                              'No suggestions found for $activeQueryName. Click on the "Get Results" button, or select prior question suggestions',
                              style: TextStyle(
                                color: Colors.orange[300],
                                fontSize: 19,
                                
                                ),
                              ),
                        )
                      ]
                    : <Widget>[
                        DropdownButton(
                          //isExpanded: true,
                          hint: Text(
                              'View/Select Question suggestions for $activeQueryName '),
                          items: activeQuery.suggestions.map(
                            (suggestion) {
                              return DropdownMenuItem<String>(
                                value: suggestion,
                                child: Text(suggestion),
                              );
                            },
                          ).toList(),
                          onChanged: addToQueryLog,
                        )
                      ],
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 17)),
                      onPressed: () {},
                      child: const Text('Back'), //temporary
                    ),
                    const SizedBox(width: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 17)),
                      onPressed: () {}, //temporary
                      child: const Text('Get Results'),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
