import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<String>> getRelatedSearches(String question) async {
  String urlString =
      'https://notechapi.aidanbuehler.net/related?query=' + question;
  Uri url = Uri.parse(urlString);

  try {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      if (response.body == "{}") return <String>[];
      List<dynamic> json = jsonDecode(response.body);
      List<String> relatedSearches =
          json.map((item) => item['text']).toList().cast<String>();
      return relatedSearches;
    } else {
      throw Exception('Failed to load related searches');
    }
  } catch (err) {
    throw Exception('Failed to load related searches\n' + err.toString());
  }
}
