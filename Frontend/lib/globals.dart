library globals;

import 'dart:convert';

//Class for return autocomplete list json
class Album {
  String RtnName;

  Album({
    required this.RtnName,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      RtnName: json['name'],
    );
  }
}

class comm {
  //load json to list for device model and brand
  static List<Album> loadJson(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<Album>((json) => Album.fromJson(json)).toList();
  }

  static String mydevice = '';
  static String mybrand = '';
  static String mymodel = '';
  //need delete
  static String what = '';
  static String when = '';
  static String why = '';
  ////////
  static String question = '';
  static String reviseQuestion = '';
  static String tempreviseQuestion = 'apple iphone 11 heating up';
  static String InitialGeneratedQuery =
      question + " " + mybrand + " " + mymodel + " " + mydevice;

  static double H=0, W=0;
}
