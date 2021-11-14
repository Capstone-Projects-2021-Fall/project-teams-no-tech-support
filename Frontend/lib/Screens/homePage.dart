import 'package:flutter/material.dart';
import 'package:myapp/Screens/MobileSearchPage.dart';
import 'package:myapp/Screens/searchPage.dart';
//import 'package:myapp/Screens/tempSearchPage.dart';
import 'package:myapp/Screens/questionFilteringPage.dart';
import 'package:myapp/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'package:substring_highlight/substring_highlight.dart';

class homePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return DesktophomePage();
        } else if (constraints.maxWidth > 800 && constraints.maxWidth < 1200) {
          return DesktophomePage();
        } else {
          return DesktophomePage();
          //return MobilehomePage();
        }
      },
    );
  }
}

class DesktophomePage extends StatelessWidget {
  late List<String> autoCompleteDataSearch;
  late TextEditingController controller;
  late List<globals.TQuestion> ReviseQuery;

  String generateInitialQuery() {
    return globals.comm.question +
        " " +
        globals.comm.mybrand +
        " " +
        globals.comm.mymodel +
        " " +
        globals.comm.mydevice;
  }

  void showMyMaterialDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
            title: new Text(" "),
            content: Container(
              width: MediaQuery.of(context).size.width * 0.45,
              child: Text(
                "There is not matched device, brand and model, do you want to add them manually? ",
              ),
            ),
            actions: <Widget>[
              new MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => searchPage(),
                    ),
                  );
                },
                child: new Text("Yes"),
              ),
              new MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuestionOptimizationPage(
                          generatedQuestion: generateInitialQuery()), //
                    ),
                  );
                },
                child: new Text("No"),
              ),
            ],
          );
        });
  }

  void SendQuestion() async {
    try {
      final response = await http.get(
          Uri.parse('http://notechapi.aidanbuehler.net/extract?query=' +
              globals.comm.question),
          headers: {
            "Accept": "*/*",
            "Access-Control_Allow_Origin": "*",
            "Access-Control-Allow-Headers":
                "origin, x-requested-with, content-type",
            "Access-Control-Allow-Methods": "PUT, GET, POST, DELETE, OPTIONS"
          });

      if (response.statusCode == 200) {
        ReviseQuery = globals.comm.loadQuestionJson(response.body);

        if (ReviseQuery.length > 0) {
          print(ReviseQuery[0].sQuery.toString());
          globals.comm.mydevice = ReviseQuery[0].sDevice.toString();
          globals.comm.mybrand = ReviseQuery[0].sBrand.toString();
          globals.comm.mymodel = ReviseQuery[0].sModel.toString();
          globals.comm.reviseQuestion = ReviseQuery[0].sQuery.toString();
        }
      } else {
        print("Error getting users.");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  List<Widget> pageChildren(double width, BuildContext context) {
    return <Widget>[
      Container(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Hi there!",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                  color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                "Thanks for using NoTechSupport developed by Temple University CIS 4398 NoTechSupport team! Before your search, please modify your Device Name, Brand, and Operating System, and then enter your question. Good Luck and hope you can get your device fixed soon!",
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(0.5),
              child: Text(' '),
            ),
            //Search
            Autocomplete(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return const Iterable<String>.empty();
                } else {
                  return autoCompleteDataSearch.where((word) => word
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase()));
                }
              },
              optionsViewBuilder:
                  (context, Function(String) onSelected, options) {
                return Material(
                  elevation: 4,
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      final option = options.elementAt(index);

                      return ListTile(
                        // title: Text(option.toString()),
                        title: SubstringHighlight(
                          text: option.toString(),
                          term: controller.text,
                          textStyleHighlight:
                              TextStyle(fontWeight: FontWeight.w700),
                        ),
                        onTap: () {
                          onSelected(option.toString());
                        },
                      );
                    },
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: options.length,
                  ),
                );
              },
              onSelected: (selectedString) {
                globals.comm.question = selectedString.toString();
              },
              fieldViewBuilder:
                  (context, controller, focusNode, onEditingComplete) {
                this.controller = controller;

                return TextField(
                  controller: controller,
                  focusNode: focusNode,
                  onEditingComplete: onEditingComplete,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                  ),
                );
              },
            ),

            // Padding(
            //   padding: EdgeInsets.all(5.0),
            //   child: Text(' '),
            // ),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Card(
            //       child: Column(
            //         children: [
            //           Text(
            //               'There is not matched device, brand and model, do you want to add them manually? '),
            //           Row(children: [
            //             MaterialButton(
            //               color: Colors.white,
            //               shape: RoundedRectangleBorder(
            //                   borderRadius:
            //                       BorderRadius.all(Radius.circular(10.0))),
            //               onPressed: () {
            //                 // Navigator.push(
            //                 //   context,
            //                 //   MaterialPageRoute(
            //                 //     builder: (context) => tempSearchPage(),
            //                 //   ),
            //                 // );
            //               },
            //               child: Padding(
            //                 padding: const EdgeInsets.symmetric(
            //                     vertical: 2.0, horizontal: 2.0),
            //                 child: Text(
            //                   "Yes",
            //                   style:
            //                       TextStyle(fontSize: 8.0, color: Colors.black),
            //                 ),
            //               ),
            //             ),
            //             Padding(
            //               padding: EdgeInsets.all(5.0),
            //               child: Text(' '),
            //             ),
            //             MaterialButton(
            //               color: Colors.white,
            //               shape: RoundedRectangleBorder(
            //                   borderRadius:
            //                       BorderRadius.all(Radius.circular(10.0))),
            //               onPressed: () {
            //                 // Navigator.push(
            //                 //   context,
            //                 //   MaterialPageRoute(
            //                 //     builder: (context) => tempSearchPage(),
            //                 //   ),
            //                 // );
            //               },
            //               child: Padding(
            //                 padding: const EdgeInsets.symmetric(
            //                     vertical: 2.0, horizontal: 2.0),
            //                 child: Text(
            //                   "No",
            //                   style:
            //                       TextStyle(fontSize: 8.0, color: Colors.black),
            //                 ),
            //               ),
            //             )
            //           ])
            //         ],
            //       ),
            //     ),
            //   ],
            // ),

            Padding(
              padding: EdgeInsets.all(2.0),
              child: Text(' '),
            ),

            MaterialButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              onPressed: () {
                //
                SendQuestion();
                showMyMaterialDialog(context);

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => tempSearchPage(),
                //   ),
                // );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 40.0),
                child: Text(
                  "Search!",
                  style: TextStyle(fontSize: 20.0, color: Colors.red),
                ),
              ),
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Image.asset(
          "assets/images/image1.png",
          width: width,
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: pageChildren(constraints.biggest.width / 2, context),
          );
        } else {
          return Column(
            children: pageChildren(constraints.biggest.width, context),
          );
        }
      },
    );
  }
}

class MobilehomePage extends StatelessWidget {
  List<Widget> pageChildren(double width, BuildContext context) {
    return <Widget>[
      Container(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Hi there!",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                  color: Colors.white),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 0),
              child: Text(
                "Thanks for using NoTechSupport developed by Temple University CIS 4398 NoTechSupport team! Before your search, please modify your Device Name, Brand, and Operating System, and then enter your question. Good Luck and hope you can get your device fixed soon!",
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
            MaterialButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MobilesearchPage(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 40.0),
                child: Text(
                  "Search!",
                  style: TextStyle(fontSize: 20.0, color: Colors.red),
                ),
              ),
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Image.asset(
          "assets/images/image1.png",
          width: width,
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: pageChildren(constraints.biggest.width / 2, context),
          );
        } else {
          return Column(
            children: pageChildren(constraints.biggest.width, context),
          );
        }
      },
    );
  }
}
