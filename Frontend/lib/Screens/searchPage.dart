import 'package:myapp/Screens/resultsPage.dart';
import 'package:myapp/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/Screens/questionFilteringPage.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'package:http/http.dart' as http;

class searchPage extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<searchPage> {
  bool isLoading = false;

  late List<String> autoCompleteData;
  late List<String> autoCompleteDataBrand;
  late List<String> autoCompleteDataModel;
  List<String> autoCompleteDataWhat = List.empty();
  List<String> autoCompleteDataWhen = List.empty();
  List<String> autoCompleteDataWhy = List.empty();
  late TextEditingController controller;
  late List<globals.Album> users;

  void getDevice() async {
    try {
      final response = await http.get(
          Uri.parse(
              'http://notechapi.aidanbuehler.net/suggestions?input=&prompt=device'),
          headers: {
            "Accept": "*/*",
            "Access-Control_Allow_Origin": "*",
            "Access-Control-Allow-Headers":
                "origin, x-requested-with, content-type",
            "Access-Control-Allow-Methods": "PUT, GET, POST, DELETE, OPTIONS"
          });

      if (response.statusCode == 200) {
        users = globals.comm.loadJson(response.body);

        var jsonStringData = <String>[];

        for (int i = 0; i < users.length; i++) {
          print(users[i].RtnName.toString());
          jsonStringData.insert(i, users[i].RtnName.toString());
        }
        autoCompleteData = jsonStringData;
        //print('autoCompleteData: ${autoCompleteData.length}');
      } else {
        print("Error getting users.");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void getBrand() async {
    try {
      if (globals.comm.mydevice == "") return;
      final response = await http.get(
          Uri.parse(
              'http://notechapi.aidanbuehler.net/suggestions?input=&prompt=brand&hint=' +
                  globals.comm.mydevice),
          headers: {
            "Accept": "*/*",
            "Access-Control_Allow_Origin": "*",
            "Access-Control-Allow-Headers":
                "origin, x-requested-with, content-type",
            "Access-Control-Allow-Methods": "PUT, GET, POST, DELETE, OPTIONS"
          });

      if (response.statusCode == 200) {
        users = globals.comm.loadJson(response.body);

        var jsonStringData = <String>[];

        for (int i = 0; i < users.length; i++) {
          jsonStringData.insert(i, users[i].RtnName.toString());
        }
        autoCompleteDataBrand = jsonStringData;
      } else {
        print("Error getting users.");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void getModel() async {
    if (globals.comm.mybrand == "") return;
    try {
      final response = await http.get(
          Uri.parse(
              'http://notechapi.aidanbuehler.net/suggestions?input=&prompt=model&hint=' +
                  globals.comm.mybrand +
                  '%7C' +
                  globals.comm.mydevice),
          headers: {
            "Accept": "*/*",
            "Access-Control_Allow_Origin": "*",
            "Access-Control-Allow-Headers":
                "origin, x-requested-with, content-type",
            "Access-Control-Allow-Methods": "PUT, GET, POST, DELETE, OPTIONS"
          });

      if (response.statusCode == 200) {
        users = globals.comm.loadJson(response.body);

        var jsonStringData = <String>[];

        for (int i = 0; i < users.length; i++) {
          print(users[i].RtnName.toString());
          jsonStringData.insert(i, users[i].RtnName.toString());
        }
        autoCompleteDataModel = jsonStringData;
      } else {
        print("Error getting users.");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future fetchAutoCompleteData() async {
    setState(() {
      isLoading = true;
    });

    getDevice();

    setState(() {
      isLoading = false;
      //autoCompleteData = List.empty();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchAutoCompleteData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Collection"),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 200),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(' '),
                  ),

                  //device
                  Autocomplete(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text.isEmpty) {
                        return const Iterable<String>.empty();
                      } else {
                        return autoCompleteData.where((word) => word
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
                      globals.comm.mydevice = selectedString.toString();
                      getBrand();
                    },
                    fieldViewBuilder:
                        (context, controller, focusNode, onEditingComplete) {
                      this.controller = controller;
                      controller.text = globals.comm.mydevice.toString();

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

                          hintText: "Select the device",
                          //hintText: globals.comm.mydevice,
                          prefixIcon: Icon(Icons.devices),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(0.5),
                    child: Text(' '),
                  ),
                  //Brand
                  Autocomplete(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text.isEmpty) {
                        return const Iterable<String>.empty();
                      } else {
                        return autoCompleteDataBrand.where((word) => word
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
                      globals.comm.mybrand = selectedString.toString();
                      getModel();
                    },
                    fieldViewBuilder:
                        (context, controller, focusNode, onEditingComplete) {
                      this.controller = controller;
                      controller.text = globals.comm.mybrand.toString();
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
                          hintText: "Select the brand",
                          //hintText: globals.comm.mybrand,
                          prefixIcon: Icon(Icons.home),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(0.5),
                    child: Text(' '),
                  ),

                  //Model
                  Autocomplete(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text.isEmpty) {
                        return const Iterable<String>.empty();
                      } else {
                        return autoCompleteDataModel.where((word) => word
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
                      globals.comm.mymodel = selectedString.toString();
                    },
                    fieldViewBuilder:
                        (context, controller, focusNode, onEditingComplete) {
                      this.controller = controller;
                      controller.text = globals.comm.mymodel.toString();

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
                          hintText: "Select the model",
                          //hintText: globals.comm.mymodel,
                          prefixIcon: Icon(Icons.account_tree),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(' '),
                  ),

                  // Card(
                  //   child: Padding(
                  //       padding: EdgeInsets.all(10.0),
                  //       child: Column(children: <Widget>[
                  //         //What is the problem
                  //         Autocomplete(
                  //           optionsBuilder:
                  //               (TextEditingValue textEditingValue) {
                  //             if (textEditingValue.text.isEmpty) {
                  //               return const Iterable<String>.empty();
                  //             } else {
                  //               return autoCompleteDataWhat.where((word) => word
                  //                   .toLowerCase()
                  //                   .contains(
                  //                       textEditingValue.text.toLowerCase()));
                  //             }
                  //           },
                  //           optionsViewBuilder: (context,
                  //               Function(String) onSelected, options) {
                  //             return Material(
                  //               elevation: 4,
                  //               child: ListView.separated(
                  //                 padding: EdgeInsets.zero,
                  //                 itemBuilder: (context, index) {
                  //                   final option = options.elementAt(index);
                  //                   return ListTile(
                  //                     // title: Text(option.toString()),
                  //                     title: SubstringHighlight(
                  //                       text: option.toString(),
                  //                       term: controller.text,
                  //                       textStyleHighlight: TextStyle(
                  //                           fontWeight: FontWeight.w700),
                  //                     ),
                  //                     onTap: () {
                  //                       onSelected(option.toString());
                  //                     },
                  //                   );
                  //                 },
                  //                 separatorBuilder: (context, index) =>
                  //                     Divider(),
                  //                 itemCount: options.length,
                  //               ),
                  //             );
                  //           },
                  //           onSelected: (selectedString) {
                  //             globals.comm.what = selectedString.toString();
                  //           },
                  //           fieldViewBuilder: (context, controller, focusNode,
                  //               onEditingComplete) {
                  //             this.controller = controller;

                  //             return TextField(
                  //               controller: controller,
                  //               focusNode: focusNode,
                  //               onEditingComplete: onEditingComplete,
                  //               decoration: InputDecoration(
                  //                 border: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(8),
                  //                   borderSide:
                  //                       BorderSide(color: Colors.grey[300]!),
                  //                 ),
                  //                 focusedBorder: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(8),
                  //                   borderSide:
                  //                       BorderSide(color: Colors.grey[300]!),
                  //                 ),
                  //                 enabledBorder: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(8),
                  //                   borderSide:
                  //                       BorderSide(color: Colors.grey[300]!),
                  //                 ),
                  //                 hintText: "What is the problem?",
                  //                 //prefixIcon: Icon(Icons.account_tree),
                  //               ),
                  //             );
                  //           },
                  //         ),
                  //         Padding(
                  //           padding: EdgeInsets.all(2.0),
                  //           child: Text(' '),
                  //         ),
                  //         //When does the problem occur
                  //         Autocomplete(
                  //           optionsBuilder:
                  //               (TextEditingValue textEditingValue) {
                  //             if (textEditingValue.text.isEmpty) {
                  //               return const Iterable<String>.empty();
                  //             } else {
                  //               return autoCompleteDataWhen.where((word) => word
                  //                   .toLowerCase()
                  //                   .contains(
                  //                       textEditingValue.text.toLowerCase()));
                  //             }
                  //           },
                  //           optionsViewBuilder: (context,
                  //               Function(String) onSelected, options) {
                  //             return Material(
                  //               elevation: 4,
                  //               child: ListView.separated(
                  //                 padding: EdgeInsets.zero,
                  //                 itemBuilder: (context, index) {
                  //                   final option = options.elementAt(index);

                  //                   return ListTile(
                  //                     // title: Text(option.toString()),
                  //                     title: SubstringHighlight(
                  //                       text: option.toString(),
                  //                       term: controller.text,
                  //                       textStyleHighlight: TextStyle(
                  //                           fontWeight: FontWeight.w700),
                  //                     ),
                  //                     onTap: () {
                  //                       onSelected(option.toString());
                  //                     },
                  //                   );
                  //                 },
                  //                 separatorBuilder: (context, index) =>
                  //                     Divider(),
                  //                 itemCount: options.length,
                  //               ),
                  //             );
                  //           },
                  //           onSelected: (selectedString) {
                  //             globals.comm.when = selectedString.toString();
                  //           },
                  //           fieldViewBuilder: (context, controller, focusNode,
                  //               onEditingComplete) {
                  //             this.controller = controller;

                  //             return TextField(
                  //               controller: controller,
                  //               focusNode: focusNode,
                  //               onEditingComplete: onEditingComplete,
                  //               decoration: InputDecoration(
                  //                 border: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(8),
                  //                   borderSide:
                  //                       BorderSide(color: Colors.grey[300]!),
                  //                 ),
                  //                 focusedBorder: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(8),
                  //                   borderSide:
                  //                       BorderSide(color: Colors.grey[300]!),
                  //                 ),
                  //                 enabledBorder: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(8),
                  //                   borderSide:
                  //                       BorderSide(color: Colors.grey[300]!),
                  //                 ),
                  //                 hintText: "When does the problem occur?",
                  //                 //prefixIcon: Icon(Icons.account_tree),
                  //               ),
                  //             );
                  //           },
                  //         ),
                  //         Padding(
                  //           padding: EdgeInsets.all(2.0),
                  //           child: Text(' '),
                  //         ),

                  //         //Why/What caused the problem
                  //         Autocomplete(
                  //           optionsBuilder:
                  //               (TextEditingValue textEditingValue) {
                  //             if (textEditingValue.text.isEmpty) {
                  //               return const Iterable<String>.empty();
                  //             } else {
                  //               return autoCompleteDataWhy.where((word) => word
                  //                   .toLowerCase()
                  //                   .contains(
                  //                       textEditingValue.text.toLowerCase()));
                  //             }
                  //           },
                  //           optionsViewBuilder: (context,
                  //               Function(String) onSelected, options) {
                  //             return Material(
                  //               elevation: 4,
                  //               child: ListView.separated(
                  //                 padding: EdgeInsets.zero,
                  //                 itemBuilder: (context, index) {
                  //                   final option = options.elementAt(index);

                  //                   return ListTile(
                  //                     // title: Text(option.toString()),
                  //                     title: SubstringHighlight(
                  //                       text: option.toString(),
                  //                       term: controller.text,
                  //                       textStyleHighlight: TextStyle(
                  //                           fontWeight: FontWeight.w700),
                  //                     ),
                  //                     onTap: () {
                  //                       onSelected(option.toString());
                  //                     },
                  //                   );
                  //                 },
                  //                 separatorBuilder: (context, index) =>
                  //                     Divider(),
                  //                 itemCount: options.length,
                  //               ),
                  //             );
                  //           },
                  //           onSelected: (selectedString) {
                  //             globals.comm.why = selectedString.toString();
                  //           },
                  //           fieldViewBuilder: (context, controller, focusNode,
                  //               onEditingComplete) {
                  //             this.controller = controller;

                  //             return TextField(
                  //               controller: controller,
                  //               focusNode: focusNode,
                  //               onEditingComplete: onEditingComplete,
                  //               decoration: InputDecoration(
                  //                 border: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(8),
                  //                   borderSide:
                  //                       BorderSide(color: Colors.grey[300]!),
                  //                 ),
                  //                 focusedBorder: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(8),
                  //                   borderSide:
                  //                       BorderSide(color: Colors.grey[300]!),
                  //                 ),
                  //                 enabledBorder: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(8),
                  //                   borderSide:
                  //                       BorderSide(color: Colors.grey[300]!),
                  //                 ),
                  //                 hintText: "Why/What caused the problem?",
                  //                 //prefixIcon: Icon(Icons.account_tree),
                  //               ),
                  //             );
                  //           },
                  //         ),
                  //       ])),
                  // ),

                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(' '),
                  ),
                  MaterialButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuestionOptimizationPage(
                              generatedQuestion: "Not quite there yet"), //
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 40.0),
                      child: Text(
                        "Continue!",
                        style: TextStyle(fontSize: 20.0, color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
