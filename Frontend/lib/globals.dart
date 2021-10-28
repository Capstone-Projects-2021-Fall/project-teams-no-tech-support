library globals;

import 'dart:convert';

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
  static List<Album> loadJson(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<Album>((json) => Album.fromJson(json)).toList();
  }
}
