import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<String>> getRelatedSearches(String question) async {
  String urlString = 'http://notechapi.aidanbuehler.net/related?query='+question;
  Uri url = Uri.parse(urlString);

  try {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      
      List<dynamic> json = jsonDecode(response.body);
      if(json.length == 0) return <String>[];
      List<String> relatedSearches =
          json.map((e) => e['text']).toList().cast<String>();
      return relatedSearches;
    } else {
      throw Exception('Failed to load album');
    }
  } catch (err) {
    throw Exception('Failed to load album\n' + err.toString());
  }
}
