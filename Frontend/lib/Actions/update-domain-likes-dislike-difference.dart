import 'dart:developer';

import 'package:http/http.dart' as http;

Future<void> updateDomainLikeDislikeDifference(String baseDomainName, int like) async {
  String urlString =
      'http://notechapi.aidanbuehler.net/rate?domain=' + baseDomainName+ "&like="+ like.toString();
  Uri url = Uri.parse(urlString);
  try {
    http.Response response = await http.get(url);
    if (response.statusCode != 200) {
      throw Exception('Failed to load results');
    }
  } catch (err) {
    throw Exception('Failed to load results\n' + err.toString());
  }
}
