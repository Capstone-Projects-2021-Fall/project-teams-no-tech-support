library globals;

import 'dart:convert';

//Class for return json
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
  //load json to list
  static List<Album> loadJson(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<Album>((json) => Album.fromJson(json)).toList();
  }

  static String mydevice = '';
  static String mybrand = '';
  static String mymodel = '';
  static String what = '';
  static String when = '';
  static String why = '';
}
