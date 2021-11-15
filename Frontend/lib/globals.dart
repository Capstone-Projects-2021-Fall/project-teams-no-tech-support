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

class JJUser {
  final String name;
  final String email;

  JJUser(this.name, this.email);

  JJUser.fromJson(Map<String, dynamic> json)
      : name = json['device'],
        email = json['brand'];

  Map<String, dynamic> toJson() => {
        'device': name,
        'brand': email,
      };
}

//Class for return RevisedQuery json
// class TQuestion {
//   String sDevice;
//   String sBrand;
//   String sModel;
//   String sQuery;

//   TQuestion({
//     required this.sDevice,
//     required this.sBrand,
//     required this.sModel,
//     required this.sQuery,
//   });

//   factory TQuestion.fromJson(Map<String, dynamic> json) {
//     return TQuestion(
//       sDevice: json['device'],
//       sBrand: json['brand'],
//       sModel: json['model'],
//       sQuery: json['revisedQuery'],
//     );
//   }
// }

class comm {
  //load json to list for device model and brand
  static List<Album> loadJson(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<Album>((json) => Album.fromJson(json)).toList();
  }

  //load json to list for revise query device model and brand
  // static List<TQuestion> loadQuestionJson(String jsonString1) {
  //   final parsed1 = json.decode(jsonString1).cast<Map<String, dynamic>>();
  //   return parsed1.map<TQuestion>((json) => TQuestion.fromJson(json)).toList();
  // }

  static String mydevice = '';
  static String mybrand = '';
  static String mymodel = '';
  //need delete
  // static String what = '';
  // static String when = '';
  // static String why = '';
  //////////
  static String question = '';
  static String reviseQuestion = '';

  static String InitialGeneratedQuery =
      question + " " + mybrand + " " + mymodel + " " + mydevice;
}
