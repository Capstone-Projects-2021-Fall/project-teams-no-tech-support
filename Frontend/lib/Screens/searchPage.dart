import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:substring_highlight/substring_highlight.dart';

class searchPage extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<searchPage> {
  bool isLoading = false;

  late List<String> autoCompleteData;
  late TextEditingController controller;

  Future fetchAutoCompleteData() async {
    setState(() {
      isLoading = true;
    });

    final String stringData = await rootBundle.loadString("assets/data.json");

    final List<dynamic> json = jsonDecode(stringData);

    final List<String> jsonStringData = json.cast<String>();

    setState(() {
      isLoading = false;
      autoCompleteData = jsonStringData;
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
              padding: EdgeInsets.symmetric(vertical: 80.0, horizontal: 200),
              child: Column(
                children: <Widget>[
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
                          hintText: "Search Something",
                          prefixIcon: Icon(Icons.search),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
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
                    padding: EdgeInsets.all(10.0),
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
                    padding: EdgeInsets.all(10.0),
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
                    padding: EdgeInsets.all(10.0),
                    child: Text(' '),
                  ),            
                  MaterialButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                      onPressed: () {},
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
