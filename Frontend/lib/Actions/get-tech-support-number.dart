import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:myapp/globals.dart' as globals;
import 'dart:convert';

Future<String> getTechSupportPhoneNumber() async {
  if (globals.comm.mybrand == '') return '';
  String urlString =
      'http://notechapi.aidanbuehler.net/brand?brand=' + globals.comm.mybrand;
  Uri url = Uri.parse(urlString);
  try {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      if (response.body.contains('error')) return '';
      dynamic json = jsonDecode(response.body);

      dynamic phoneNumber = json['phone'] as String;
      return phoneNumber;
    } else {
      throw Exception('Failed to get phone number');
    }
  } catch (err) {
    throw Exception('Failed to get phone number\n' + err.toString());
  }
}
