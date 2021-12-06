import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:myapp/globals.dart' as globals;
import 'dart:convert';

Future<String> getRevisedQuery() async {
  debugger();

  String urlString = 'https://notechapi.aidanbuehler.net/extract?query=' +
      globals.comm.question +
      globals.comm.mybrand +
      globals.comm.mydevice +
      globals.comm.mymodel;
  Uri url = Uri.parse(urlString);
  try {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      if (response.body.contains('error')) return '';
      dynamic json = jsonDecode(response.body);
//debugger();
      dynamic revisedQuery = json['revisedQuery'] as String;
      return revisedQuery == '' ? getFomulatedQuery() : revisedQuery;
    } else {
      throw Exception('Failed to get revised query');
    }
  } catch (err) {
    throw Exception('Failed to get revised query\n' + err.toString());
  }
}

String getFomulatedQuery() {
  // globals.comm.reviseQuestion = globals.comm.reviseQuestion.toLowerCase().replaceAll('computer', '');
  // globals.comm.reviseQuestion = globals.comm.reviseQuestion.toLowerCase().replaceAll('phone', '');
  if (globals.comm.mymodel.isNotEmpty) {
    return globals.comm.mybrand.toLowerCase() +
        " " +
        globals.comm.mymodel +
        " " +
        globals.comm.reviseQuestion;
  } else if (globals.comm.mybrand.isNotEmpty) {
    return globals.comm.mybrand.toLowerCase() +
        " " +
        globals.comm.reviseQuestion;
  } else if (globals.comm.mydevice.isNotEmpty) {
    return globals.comm.mydevice.toLowerCase() +
        " " +
        globals.comm.reviseQuestion;
  } else {
    return globals.comm.question;
  }
}
