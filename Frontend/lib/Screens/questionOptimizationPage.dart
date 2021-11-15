import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:myapp/Actions/get-results.dart';
import 'package:myapp/Models/_question.dart';
import 'package:myapp/Actions/get-related-searches.dart';
import 'package:myapp/Models/_results.dart';
import 'package:myapp/Screens/resultsPage.dart';
import 'package:myapp/Screens/tempSearchPage.dart';
import 'package:myapp/partsOfSpeech.dart';

class QuestionOptimizationPage extends StatefulWidget {
  final String generatedQuestion;
  const QuestionOptimizationPage({Key? key, required this.generatedQuestion})
      : super(key: key);

  @override
  QuestionOptimizationPageState createState() =>
      QuestionOptimizationPageState();
}

class WordFrequency {
  int frequency;
  String word;

  WordFrequency(this.word, this.frequency);

  incrementCount() {
    this.frequency++;
  }
}

class QuestionOptimizationPageState extends State<QuestionOptimizationPage> {
  int addedQueryCounter = 0;
  List<Question> queryLog = <Question>[];
  Question activeQuery = new Question("", <String>[]);
  String activeQueryName = '';
  String initialQueryName = 'Initial Question ';
  double deviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
  Results allResults = new Results([], []);
  List<WordFrequency> mostRecurringWordsInResultHeaders = [];

  @override
  void initState() {
    super.initState();
    activeQueryName = initialQueryName;
    String initialQuestion = widget.generatedQuestion;
    // getRelatedSearches(initialQuestion).then((value) {
    //   setState(() {
    //     activeQuery = new Question(initialQuestion, value);
    //     queryLog.add(activeQuery);
    //   });
    // });
    getResults(initialQuestion).then((value) {
      setState(() {
        // debugger();
        // activeQuery = new Question("What is CORS issue in javascript", []);
        // queryLog.add(activeQuery);
        allResults = value;
        // List<String> tempPrePosition = ["when", "by"];
        // // List<WordFrequency> tempFrequentHeaders = [];
        // // tempFrequentHeaders.add(new WordFrequency("cors", 4));
        // // tempFrequentHeaders.add(new WordFrequency("javascript", 2));
        // int mostRecurringWordsInResultHeadersLength = 0;

        activeQuery = new Question(initialQuestion, getOptimizedResultsHeaders());
        queryLog.add(activeQuery);
        //debugger();
      });
    });
  }

  List<String> getOptimizedResultsHeaders() {
    //debugger();
    mostRecurringWordsInResultHeaders = getmostRecurringWordsInResultHeaders(8);
    List<String> acceptedResultHeaders = [];
    allResults.textLinks.forEach((textlink) {
      int highFrequencyMatches = 0;
      mostRecurringWordsInResultHeaders.forEach((element) {
        //debugger();
        if (textlink.name.toLowerCase().contains(element.word.toLowerCase() + ' ')) {
          //debugger();
          highFrequencyMatches++;
          if (highFrequencyMatches ==
              mostRecurringWordsInResultHeaders.length) {
            for (String prePosition in partsOfSpeech.partsOfSpeechforAcceptedResultFiltering) {
              //debugger();
              bool breakOutOfPrepositionLoop = false;
              //debugger();
               for (String text in partsOfSpeech.unwantedTextForFiltering) {
                if(textlink.name.toLowerCase().contains(text.toLowerCase())){
                  breakOutOfPrepositionLoop = true;
                  break;
                }
              }
              if(breakOutOfPrepositionLoop){
                break;
              }
              if (textlink.name.toLowerCase().contains(prePosition.toLowerCase())) {
                //textlink.name = textlink.name.replaceAll('...', '');
                //debugger();
                 //if(!textlink.domain.url.toLowerCase().contains("youtube")){ /* Youtube links will be used for video results */
                  acceptedResultHeaders.add(textlink.name);
                  break;
                //} 
              
              }
              if(breakOutOfPrepositionLoop){break;};
              
            }
            ;
          }
        }
      });
    });
    //debugger();
    return acceptedResultHeaders.toSet().toList();
  }

  List<WordFrequency> getmostRecurringWordsInResultHeaders(int frequencyDifferenceCap) {
    /* frequencyDifferenceCap is the accepted frequency difference between the words of high frequency, to determing the most recurring text in the result headers*/
    if (allResults.textLinks.isEmpty) return [];
//debugger();
    String concatenatedResultHeaders = '';
    List<String> splitWords = [];
    List<WordFrequency> wordFrequencies = [];
    List<String> processedUnwantedWords = [];
    int highestFrequency = 0;

    concatenatedResultHeaders = allResults.textLinks
        .map((x) => x.name)
        .toList()
        .join(' ')
        .trim()
        .replaceAll(RegExp('\\s+'), ' ');
    splitWords = concatenatedResultHeaders.split(' ');
    splitWords.forEach((word) {
      word = word.toLowerCase();
      List<String> savedWords = wordFrequencies.map((e) => e.word).toList();
      if (savedWords.contains(word)) {
        wordFrequencies
            .firstWhere((element) => element.word == word)
            .incrementCount();
      } else {
        if (processedUnwantedWords.contains(word)) return;
        partsOfSpeech.allavailablePartsofSpeech.contains(word)
            ? processedUnwantedWords.add(word)
            : wordFrequencies.add(new WordFrequency(word, 1));
      }
    });
    highestFrequency = wordFrequencies
        .map((e) => e.frequency)
        .toList()
        .reduce((a, b) => a > b ? a : b);
    List<WordFrequency> mostRecurringWords = wordFrequencies
        .where((element) =>
            (highestFrequency - element.frequency) < frequencyDifferenceCap)
        .toList();
    mostRecurringWords.sort((a, b) => b.frequency.compareTo(a.frequency));
    return mostRecurringWords;
  }

  void removeFromQueryLog(int index) {
    //delete all questions past index given
    setState(() {
      addedQueryCounter = index;
      if (queryLog.length > 1) {
        activeQuery = queryLog[index];
        activeQueryName = 'Related Issue ${index}';
        queryLog = queryLog.sublist(0, index + 1);
        if (queryLog.length == 1) {
          activeQueryName = initialQueryName;
        }
      }

      //Do nothing
    });
  }

  addToQueryLog(String? question)  {
     
       getResults(question.toString()).then((value) {
   
      setState(() {
             //debugger();
        // debugger();
        // activeQuery = new Question("What is CORS issue in javascript", []);
        // queryLog.add(activeQuery);
        allResults = value;
        // List<String> tempPrePosition = ["when", "by"];
        // // List<WordFrequency> tempFrequentHeaders = [];
        // // tempFrequentHeaders.add(new WordFrequency("cors", 4));
        // // tempFrequentHeaders.add(new WordFrequency("javascript", 2));
        // int mostRecurringWordsInResultHeadersLength = 0;

        activeQuery = new Question(question.toString(), getOptimizedResultsHeaders());
        queryLog.add(activeQuery);
        activeQueryName = 'Related Issue ${queryLog.length - 1}';
        //debugger();
      });
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
                height: 400,
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
                            index == 0
                                ? initialQueryName
                                : 'Related Issue ${index}:   ',
                            style: TextStyle(
                              color: Colors.orange[300],
                              //fontWeight: FontWeight.bold
                            ),
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
                            'No suggestions found for $activeQueryName. Click on the \'Get Results\' button below, or select prior question Related Issues',
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
                              'View/Select Question related issues for $activeQueryName '),
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              //   builder: (context) => QuestionOptimizationPage(
                              //       generatedQuestion: "Not quite there yet"), //
                              // ),
                              builder: (context) => tempSearchPage()
                              //
                              ),
                        );
                      },
                      child: const Text('Cancel'), //temporary
                    ),
                    const SizedBox(width: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 17)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            //   builder: (context) => QuestionOptimizationPage(
                            //       generatedQuestion: "Not quite there yet"), //
                            // ),
                            builder: (context) => ResultsPage(
                                finalQuestion: activeQuery.content), //
                          ),
                        );
                      }, //temporary
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
