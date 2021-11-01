import 'package:flutter/material.dart';
import 'package:myapp/Models/_question.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myapp/Actions/getRelatedSearches.dart';
import 'package:myapp/Models/_question.dart';

class QuestionOptimizationPage extends StatefulWidget {
  const QuestionOptimizationPage({Key? key, required this.generatedQuestion})
      : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String generatedQuestion;

  @override
  QuestionOptimizationPageState createState() =>
      QuestionOptimizationPageState();
}

class QuestionOptimizationPageState extends State<QuestionOptimizationPage> {
  int addedQueryCounter = 0;
  List<Question> queryLog = <Question>[];
  Question activeQuery = new Question("", <String>[]);
  String activeQueryName = 'Version 1';
  double deviceHeight(BuildContext context) =>MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

  @override
  void initState() {
    super.initState();

    String initialQuestion ='My Phone'; // Temporary, get this from previous view
    getRelatedSearches(initialQuestion).then((value) {
      setState(() {
        activeQuery = new Question(initialQuestion, value);
        queryLog.add(activeQuery);
      });

      //queryLog.add(new Question("initialQuestion", <String>[]));
      print("Async done");
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

  addToQueryLog(String? question) async {
    List<String> relatedQuestions = await getRelatedSearches(question!);

    setState(() {
      activeQuery = new Question(question, relatedQuestions);
      queryLog.add(activeQuery);
      activeQueryName = 'Version ${queryLog.length}';
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
        title: const Text('Question Optimization'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,

            children: <Widget>[
              SizedBox(height: 30),
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
                      tileColor: Colors.lightBlue[50],
                      title: Row(
                        children: [
                          Text(
                            'Version ${index + 1}:   ',
                            style: TextStyle(
                                color: Colors.orange[300],
                                fontWeight: FontWeight.bold),
                          ),
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
                            'No suggestions found for $activeQueryName. Click on the \'Get Results\' button below, or select prior question versions',
                            style: TextStyle(
                                color: Colors.red[300],
                                fontSize: 19,
                                fontFamily: 'RobotoMono'
                                //fontWeight: FontWeight.bold
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
                      child: const Text('Cancel'), //temporary
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
    );
  }
}
