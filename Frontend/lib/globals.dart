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

//Class for return RevisedQuery json
class TQuestion {
  String sDevice;
  String sBrand;
  String sModel;
  String sQuery;

  TQuestion({
    required this.sDevice,
    required this.sBrand,
    required this.sModel,
    required this.sQuery,
  });

  factory TQuestion.fromJson(Map<String, dynamic> json) {
    return TQuestion(
      sDevice: json['device'],
      sBrand: json['brand'],
      sModel: json['model'],
      sQuery: json['revisedQuery'],
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
  //need delete
  static String what = '';
  static String when = '';
  static String why = '';
  //////////
  static String question = '';
  static String reviseQuestion = '';

  static String InitialGeneratedQuery =
      question + " " + mybrand + " " + mymodel + " " + mydevice;
}
