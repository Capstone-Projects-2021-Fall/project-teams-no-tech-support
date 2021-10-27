import 'dart:html';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:myapp/Screens/question_optimization.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'package:http/http.dart' as http;

class searchPage extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class DeviceAlbum {
  String Devicename;

  DeviceAlbum({
    required this.Devicename,
  });

  factory DeviceAlbum.fromJson(Map<String, dynamic> json) {
    return DeviceAlbum(
      Devicename: json['name'],
    );
  }
}

class _HomeScreenState extends State<searchPage> {
  bool isLoading = false;

  late List<String> autoCompleteData;
  late TextEditingController controller;
  late List<DeviceAlbum> users;

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
        users = loadUsers(response.body);

        var jsonStringData = <String>[];

        for (int i = 0; i < users.length; i++) {
          print(users[i].Devicename.toString());
          jsonStringData.insert(i, users[i].Devicename.toString());
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

  static List<DeviceAlbum> loadUsers(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed
        .map<DeviceAlbum>((json) => DeviceAlbum.fromJson(json))
        .toList();
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
        title: Text("iTechSupport"),
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
                              subtitle: Text("This is subtitle"),
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
                      print(selectedString);
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
                          hintText: "Select the device",
                          prefixIcon: Icon(Icons.devices),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(0.5),
                    child: Text(' '),
                  ),
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
                              subtitle: Text("This is subtitle"),
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
                      print(selectedString);
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
                          hintText: "Select the brand",
                          prefixIcon: Icon(Icons.home),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(0.5),
                    child: Text(' '),
                  ),
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
                              subtitle: Text("This is subtitle"),
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
                      print(selectedString);
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
                          hintText: "Select the model",
                          prefixIcon: Icon(Icons.account_tree),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(' '),
                  ),
                  Card(
                    child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(children: <Widget>[
                          Autocomplete(
                            optionsBuilder:
                                (TextEditingValue textEditingValue) {
                              if (textEditingValue.text.isEmpty) {
                                return const Iterable<String>.empty();
                              } else {
                                return autoCompleteData.where((word) => word
                                    .toLowerCase()
                                    .contains(
                                        textEditingValue.text.toLowerCase()));
                              }
                            },
                            optionsViewBuilder: (context,
                                Function(String) onSelected, options) {
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
                                        textStyleHighlight: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
                                      subtitle: Text("This is subtitle"),
                                      onTap: () {
                                        onSelected(option.toString());
                                      },
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      Divider(),
                                  itemCount: options.length,
                                ),
                              );
                            },
                            onSelected: (selectedString) {
                              print(selectedString);
                            },
                            fieldViewBuilder: (context, controller, focusNode,
                                onEditingComplete) {
                              this.controller = controller;

                              return TextField(
                                controller: controller,
                                focusNode: focusNode,
                                onEditingComplete: onEditingComplete,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Colors.grey[300]!),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Colors.grey[300]!),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Colors.grey[300]!),
                                  ),
                                  hintText: "What is the problem?",
                                  //prefixIcon: Icon(Icons.account_tree),
                                ),
                              );
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(' '),
                          ),
                          Autocomplete(
                            optionsBuilder:
                                (TextEditingValue textEditingValue) {
                              if (textEditingValue.text.isEmpty) {
                                return const Iterable<String>.empty();
                              } else {
                                return autoCompleteData.where((word) => word
                                    .toLowerCase()
                                    .contains(
                                        textEditingValue.text.toLowerCase()));
                              }
                            },
                            optionsViewBuilder: (context,
                                Function(String) onSelected, options) {
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
                                        textStyleHighlight: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
                                      subtitle: Text("This is subtitle"),
                                      onTap: () {
                                        onSelected(option.toString());
                                      },
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      Divider(),
                                  itemCount: options.length,
                                ),
                              );
                            },
                            onSelected: (selectedString) {
                              print(selectedString);
                            },
                            fieldViewBuilder: (context, controller, focusNode,
                                onEditingComplete) {
                              this.controller = controller;

                              return TextField(
                                controller: controller,
                                focusNode: focusNode,
                                onEditingComplete: onEditingComplete,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Colors.grey[300]!),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Colors.grey[300]!),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Colors.grey[300]!),
                                  ),
                                  hintText: "When does the problem occur?",
                                  //prefixIcon: Icon(Icons.account_tree),
                                ),
                              );
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(' '),
                          ),
                          Autocomplete(
                            optionsBuilder:
                                (TextEditingValue textEditingValue) {
                              if (textEditingValue.text.isEmpty) {
                                return const Iterable<String>.empty();
                              } else {
                                return autoCompleteData.where((word) => word
                                    .toLowerCase()
                                    .contains(
                                        textEditingValue.text.toLowerCase()));
                              }
                            },
                            optionsViewBuilder: (context,
                                Function(String) onSelected, options) {
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
                                        textStyleHighlight: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
                                      subtitle: Text("This is subtitle"),
                                      onTap: () {
                                        onSelected(option.toString());
                                      },
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      Divider(),
                                  itemCount: options.length,
                                ),
                              );
                            },
                            onSelected: (selectedString) {
                              print(selectedString);
                            },
                            fieldViewBuilder: (context, controller, focusNode,
                                onEditingComplete) {
                              this.controller = controller;

                              return TextField(
                                controller: controller,
                                focusNode: focusNode,
                                onEditingComplete: onEditingComplete,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Colors.grey[300]!),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Colors.grey[300]!),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Colors.grey[300]!),
                                  ),
                                  hintText: "Why/What caused the problem?",
                                  //prefixIcon: Icon(Icons.account_tree),
                                ),
                              );
                            },
                          ),
                        ])),
                  ),
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
                        "Search!",
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
